//
//  OnMonthDay+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 01/03/2022.
//
//

import Foundation
import CoreData

@objc(OnMonthDay)
public class OnMonthDay: NSManagedObject
{
    convenience init()
        {
            self.init(context: AppController.controller.persistentContainer.viewContext)
            id = UUID()
            date = 0
        }
        
        func save()
        {
            AppController.controller.saveContext()
        }
}
