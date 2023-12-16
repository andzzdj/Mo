//
//  Account+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 16.3.22..
//
//

import Foundation
import CoreData

@objc(Account)
public class Account: NSManagedObject
{
    convenience init()
    {
        self.init(context: AppController.controller.persistentContainer.viewContext)
        id = UUID()
        name = ""
        currency = "RSD"
        shouldCalculateMoneyPerDay = true
        balance = 0.0
    }
    
    func save()
    {

        AppController.controller.saveContext()
    }
}
