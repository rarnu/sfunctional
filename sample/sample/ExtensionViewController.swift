//
//  ExtensionViewController.swift
//  sample
//
//  Created by rarnu on 2018/8/30.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class ExtensionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Extension"
        
        // extension
        func makeButton(_ top: CGFloat, _ title: String, _ tag: Int) {
            let btn = UIButton(type: UIButtonType.system)
            btn.frame = CGRect(x: 8, y: top, width: screenWidth() - 16, height: 30)
            btn.setTitle(title, for: UIControlState.normal)
            btn.addTarget(self, action: #selector(btnClicked(_:)), for: UIControlEvents.touchDown)
            btn.tag = tag
            self.view.addSubview(btn)
        }
        
        let top = navigationbarHeight() + statusbarSize().height + 8
        makeButton(top, "String", 0)
        makeButton(top + 30, "Color", 1)
        makeButton(top + 60, "Alert 1", 2)
        makeButton(top + 90, "Alert 2", 3)
        makeButton(top + 120, "Alert 3", 4)
        makeButton(top + 150, "Alert 4", 5)
        makeButton(top + 180, "Alert 5", 6)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func btnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
             var s = "aaa"
             s = s.insert(idx: 2, sub: "bbb")
             print(s)
             s = s.remove(idx: 2, length: 3)
             print(s)
             s = "abcdefg"
             s = s.sub(start: 3)
             print(s)
             s = "abcdefg"
             s = s.sub(start: 3, length: 2)
             print(s)
             s = "abcdefgabcdefg"
             let idx = s.indexOf(sub: "de")
             print(idx)
             let idx2 = s.indexOf(sub: "de", start: 6)
             print(idx2)
             let idx3 = s.lastIndexOf(sub: "de")
             print(idx3)
             s = "a,,bc,,def,,ghij"
             let sarr = s.split(by: ",,")
             print(sarr)
             s = "a,,bc,,def,,ghij"
             s = s.trim(c:["i", "j", "a"])
             print(s)
            break
        case 1:
            let c = UIColor().parseString("#FF0000")
            print(c)
            break
        case 2:
            alert(title: "title", message: "message", btn: "ok") {
                print("ok clicked")
            }
            break
        case 3:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel") { which in
                print("clicked \(which)")
            }
            break
        case 4:
            alert(title: "title", message: "message", btn1: "btn1", btn2: "btn2", btn3: "btn3") { which in
                print("clicked \(which)")
            }
            break
        case 5:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel", placeholder: "input text", initText: "") { (which, text) in
                print("clicked \(which)")
                print("text :\(text!)")
            }
            break
        case 6:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel", placeholder1: "account", placeholder2: "password", initText1: "", initText2: "") { (which, text1, text2) in
                print("clicked \(which)")
                print("text1 :\(text1!)")
                print("text2 :\(text2!)")
            }
            break
        default:
            break
        }
    }
}
