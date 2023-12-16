//
//  AfterNDays+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 17/03/2022.
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
        isForever = false
        
    }
    func save()
    {
        AppController.controller.saveContext()
    }
}
