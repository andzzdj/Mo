//
//  TextField.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 18/03/2022.
//

import Foundation
import UIKit

extension UITextField
{
    
    // Implementation for Done button on numeric keyboard
    func addDoneButtonOnNumpad() {
            
        let keypadToolbar: UIToolbar = UIToolbar()
            
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(UITextField.resignFirstResponder))
        done.tintColor = .primaryColor
        keypadToolbar.items=[
            done,
            UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        ]
        keypadToolbar.sizeToFit()

        self.inputAccessoryView = keypadToolbar
    }
}
