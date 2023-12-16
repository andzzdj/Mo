//
//  WeekdaysCollectionViewCell.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 15/03/2022.
//

import UIKit

class WeekdaysCollectionViewCell: UICollectionViewCell
{
    var didSelect: Bool!
    
    @IBOutlet weak var weekdayLbl: UILabel!
    
    @IBOutlet weak var selectImage: UIImageView!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        weekdayLbl.backgroundColor = .white
        weekdayLbl.font = UIFont.systemFont(ofSize: 17)
        didSelect = false
        selectImage.image = UIImage(systemName: "capsule")
        selectImage.tintColor = .primaryColor
        selectImage.isHidden = true
        
    }
    func setWeekday(text: String)
    {
        weekdayLbl.text = text
    }
    func setSelection(selected: Bool)
    {
        selectImage.isHidden = !selected
        didSelect = selected
    }
}
