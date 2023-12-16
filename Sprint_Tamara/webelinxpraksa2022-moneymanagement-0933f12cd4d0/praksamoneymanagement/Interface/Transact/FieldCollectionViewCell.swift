//
//  FieldCollectionViewCell.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 02/03/2022.
//

import UIKit


protocol FieldCellDelegate: AnyObject
{
    func fieldCell(_ fieldCell: FieldCollectionViewCell, textDidChangeTo text: String)
    func addDatePicker(date: Date)
    func setTextInRepeatTextField(text: String)
}   

class FieldCollectionViewCell: UICollectionViewCell
{
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var textFieldBottom_C: NSLayoutConstraint!
    
    let formatter = DateFormatter()
    let datePicker = UIDatePicker()
    
    weak var delegate: FieldCellDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        nameLbl.font = UIFont.systemFont(ofSize: 14)
        nameLbl.textColor = UIColor.primaryColor
        
        self.backgroundColor = UIColor.backgroundGrey
        
        configureTextField()
        
        textFieldBottom_C.constant = 5
        
        iconImage.image = UIImage(systemName: "chevron.right")
        iconImage.tintColor = UIColor.primaryColor
    
    }
    
    func createDatePicker()
    {
       
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        textField.inputView = datePicker
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let keypadToolbar: UIToolbar = UIToolbar()
            
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(donePressed))
        done.tintColor = .primaryColor
        keypadToolbar.items=[
            done,
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: textField, action: nil)
        ]
        keypadToolbar.sizeToFit()

        textField.inputAccessoryView = keypadToolbar

    }
    
    @objc func donePressed()
    {
        textField.text = formatter.string(from: datePicker.date)
        delegate?.addDatePicker(date: datePicker.date)
        textField.resignFirstResponder()
    }
    
    func configureTextField()
    {
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textColor = .label
        textFieldBottom_C.constant = 5
        textField.delegate = self
    }
        
    
    func setCell(cellInfo: FieldCellInfo)
    {
        nameLbl.text = cellInfo.name
        iconImage.isHidden = !cellInfo.isArrowVisible
        if cellInfo.numericKeyboard == true
        {
            textField.keyboardType = .numberPad
        }
        if cellInfo.doneButton == true
        {
            textField.addDoneButtonOnNumpad()
        }
        textField.isUserInteractionEnabled = cellInfo.userInteraction
        if cellInfo.isDatePicker == true
        {
            createDatePicker()
        }
    }
}

extension FieldCollectionViewCell : UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        delegate?.fieldCell(self, textDidChangeTo: textField.text ?? "")
        return true
    }
}
