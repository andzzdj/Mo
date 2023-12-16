//
//  RepeatViewController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 14/03/2022.
//

import UIKit
import SwiftUI
import CoreData

protocol repeatDelegate : AnyObject
{
    func repeatTextFiels()
}
class RepeatViewController: CustomPopUpViewController
{

    let cells = ["Never", "After N days", "On day in month", "On day in weak"]
    let week = Calendar.current.weekdaySymbols
    
    var repeatTransaction = Repeat()

    weak var delegate: FieldCellDelegate?
    
    @IBOutlet weak var Weekdays: UIView!
    @IBOutlet weak var WeekdaysLbl: UILabel!
    @IBOutlet weak var weekForeverLbl: UILabel!
    @IBOutlet weak var weekdaySwitch: UISwitch!
    @IBOutlet weak var weekCollectionView: UICollectionView!
    
    
    @IBOutlet weak var DaysInMonth: UIView!
    @IBOutlet weak var datePicker: UIPickerView!
    @IBOutlet weak var dIMLbl: UILabel!
    @IBOutlet weak var dIMforeverLbl: UILabel!
    @IBOutlet weak var daysInMonthSwitch: UISwitch!
    
    
    @IBOutlet weak var afterNDays: UIView!
    @IBOutlet weak var ANDTextField: UITextField!
    @IBOutlet weak var ANDForeverlbl: UILabel!
    @IBOutlet weak var ANDRepeatLbl: UILabel!
    @IBOutlet weak var afterNDayesSwitch: UISwitch!
    
    @IBOutlet weak var descriptLbl: UILabel!
    @IBOutlet weak var repeatLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var repeatPicker: UIPickerView!
    

    @IBAction func okPressed(_ sender: Any)
    {
        getRepeatAction(pickerView: repeatPicker, collectionView: weekCollectionView)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.view.clipsToBounds = true
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        okBtn.setTitle("", for: .normal)
        okBtn.setImage(UIImage(systemName: "checkmark"), for: .normal)
        okBtn.tintColor = .primaryColor
        okBtn.backgroundColor = .lightPurple
        okBtn.layer.cornerRadius = 20
        
        repeatLbl.text  = "Repeat"
        repeatLbl.textColor = .primaryColor
        repeatLbl.textAlignment = .center
        repeatLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        descriptLbl.text = "Do not repeat this transaction."
        //descriptLbl.textColor = .primaryColor
        descriptLbl.backgroundColor = .lightPurple
        descriptLbl.font = UIFont.systemFont(ofSize: 18)
        descriptLbl.layer.masksToBounds = true
        descriptLbl.layer.cornerRadius = 8
        descriptLbl.textAlignment = .center
        
        //repeatPicker.backgroundColor = .lightPurple
        
        
        datePicker.delegate = self
        datePicker.dataSource = self
        
        afterNDaysSet()
        daysInMonthSet()
        weekdaysSet()
        
        
    }

    
    func afterNDaysSet()
    {
        afterNDays.isHidden = true

        ANDRepeatLbl.text = "Repeat in days:"
        ANDRepeatLbl.font = UIFont.systemFont(ofSize: 25)
        ANDForeverlbl.text = "Forever"
        ANDForeverlbl.font = UIFont.systemFont(ofSize: 18)
        ANDTextField.keyboardType = .numberPad
        ANDTextField.delegate = self
        ANDTextField.addDoneButtonOnNumpad()
        
        
    }
    func daysInMonthSet()
    {
        DaysInMonth.isHidden = true
        
        dIMLbl.text = "Days in month"
        dIMLbl.font = UIFont.systemFont(ofSize: 25)
        dIMforeverLbl.text = "Forever"
        dIMforeverLbl.font = UIFont.systemFont(ofSize: 18)
        
        
    }
    func weekdaysSet()
    {
        Weekdays.isHidden = true
        
        WeekdaysLbl.text = "Weekdays"
        WeekdaysLbl.font = UIFont.systemFont(ofSize: 25)
        weekForeverLbl.text = "Forever"
        weekForeverLbl.font = UIFont.systemFont(ofSize: 18)
    }
    
    
    func getRepeatAction(pickerView: UIPickerView, collectionView: UICollectionView)
    {
        let selected = pickerView.selectedRow(inComponent: 0)
        switch selected
        {
        case 0:
           // repeatTransaction = nil
            break;
        case 1:
            let AfterNaDays = AfterNDays()
            AfterNaDays.days = Int32(ANDTextField.text!) ?? 0
            AfterNaDays.isForever = afterNDayesSwitch.isOn
            AfterNaDays.repeatTransaction = repeatTransaction
            AfterNaDays.save()
        case 2:
            let dayInMonth = OnMonthDay()
            dayInMonth.date = Int32(1 + datePicker.selectedRow(inComponent: 0))
            dayInMonth.isForever = daysInMonthSwitch.isOn
            dayInMonth.repeatTransaction = repeatTransaction
            dayInMonth.save()
        case 3 :
            let daysInWeek =  OnWeekDay()
            let numOfCells = collectionView.numberOfItems(inSection: 0)
            for i in 0...numOfCells
            {
                let cell = (collectionView.cellForItem(at: IndexPath(item: i, section: 0)) as? WeekdaysCollectionViewCell)
                if cell?.didSelect == true
                {
                    daysInWeek.date?.append(week[i])
                }
            }
            daysInWeek.isForever = weekdaySwitch.isOn
            daysInWeek.repeatTransaction = repeatTransaction
            daysInWeek.save()
        default:
            break
        }
        
        delegate?.setTextInRepeatTextField(text: cells[selected])
      
    }
}

extension RepeatViewController : UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if pickerView == repeatPicker
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == repeatPicker
        {
            return cells.count
        }
        else
        {
            return 31
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == repeatPicker
        {
            return ""
        }
        else
        {
            return  ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) ->    CGFloat
    {
        if pickerView == repeatPicker
        {
            return 200
        }
        else
        {
            return 40
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat
    {
        if pickerView == repeatPicker
        {
            return 40.0
        }
        else
        {
            return 20.0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView
    {
        if pickerView == repeatPicker
        {
            let label = UILabel()
            label.text = cells[row]
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 25)
            return label
        }
        else
        {
            let label = UILabel()
            label.text = "\(row + 1)."
            label.font = UIFont.systemFont(ofSize: 25)
            return label
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == repeatPicker
        {
            switch row
            {
            case 0:
                descriptLbl.text = "Do not repeat this transaction."
                afterNDays.isHidden = true
                DaysInMonth.isHidden = true
                Weekdays.isHidden = true
            case 1:
                descriptLbl.text = "After how many days do you wish this transaction to be repeated?"
                afterNDays.isHidden = false
                DaysInMonth.isHidden = true
                Weekdays.isHidden = true
            case 2:
                descriptLbl.text = "On which days in month do you wish this transaction to be repeated?"
                afterNDays.isHidden = true
                DaysInMonth.isHidden = false
                Weekdays.isHidden = true
            case 3:
                descriptLbl.text = "On which weekday do you wish this transaction to be repeated?"
                afterNDays.isHidden = true
                DaysInMonth.isHidden = true
                Weekdays.isHidden = false
            default:
                descriptLbl.text = ""
                
            }
            
        }

    }
    
}

extension RepeatViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return week.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeekdaysCollectionViewCell", for: indexPath) as! WeekdaysCollectionViewCell
        cell.setWeekday(text: week[indexPath.item])
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: getCellWidth(for : week[indexPath.item]), height: 60)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell  = collectionView.cellForItem(at: indexPath) as! WeekdaysCollectionViewCell
        if cell.didSelect == true
        {
            cell.setSelection(selected: false)
        }
        else
        {
            cell.setSelection(selected: true)
        }
        
    }
    
    func getCellWidth(for text: String)-> CGFloat
    {
        let attributedString = NSAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 18)])
        let size = attributedString.size()
        
        return size.width
    }

}

extension RepeatViewController : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
}
