//
//  Transaction+CoreDataClass.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 2 on 8.3.22..
//
//

import Foundation
import CoreData

@objc(Transaction)
public class Transaction: NSManagedObject {

    
    convenience init()
    {
        self.init(context: AppController.controller.persistentContainer.viewContext)
        
        name = ""
        amount = 0.0
        transactionDate = Date()
        dueDate = Date().addingTimeInterval(86400)
        
        id = UUID()
    }
    
    func save()
    {

        AppController.controller.saveContext()
    }
}
