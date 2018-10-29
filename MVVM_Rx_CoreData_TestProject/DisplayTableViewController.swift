//
//  DisplayTableViewController.swift
//  MVVM_POP_RxSwift_BasicApp
//
//  Created by Loud on 8/28/18.
//  Copyright © 2018 William Seaman. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DisplayTableViewController: UIViewController{
	
  @IBOutlet weak var tableView: UITableView!
	
	//RxSwift
	let testViewModel = TestViewModel()
	let disposeBag = DisposeBag()

	override func viewDidLoad() {
			super.viewDidLoad()
      setupCellConfiguration()
	}
  
	// MARK: loads table view cells - and updates when view model changes - Reactive setup (RxSwift)
	private func setupCellConfiguration() {
    
    testViewModel.getTestEntityValues().asObservable().bind(to: tableView.rx.items) { (tableView, row, element) in
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: IndexPath(row: row, section: 0)) as! UITableViewCell
      // configure cell - TODO: Need to make each entity property a subject to be observed, see below
      cell.textLabel?.text = String(element.testValue)
      return cell
      }
      .disposed(by: disposeBag)
    
////This is giving a compile error
//    testViewModel.getTestEntityValues().asObservable().bind(to: tableView
//    .rx
//    .items(cellIdentifier: "cell",
//           cellType: UITableViewCell.self)) {
//            row, testEntity, cell in
//            //add observable to socket name(Variable(string)), to subscribe to property updates
//            testEntity.name.asObservable().subscribe({ val in
//              cell.textLabel?.text = val.element
//              }
//            )
//    }
//    .disposed(by: disposeBag)
	}
  
//  private func populateTodoListTableView() {
//    var observableTodos = todoListViewModel.getTodos().asObservable()
//    
//    observableTodos.bindTo(todoListTableView.rx.items(cellIdentifier: "todoCellIdentifier", cellType: UITableViewCell.self)) { (row, element, cell) in
//      
//      cell.textLabel?.text = element.todo
//      
//      if element.isCompleted {
//        cell.accessoryType = .checkmark
//      } else {
//        cell.accessoryType = .none
//      }
//      
//      }
//      .addDisposableTo(disposeBag)
//    
//  }
	
	
	@IBAction func updateModel() {
    testViewModel.addTestEntityValue(withVal: 100.99)
    //Add or remove socket object
    //let s = Socket(name: Variable("new object"), position: Variable(5), delay: 0, voltage: 120)
		//socketsViewModel.americanSockets.value.append(s)
		//socketsViewModel.sockets.value.remove(at: 1)
		//socketsViewModel.sockets.value.insert(s, at: 3)
    
    //Update a single property in the collection
    //socketsViewModel.updateTest()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	


}
