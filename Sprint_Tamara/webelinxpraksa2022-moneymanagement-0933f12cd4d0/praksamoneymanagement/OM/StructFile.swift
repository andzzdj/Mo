//
//  StructFile.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 18/03/2022.
//

import Foundation
import UIKit

public struct FieldCellInfo: Decodable
{
    var name: String = ""
    var userInteraction : Bool = false
    var numericKeyboard : Bool = false
    var isArrowVisible: Bool = false
    var doneButton : Bool = false
    var isDatePicker: Bool = false
    
}

public struct Period: Decodable
{
    var startDate: Date
    var endDate: Date
    init(start: Date, end: Date)
    {
        startDate = start
        endDate = end
    }
    
}
