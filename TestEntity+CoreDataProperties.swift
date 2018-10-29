//
//  TestEntity+CoreDataProperties.swift
//  MVVM_Rx_CoreData_TestProject
//
//  Created by Loud on 10/28/18.
//  Copyright © 2018 William Seaman. All rights reserved.
//
//

import Foundation
import CoreData
import RxSwift

extension TestEntity {

    @nonobjc public class func testEntityFetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var testValue: Float
}

