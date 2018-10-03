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

    private let console = UITextView(frame: CGRect(x: 0, y: screenHeight() - 120, width: screenWidth(), height: 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Extension"
        
        // extension
        func makeButton(_ top: CGFloat, _ title: String, _ tag: Int) {
            let btn = UIButton(type: UIButton.ButtonType.system)
            btn.frame = CGRect(x: 8, y: top, width: screenWidth() - 16, height: 30)
            btn.setTitle(title, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(btnClicked(_:)), for: UIControl.Event.touchDown)
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
    
    @objc func btnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
             var s = "aaa"
             s = s.insert(idx: 2, sub: "bbb")
             addConsoleLog(s)
             s = s.remove(idx: 2, length: 3)
             addConsoleLog(s)
             s = "abcdefg"
             s = s.sub(start: 3)
             addConsoleLog(s)
             s = "abcdefg"
             s = s.sub(start: 3, length: 2)
             addConsoleLog(s)
             s = "abcdefgabcdefg"
             let idx = s.indexOf(sub: "de")
             addConsoleLog("\(idx)")
             let idx2 = s.indexOf(sub: "de", start: 6)
             addConsoleLog("\(idx2)")
             let idx3 = s.lastIndexOf(sub: "de")
             addConsoleLog("\(idx3)")
             s = "a,,bc,,def,,ghij"
             let sarr = s.split(by: ",,")
             addConsoleLog("\(sarr)")
             s = "a,,bc,,def,,ghij"
             s = s.trim(c:["i", "j", "a"])
             addConsoleLog(s)
             s = "abcdefg"
             s = s.charAt(index: 1)
             addConsoleLog("charAt => \(s)")
            break
        case 1:
            let c = UIColor().parseString("#FF0000")
            addConsoleLog("\(c)")
            break
        case 2:
            alert(title: "title", message: "message", btn: "ok", isDark: true) {
                self.addConsoleLog("ok clicked")
            }
            break
        case 3:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel", isDark: true) { which in
                self.addConsoleLog("clicked \(which)")
            }
            break
        case 4:
            alert(title: "title", message: "message", btn1: "btn1", btn2: "btn2", btn3: "btn3", isDark: true) { which in
                self.addConsoleLog("clicked \(which)")
            }
            break
        case 5:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel", placeholder: "input text", initText: "", isDark: true) { (which, text) in
                self.addConsoleLog("clicked \(which)")
                self.addConsoleLog("text :\(text!)")
            }
            break
        case 6:
            alert(title: "title", message: "message", btn1: "ok", btn2: "cancel", placeholder1: "account", placeholder2: "password", initText1: "", initText2: "", isDark: true) { (which, text1, text2) in
                self.addConsoleLog("clicked \(which)")
                self.addConsoleLog("text1 :\(text1!)")
                self.addConsoleLog("text2 :\(text2!)")
            }
            break
        default:
            break
        }
    }
}
