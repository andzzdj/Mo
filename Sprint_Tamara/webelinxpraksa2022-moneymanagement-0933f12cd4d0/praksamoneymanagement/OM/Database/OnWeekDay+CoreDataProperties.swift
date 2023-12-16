//
//  OnWeekDay+CoreDataProperties.swift
//  praksamoneymanagement
//
//  Created by Webelinx Praksa 1  on 17/03/2022.
//
//

import Foundation
import CoreData


extension OnWeekDay {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OnWeekDay> {
        return NSFetchRequest<OnWeekDay>(entityName: "OnWeekDay")
    }

    @NSManaged public var date: [String]?
    @NSManaged public var id: UUID?
    @NSManaged public var isForever: Bool
    @NSManaged public var repeatTransaction: Repeat?

}

extension OnWeekDay : Identifiable {

}
