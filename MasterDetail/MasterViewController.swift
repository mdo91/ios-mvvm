//
//  MasterViewController.swift
//  MasterDetail
//
//  Created by Mdo on 06/09/2020.
//  Copyright © 2020 Mdo. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
   // var objects = [Any]()
    var presenter = Presenter()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        // observe notification
        tableView.dataSource = self
        
         NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateUI"), object: nil, queue: OperationQueue.main) { (notification) in

             self.tableView.reloadData()
            
        }
        
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateUI"), object: nil, queue: OperationQueue.main) { (notification) in
//
//            self.tableView.reloadData()
//
//        }
        

        

    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    @objc
    func insertNewObject(_ sender: Any) {
        //objects.insert(NSDate(), at: 0)
        presenter.addEntry()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
 
        
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
              //  let object = objects[indexPath.row] as! NSDate
                guard let dateItem = presenter[indexPath.row] else{
                    return
                }
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = dateItem
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    

}

