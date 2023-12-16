//
//  AfterNDays+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 01/03/2022.
//
//

import Foundation
import CoreData

@objc(AfterNDays)
public class AfterNDays: NSManagedObject
{
    convenience init()
        {
            self.init(context: AppController.controller.persistentContainer.viewContext)
            id = UUID()
        }
        
        func save()
        {
            AppController.controller.saveContext()
        }
}
