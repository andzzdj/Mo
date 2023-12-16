//
//  AccountCell.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 2.3.22..
//

import UIKit


class AccountCell: UICollectionViewCell
{
    //COMM: [MASHA] dodati edit button koji je vidljiv samo ako je account selektovan
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var editAccountButton: UIButton!
    @IBOutlet weak var viewTrailing: NSLayoutConstraint!
    var isNew = false

    
    @IBOutlet weak var buttonWidth_c: NSLayoutConstraint!
    
    override var isSelected: Bool
    {
        didSet
        {
            setupSelected(selected: isSelected)
        }
    }
    
    func set(text: String)
    {
        nameLbl.text = text
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        nameLbl.font = UIFont.systemFont(ofSize: 18)
        nameLbl.textColor = UIColor.black
        nameLbl.layer.masksToBounds = true
        self.backgroundColor = .clear
        
        editAccountButton.isHidden = true
        editAccountButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editAccountButton.tintColor = .black
        editAccountButton.setTitle(nil, for: .normal)
        buttonWidth_c.constant = 0
    }
    
    func setupSelected(selected: Bool)
    {
        if selected
        {
            nameLbl.textColor = UIColor.primaryColor
            nameLbl.backgroundColor = UIColor.white
            nameLbl.layer.cornerRadius = 10
            editAccountButton.isHidden = false
            buttonWidth_c.constant = 30
        }
        else
        {
            nameLbl.textColor = UIColor.black
            nameLbl.backgroundColor = .clear
            editAccountButton.isHidden = true
            buttonWidth_c.constant = 0
        }
    }
}

