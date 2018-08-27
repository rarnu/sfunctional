//
//  ViewController.swift
//  sample
//
//  Created by rarnu on 26/03/2018.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        testurl("https://www.baidu.com:1234/uri/suburi?p1=a&p2=b")
        testurl("https://www.baidu.com:1234/uri/suburi?p1=&p2=b")
        testurl("https://www.baidu.com/uri/suburi?p1=a&p2=b")
        testurl("https://www.baidu.com:1234/suburi")
        testurl("https://www.baidu.com")
        testurl("www.baidu.com:1234")
        testurl("www.baidu.com")
        
        /*
        let emu = isEmulator()
        print("emu => \(emu)")
        
        thread {
            // do something in a sub thread
            self.mainThread {
                // do something in main thread
            }
            // do something in a sub thread
        }
        
        // http
        let param = ["action":"login", "account":"rarnu", "password":"96e79218965eb72c92a549dd5a330112"]
        http("http://120.27.9.223/account", method: "POST", postParam: param) { (_ code: Int, _ result: String?, _ error: String?) in
            print(code)
            print(result!)
        }
        
        // download
        download("https://res.hjfile.cn/pt/hj/images/logo.png", documentPath(true) + "a.png") { (state, position, fileSize, error) in
            print("\(state), \(position), \(fileSize)")
            if (state == DownloadState.Error) {
                print("Download Error => \(error!)")
            }
        }
        
        var dt = Data() as Any
        
        fileIO(src: "try1", dest: dt, isSrcText: true) { (succ, data, error) in
            dt = data as! Data
            let s = String(data: dt as! Data, encoding: .utf8)
            print(s!)
        }
        
        let img = UIImage.loadFromBundle("666")
        if (img != nil) {
            print(img!)
        }
        */
        
        /*
        let tb = MyTable(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight()))
        tb.list.append("666")
        tb.list.append("777")
        tb.reloadData()
        self.view.addSubview(tb)
        */

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
        let arr = s.split(by: ",,")
        print(arr)
        s = "a,,bc,,def,,ghij"
        s = s.trim(c:["i", "j", "a"])
        print(s)
    }
    
    private func testurl(_ url: String) {
        let info = decodeUrl(url)
        print("info => protocol: \(info.proto), port: \(info.port), host: \(info.host), uri: \(info.uri)")
        for (k, v) in info.params {
            print("k: \(k), v: \(v)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnClicked(sender: Any?) {
        print("6666")
        self.view.toast(msg: "6666666")
    }

}

