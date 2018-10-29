//
//  SocketViewModel.swift
//  MVVM_POP_RxSwift_BasicApp
//
//  Created by Loud on 8/28/18.
//  Copyright © 2018 William Seaman. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

final class TestViewModel {
  
  private var testEntities = Variable<[TestEntity]>([])
  private var dataAccessProvider = DataAccessService()
  private var disposeBag = DisposeBag()

  init() {
    fetchAndUpdateObservable()
  }

  public func getTestEntityValues() -> Variable<[TestEntity]> {
    return testEntities
  }

  // MARK: - fetching Todos from Core Data and update observable todos
  private func fetchAndUpdateObservable() {
    dataAccessProvider.fetchObservableData()
      .map({ $0 })
      .subscribe(onNext : { (testValues) in
        self.testEntities.value = testValues
      })
      .disposed(by: disposeBag)
  }

  // MARK: - add new todo from Core Data
  public func addTestEntityValue(withVal testValue: Float) {
    dataAccessProvider.addTestValue(withValue: testValue)
  }

  // MARK: - toggle selected todo's isCompleted value
  public func toggleTestEntityIsCompleted(withIndex index: Int) {
    dataAccessProvider.toggleTodoIsCompleted(withIndex: index)
  }

  // MARK: - remove specified todo from Core Data
  public func removeTestEntityValue(withIndex index: Int) {
    dataAccessProvider.removeTestEntityObjext(withIndex: index)
  }
  
//  func updateTest(){
//   // Update a single value in Variable subject
//   americanSockets.value.first?.name.value = "First Value Updated!"
//
//    //  use CompactMap(aka FlatMap) to update one or more values in Variable subject
//    americanSockets.value.compactMap{ socket -> (Socket) in
//      if socket.position.value == 1 {
//        socket.name.value = "Second Value Update!"
//        debugPrint(socket.name.value)
//      }
//      return socket
//    }
//  }
  
  
}
