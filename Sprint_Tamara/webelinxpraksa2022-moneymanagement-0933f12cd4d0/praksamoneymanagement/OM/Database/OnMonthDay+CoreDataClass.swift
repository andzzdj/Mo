//
//  OnMonthDay+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 17/03/2022.
//
//

import Foundation
import CoreData

@objc(OnMonthDay)
public class OnMonthDay: NSManagedObject
{
    convenience init() {
        self.init(context: AppController.controller.persistentContainer.viewContext)
        
        id = UUID()
        
    }
    func save()
    {
        AppController.controller.saveContext()
    }
}
