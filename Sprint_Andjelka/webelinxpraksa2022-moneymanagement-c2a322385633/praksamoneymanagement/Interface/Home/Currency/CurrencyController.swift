//
//  CurrencyController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 15.3.22..
//

import UIKit
import SwiftUI

//COMM: [MASHA] rasclaniti controllere u foldere
class CurrencyController: CustomPopUpViewController
{

    @IBOutlet weak var checkButton: RoundedButton!
    @IBOutlet weak var currencyPickerView: UIPickerView!
    @IBOutlet weak var currencyTextField: UITextField!
    
    var cells:[Currency] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        checkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        
        checkButton.tintColor = .primaryColor
        checkButton.backgroundColor = .lightPurple
    
        startLoad { _currencies in
            
            for currency in _currencies
            {
                self.cells.append(currency)
                print(currency)
            }
            DispatchQueue.main.async
            {

                self.currencyPickerView.reloadAllComponents()
            }
        }
    }
    
    
    
    
    
    
    
    @IBAction func onCheckMarkButtonClick(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func startLoad(completionHandler: @escaping ([Currency]) -> Void)
    {
        
        let currencyUrl = URL(string: "https://milenica.info/NEWCMS/countriesList.json")
        if(currencyUrl != nil)
        {
            let task = URLSession.shared.dataTask(with: currencyUrl!) { data, response, error in
                if let error = error {
                    print("Error!")
                //self.handleClientError(error)
                return
            }
            if let data = data
            {
                do
                {
                    let currencies = try JSONDecoder().decode(Wrapper.self, from: data).countries
                    completionHandler(currencies)
                }
                catch{}
            }
        }
        task.resume()
        
        }
        else
        {
            print("Error: No URL!")
        }
        
    }


}

//COMM: [MASHA] Wrapper da bude definisan unutar controllera, a svi globalni structovi u jednom fajlu koji Structs-Ispravljeno
struct Wrapper: Decodable
{
    var countries = [Currency]()
}



extension CurrencyController : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return cells.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) ->    CGFloat
    {
        return 200
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        return 40.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        let label = UILabel()
        label.text = cells[row].short + " " + cells[row].name
        label.textAlignment = .center
        label.textColor = .primaryColor
        label.font = UIFont.systemFont(ofSize: 25)
        pickerView.backgroundColor = .lightPurple
        pickerView.layer.cornerRadius = 10
        pickerView.layer.masksToBounds = true
        return label
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
    }
    
}
extension CurrencyController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
