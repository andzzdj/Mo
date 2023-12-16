//
//  CustomPopUpViewController.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 01/03/2022.
//

import UIKit

class CustomPopUpViewController: UIViewController
{
    @IBOutlet weak var containerViewBottom_c: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bgdView: UIView!
    
   
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        bgdView.addGestureRecognizer(tapGesture)
        bgdView.isUserInteractionEnabled = true
    }
    
    @objc func close()
    {
        self.dismiss(animated: true, completion: nil)
    }
    

    @objc func keyboardWillShow(_ notification: Notification)
   {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            containerViewBottom_c.constant = keyboardHeight
            
            
            
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()
            }
        }
   }
    
    @objc func keyboardWillHide(_ notification: Notification )
    {
            containerViewBottom_c.constant = 0
            UIView.animate(withDuration: 0.2) {
                self.view.layoutIfNeeded()

        }
    }
    

}
