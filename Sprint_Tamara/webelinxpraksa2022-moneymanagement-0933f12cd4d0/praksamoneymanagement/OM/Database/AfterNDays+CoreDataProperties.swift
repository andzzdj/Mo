//
//  AfterNDays+CoreDataProperties.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 17/03/2022.
//
//

import Foundation
import CoreData


extension AfterNDays {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AfterNDays> {
        return NSFetchRequest<AfterNDays>(entityName: "AfterNDays")
    }

    @NSManaged public var days: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var isForever: Bool
    @NSManaged public var repeatTransaction: Repeat?

}

extension AfterNDays : Identifiable {

}
