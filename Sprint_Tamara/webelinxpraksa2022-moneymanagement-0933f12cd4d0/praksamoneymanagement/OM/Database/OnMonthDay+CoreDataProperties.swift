//
//  OnMonthDay+CoreDataProperties.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 17/03/2022.
//
//

import Foundation
import CoreData


extension OnMonthDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OnMonthDay> {
        return NSFetchRequest<OnMonthDay>(entityName: "OnMonthDay")
    }

    @NSManaged public var date: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isForever: Bool
    @NSManaged public var repeatTransaction: Repeat?

}

extension OnMonthDay : Identifiable {

}
