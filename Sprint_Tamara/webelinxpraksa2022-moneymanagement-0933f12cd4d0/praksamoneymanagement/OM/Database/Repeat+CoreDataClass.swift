//
//  Repeat+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 01/03/2022.
//
//

import Foundation
import CoreData

@objc(Repeat)
public class Repeat: NSManagedObject
{
    convenience init() {
   
        self.init(context: AppController.controller.persistentContainer.viewContext)
        
        id = UUID()
        
        endDate = Date()
        startDate = Date()
    }
}
