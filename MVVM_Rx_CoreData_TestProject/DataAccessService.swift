//
//  DataAccessService.swift
//  MVVM_Rx_CoreData_TestProject
//
//  Created by Loud on 10/28/18.
//  Copyright © 2018 William Seaman. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

class DataAccessService {
  
  let valuesFromCoreData = Variable<[TestEntity]>([])
  private var managedObjectContext : NSManagedObjectContext
  
  init() {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    valuesFromCoreData.value = [TestEntity]()
    managedObjectContext = delegate.persistentContainer.viewContext
    
    valuesFromCoreData.value = fetchData()
  }
  
  // MARK: - fetching Todos from Core Data and update observable todos
  private func fetchData() -> [TestEntity] {
    let todoFetchRequest = TestEntity.testEntityFetchRequest()
    todoFetchRequest.returnsObjectsAsFaults = false
    
    do {
      return try managedObjectContext.fetch(todoFetchRequest)
    } catch {
      return []
    }
    
  }
  
  // MARK: - return observable todo
  public func fetchObservableData() -> Observable<[TestEntity]> {
    valuesFromCoreData.value = fetchData()
    return valuesFromCoreData.asObservable()
  }
  
  // MARK: - add new todo from Core Data
  public func addTestValue(withValue value: Float) {
    let newTestEntity = NSEntityDescription.insertNewObject(forEntityName: "TestEntity", into: managedObjectContext) as! TestEntity
    
    newTestEntity.testValue = value
    //newTestEntity.isCompleted = false
    
    do {
      try managedObjectContext.save()
      valuesFromCoreData.value = fetchData()
    } catch {
      fatalError("error saving data")
    }
  }
  
  // MARK: - toggle selected todo's isCompleted value
  public func toggleTodoIsCompleted(withIndex index: Int) {
    //valuesFromCoreData.value[index].isCompleted = !valuesFromCoreData.value[index].isCompleted
    
    do {
      try managedObjectContext.save()
      valuesFromCoreData.value = fetchData()
    } catch {
      fatalError("error change data")
    }
    
  }
  
  // MARK: - remove specified todo from Core Data
  public func removeTestEntityObjext(withIndex index: Int) {
    managedObjectContext.delete(valuesFromCoreData.value[index])
    
    do {
      try managedObjectContext.save()
      valuesFromCoreData.value = fetchData()
    } catch {
      fatalError("error delete data")
    }
  }
  
}

