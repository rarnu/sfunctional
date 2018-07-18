//
//  MyCell.swift
//  sample
//
//  Created by rarnu on 2018/7/18.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class MyCell: AdapterCell<String> {

    var lbl: UILabel?
    
    override func layout() {
        lbl = UILabel(frame: CGRect(x: 8, y: 0, width: self.bounds.size.width - 16, height: self.bounds.size.height))
        lbl?.textColor = UIColor.red
        self.addSubview(lbl!)
    }
    
    override func setItem(a: String?) {
        super.setItem(a: a)
        lbl?.text = a
    }
    
}
