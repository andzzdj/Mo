//
//  CreateAccountControllerViewController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 15.3.22..
//

import UIKit



class CreateAccountViewController: CustomPopUpViewController
{


    @IBOutlet weak var checkMarkButton: RoundedButton!
    @IBOutlet weak var calculateMoneyPerDayLbl: UIView!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var deleteAccountButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currencyTextField: UITextField!
    @IBOutlet weak var calculateMoneyPerDaySwitch: UISwitch!
    
   // var testAccount = Account()
    var accountFromHome: Account?
    var account: Account?
    var isNew = false
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        /*do
        {
            let accounts = try AppController.controller.persistentContainer.viewContext.fetch(Account.fetchRequest())
            
        }*/
        //catch{}

        if accountFromHome == nil
        {
            isNew = true
            deleteAccountButton.isHidden = true
            account = Account()
            account?.name = nameTextField.text
            account?.currency = currencyTextField.text
            account?.shouldCalculateMoneyPerDay = calculateMoneyPerDaySwitch.isOn
            account?.balance = 0.0

        }
        else
        {
            isNew = false
            deleteAccountButton.isHidden = false
            nameTextField.text = accountFromHome?.name
            currencyTextField.text = accountFromHome?.currency
        }
        
        
        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        checkMarkButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        checkMarkButton.tintColor = .primaryColor
        checkMarkButton.backgroundColor = .lightPurple
        
        calculateMoneyPerDayLbl.layer.cornerRadius = 10
        calculateMoneyPerDayLbl.layer.masksToBounds = true
        calculateMoneyPerDayLbl.backgroundColor = .lightPurple
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.tapFunction))
        currencyLabel.isUserInteractionEnabled = true
        currencyLabel.addGestureRecognizer(tap)
    }
    
    func setAccount(account: Account)
    {
        accountFromHome = account
    }
    
    @objc
        func tapFunction(sender:UITapGestureRecognizer) {
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyController") as? CurrencyController
            {
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
    
    @IBAction func onCheckMarkClick(_ sender: Any)
    {
        
        
      //  account?.transaction = nil

        //print("SAVE \(testAccount.name)")
        account?.save()
        
        self.dismiss(animated: true, completion: nil)
        
        // To save the new entity to the persistent store, call
        // save on the context

    }
    @IBAction func onDeleteBtnClick(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
        //Ovde delegat koji ce da brise account i da ga brise iz niza u view controlleru
    }
    
}




