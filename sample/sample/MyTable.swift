//
//  MyTable.swift
//  sample
//
//  Created by rarnu on 2018/7/18.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class MyTable: AdapterTableView<String> {
    override func register() {
        register(MyCell.classForCoder(), forCellReuseIdentifier: CELLNAME)
    }
}
