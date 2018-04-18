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

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

