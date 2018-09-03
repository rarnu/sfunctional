//
//  AdapterTableViewController.swift
//  sample
//
//  Created by rarnu on 2018/8/30.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class AdapterTableViewController: UIViewController, AdapterTableViewDelegate, AdapterTableViewRefreshDelegate {

    var arr = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AdapterTableView"
        let tb = MyTable(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight()))
        tb.adapterDelegate = self
        tb.refreshDelegate = self
        tb.pulldownRefresh(true)
        self.view.addSubview(tb)
        tb.assignList(arr: arr)
        tb.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, clickAt indexPath: IndexPath) {
        print("clicked: \(tableView.list[indexPath.row])")
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, longPressAt indexPath: IndexPath) {
        print("long press: \(tableView.list[indexPath.row])")
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, pulldown list: inout Array<T>) {
        let s = String(format: "%d", arguments: [arc4random()])
        list.append(s as! T)
    }
}
