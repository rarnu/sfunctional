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
    private let console = UITextView(frame: CGRect(x: 0, y: screenHeight() - 120, width: screenWidth(), height: 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AdapterTableView"
        let tb = MyTable(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight() - 120))
        tb.adapterDelegate = self
        tb.refreshDelegate = self
        tb.pulldownRefresh(true)
        self.view.addSubview(tb)
        tb.assignList(arr: arr)
        tb.reloadData()
        
        console.layoutManager.allowsNonContiguousLayout = false
        console.isEditable = false
        console.text = ""
        self.view.addSubview(console)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addConsoleLog(_ txt: String) {
        self.mainThread {
            self.console.text = self.console.text + txt + "\n"
            self.console.scrollRangeToVisible(NSRange(location: self.console.text.count, length: 1))
        }
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, clickAt indexPath: IndexPath) {
        addConsoleLog("clicked: \(tableView.list[indexPath.row])")
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, longPressAt indexPath: IndexPath) {
        addConsoleLog("long press: \(tableView.list[indexPath.row])")
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, pulldown list: inout Array<T>) {
        let s = String(format: "%d", arguments: [arc4random()])
        list.append(s as! T)
    }
}
