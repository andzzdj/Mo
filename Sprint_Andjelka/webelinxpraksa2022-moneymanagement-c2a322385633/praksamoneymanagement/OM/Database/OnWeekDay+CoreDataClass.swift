//
//  OnWeekDay+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 21.3.22..
//
//

import Foundation
import CoreData

@objc(OnWeekDay)
public class OnWeekDay: NSManagedObject
{
    convenience init()
    {
        self.init(context: AppController.controller.persistentContainer.viewContext)
        id = UUID()
        date = [String]()
    }
    
    func save()
    {
        AppController.controller.saveContext()
    }
}
