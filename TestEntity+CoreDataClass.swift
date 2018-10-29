//
//  TestEntity+CoreDataClass.swift
//  MVVM_Rx_CoreData_TestProject
//
//  Created by Loud on 10/28/18.
//  Copyright © 2018 William Seaman. All rights reserved.
//
//

import Foundation
import CoreData
import AlamofireObjectMapper
import ObjectMapper
import RxSwift

@objc(TestEntity)
public class TestEntity: NSManagedObject, Mappable {

  override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
    super.init(entity: entity, insertInto: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
  }
  
  required public init?(map: Map) {
    
    let entity = NSEntityDescription.entity(forEntityName: "TestEntity", in: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    
    if let dataEntity = entity {
      super.init(entity: dataEntity, insertInto: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    } else {
      super.init()
    }
  }
  
  public func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    testValue <- map["value"]
  }

}
