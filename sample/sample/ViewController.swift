//
//  ViewController.swift
//  sample
//
//  Created by rarnu on 26/03/2018.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class ViewController: UIViewController, AdapterTableViewDelegate {

    private let HTTPROOT = "http://10.211.55.24:12345/phproot"
    private let HTTPURL = "http://10.211.55.24:12345/phproot/sample.php"
    
    private let tb = MyTable(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight() - 120))
    private let console = UITextView(frame: CGRect(x: 0, y: screenHeight() - 120, width: screenWidth(), height: 120))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tb.adapterDelegate = self
        self.view.addSubview(tb)
        console.layoutManager.allowsNonContiguousLayout = false
        console.isEditable = false
        console.text = ""
        self.view.addSubview(console)
        
        var arr = Array<String>()
        arr.append("Thread")                        // DONE
        arr.append("Http (Get)")                    // DONE
        arr.append("Http (Post)")                   // DONE
        arr.append("Http (Upload File)")            // DONE
        arr.append("Download")                      // DONE
        arr.append("FileIO (Text -> File)")         // DONE
        arr.append("FileIO (Text -> Data)")         // DONE
        arr.append("FileIO (File -> Data)")         // DONE
        arr.append("FileIO (Data -> Text)")         // DONE
        arr.append("FileIO (Data -> File)")         // DONE
        arr.append("FileIO (File -> Text)")         // DONE
        arr.append("BundleIO (File -> Text)")       // DONE
        arr.append("BundleIO (File -> Data)")       // DONE
        arr.append("BundleIO (File -> File)")       // DONE
        arr.append("URL Decode")                    // DONE
        arr.append("Toast")                         // DONE
        arr.append("Context")                       // DONE
        arr.append("System")                        // DONE
        arr.append("Zip (Zip)")                     // DONE
        arr.append("Zip (Unzip)")                   // DONE
        arr.append("Image (...)")                   // DONE
        arr.append("Extension (...)")               // DONE
        arr.append("TableView (...)")               // DONE
        arr.append("PopupViewController")           // DONE
        arr.append("Regular Expression")            // DONE
        tb.assignList(arr: arr)
        tb.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, clickAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            sampleThread()
            break
        case 1:
            sampleHttpGet()
            break
        case 2:
            sampleHttpPost()
            break
        case 3:
            sampleHttpUploadFile()
            break
        case 4:
            sampleDownload()
            break
        case 5:
            sampleFileIOTF()
            break
        case 6:
            sampleFileIOTD()
            break
        case 7:
            sampleFileIOFD()
            break
        case 8:
            sampleFileIODT()
            break
        case 9:
            sampleFileIODF()
            break
        case 10:
            sampleFileIOFT()
            break
        case 11:
            sampleBundleIOFT()
            break
        case 12:
            sampleBundleIOFD()
            break
        case 13:
            sampleBundleIOFF()
            break
        case 14:
            sampleUrlDecode()
            break
        case 15:
            sampleToast()
            break
        case 16:
            sampleContext()
            break
        case 17:
            sampleSystem()
            break
        case 18:
            sampleZipZip()
            break
        case 19:
            sampleZipUnzip()
            break
        case 20:
            jumpImage()
            break
        case 21:
            jumpExtension()
            break
        case 22:
            jumpTableView()
            break
        case 23:
            samplePopupViewController()
            break
        case 24:
            sampleRegEx()
            break
        default:
            break
        }
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, longPressAt indexPath: IndexPath) {
        
    }
    
    private func addConsoleLog(_ txt: String) {
        self.mainThread {
            self.console.text = self.console.text + txt + "\n"
            self.console.scrollRangeToVisible(NSRange(location: self.console.text.count, length: 1))
        }
    }

    // ===========================================================
    // THREAD
    // ===========================================================
    private func sampleThread() {
        self.thread() {
            self.addConsoleLog("Call in sub thread 1")
            self.mainThread() {
                self.addConsoleLog("Call in main thread")
            }
            self.addConsoleLog("Call in sub thread 2")
        }
    }

    // ===========================================================
    // HTTP
    // ===========================================================
    private func sampleHttpGet() {
        // sample http get
        http("\(HTTPURL)?m=get&gp=rarnuget") { (code, data, error) in
            self.addConsoleLog("code: \(code)")
            if (data == nil) {
                self.addConsoleLog("data: N/A")
                if (error != nil) {
                    self.addConsoleLog("error: \(error!)")
                }
            } else {
                self.addConsoleLog("data: \(data!)")
            }
        }
    }

    private func sampleHttpPost() {
        // sample http post
        http(HTTPURL, method: "POST", mimeType: "", data: "", getParam: "", postParam: ["m": "post", "pp": "rarnupost"], fileParam: nil) { (code, data, error) in
            self.addConsoleLog("code: \(code)")
            if (data == nil) {
                self.addConsoleLog("data: N/A")
                if (error != nil) {
                    self.addConsoleLog("error: \(error!)")
                }
            } else {
                self.addConsoleLog("data: \(data!)")
            }
        }
    }

    private func sampleHttpUploadFile() {
        // sample http uploda file
        fileIO(src: "sample upload file", dest: "\(documentPath())/upload.txt", isSrcText: true) { (succ, data, error) in }
        http(HTTPURL, method: "POST", mimeType: "", data: "", getParam: "", postParam: ["m": "file", "fp": "rarnufile"], fileParam: ["file": "\(documentPath())/upload.txt"]) { (code, data, error) in
            self.addConsoleLog("code: \(code)")
            if (data == nil) {
                self.addConsoleLog("data: N/A")
                if (error != nil) {
                    self.addConsoleLog("error: \(error!)")
                }
            } else {
                self.addConsoleLog("data: \(data!)")
            }
        }
    }

    // ===========================================================
    // DOWNLOAD
    // ===========================================================
    private func sampleDownload() {
        // sample download
        download("\(HTTPROOT)/sample.txt", "\(documentPath())/server.txt") { (state, position, fileSize, error) in
            self.addConsoleLog("\(state), \(position), \(fileSize)")
            if (state == DownloadState.Error) {
                self.addConsoleLog("Download Error => \(error!)")
            }
            if (state == DownloadState.Complete) {
                self.addConsoleLog(documentPath())
            }
        }
    }

    // ===========================================================
    // FILEIO
    // ===========================================================
    private func sampleFileIOTF() {
        // sample fileio text -> file
        self.addConsoleLog(documentPath())
        fileIO(src: "sample text", dest: "\(documentPath())/sample.txt", isSrcText: true) { (succ, data, error) in
            self.addConsoleLog(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleFileIOTD() {
        // sample fileio text -> data
        fileIO(src: "sample text", dest: Data(), isSrcText: true) { (succ, data, error) in
            let s = String(data: data! as! Data, encoding: .utf8)
            self.addConsoleLog(s!)
        }
    }

    private func sampleFileIOFD() {
        // sample fileio file -> data
        fileIO(src: "\(documentPath())/sample.txt", dest: Data()) { (succ, data, error) in
            if (data != nil) {
                let s = String(data: data! as! Data, encoding: .utf8)
                self.addConsoleLog(s!)
            } else {
                self.addConsoleLog("File not exists")
            }
         }
    }

    private func sampleFileIODT() {
        // sample fileio data -> text
        let data = "sample text".data(using: .utf8)!
        fileIO(src: data, dest: "", isDestText: true) { (succ, data, error) in
            if (succ) {
                self.addConsoleLog(data! as! String)
            } else {
                self.addConsoleLog("File not exits")
            }
        }
    }

    private func sampleFileIODF() {
        // sample fileio data -> file
        let data = "sample text".data(using: .utf8)!
        fileIO(src: data, dest: "\(documentPath())/sample.txt") { (succ, data, error) in
            self.addConsoleLog(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleFileIOFT() {
        // sample fileio file -> text
        fileIO(src: "\(documentPath())/sample.txt", dest: "", isDestText: true) { (succ, data, error) in
            if (succ) {
                self.addConsoleLog(data! as! String)
            } else {
                self.addConsoleLog("File not exits")
            }
        }
    }

    // ===========================================================
    // BUNDLEIO
    // ===========================================================
    private func sampleBundleIOFT() {
        // sample bundle io file -> text
        bundleIO(filename: "b.txt", dest: "", isDestText: true) { (succ, data, error) in
            if (succ) {
                self.addConsoleLog(data! as! String)
            } else {
                self.addConsoleLog("Bundle File not exits")
            }
        }
    }

    private func sampleBundleIOFD() {
        // sample bundle io file -> data
        bundleIO(filename: "b.txt", dest: Data()) { (succ, data, error) in
            if (data != nil) {
                let s = String(data: data! as! Data, encoding: .utf8)
                self.addConsoleLog(s!)
            } else {
                self.addConsoleLog("Bundle File not exists")
            }
        }
    }

    private func sampleBundleIOFF() {
        // sample bundle io file -> file
        self.addConsoleLog(documentPath())
        bundleIO(filename: "b.txt", dest: "\(documentPath())/bundle.txt") { (succ, data, error) in
            self.addConsoleLog(succ ? "TRUE" : "FALSE")
        }
    }

    // ===========================================================
    // URL DECODE
    // ===========================================================

    private func sampleUrlDecode() {
        func testurl(_ url: String) {
            let info = decodeUrl(url)
            self.addConsoleLog("info => protocol: \(info.proto), port: \(info.port), host: \(info.host), uri: \(info.uri)")
            for (k, v) in info.params {
                self.addConsoleLog("k: \(k), v: \(v)")
            }
        }
        testurl("https://www.baidu.com:1234/uri/suburi?p1=a&p2=b")
        testurl("https://www.baidu.com:1234/uri/suburi?p1=&p2=b")
        testurl("https://www.baidu.com/uri/suburi?p1=a&p2=b")
        testurl("https://www.baidu.com:1234/suburi")
        testurl("https://www.baidu.com")
        testurl("www.baidu.com:1234")
        testurl("www.baidu.com")
    }

    // ===========================================================
    // TOAST
    // ===========================================================
    private func sampleToast() {
        self.view.toast(msg: "Sample Toast")
    }

    // ===========================================================
    // CONTEXT
    // ===========================================================
    private func sampleContext() {
        // sample context
        self.addConsoleLog("system version: \(systemVersion())")
        self.addConsoleLog("system name: \(systemName())")
        self.addConsoleLog("app version: \(appVersion())")
        self.addConsoleLog("screen size: \(screenWidth()) x \(screenHeight())")
        self.addConsoleLog("statusbar size: \(statusbarSize())")

        writeConfig(key: "samplekey", value: "sample value")
        let cfg = readConfig(key: "samplekey", def: "")
        self.addConsoleLog("config: \(cfg!)")
    }

    // ===========================================================
    // SYSTEM
    // ===========================================================
    private func sampleSystem() {
        // sample system
        self.addConsoleLog("Emulator: \(isEmulator() ? "TRUE" : "FALSE")")
        self.addConsoleLog("Jailbreak: \(isJailbreak() ? "TRUE" : "FALSE")")
    }

    // ===========================================================
    // ZIP
    // ===========================================================
    private func sampleZipZip() {
        // sample zip zip
        self.addConsoleLog(documentPath())
        let mgr = FileManager.default
        do {
            try mgr.createDirectory(atPath: "\(documentPath())/zip", withIntermediateDirectories: true)
            fileIO(src: "SampleA", dest: "\(documentPath())/zip/a.txt", isSrcText: true) { (succ, data, error) in }
            fileIO(src: "SampleB", dest: "\(documentPath())/zip/b.txt", isSrcText: true) { (succ, data, error) in }
            fileIO(src: "SampleC", dest: "\(documentPath())/zip/c.txt", isSrcText: true) { (succ, data, error) in }
        } catch {

        }

        zip("\(documentPath())/sample.zip", "\(documentPath())/zip") { succ in
            self.addConsoleLog(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleZipUnzip() {
        // sample zip unzip
        self.addConsoleLog(documentPath())
        unzip("\(documentPath())/sample.zip", "\(documentPath())/unzip") { succ in
            self.addConsoleLog(succ ? "TRUE" : "FALSE")
        }
    }

    // ===========================================================
    // JUMP OTHER
    // ===========================================================
    private func jumpImage() {
        // jump image
        self.show(self.vc(name: "imgvc")!, sender: nil)
    }

    private func jumpExtension() {
        // jump extension
        self.show(self.vc(name: "extvc")!, sender: nil)
    }

    private func jumpTableView() {
        // jump tableview
        self.show(self.vc(name: "tblvc")!, sender: nil)
    }
    
    // ===========================================================
    // POPUPVIEWCONTROLLER
    // ===========================================================
    
    private func samplePopupViewController() {
        let vc = MyPopupController(width: 500, height: 300, alpha: 0.5)
        self.present(vc, animated: true, completion: nil)
    }

    // ===========================================================
    // REGULAR EXPRESSION
    // ===========================================================
    private func sampleRegEx() {
        let b1 = RegExUtils.isStringReg("abcdefg_123456", 5)
        let b2 = RegExUtils.isStringReg("abc我们_123", 5)
        self.addConsoleLog("b1: \(b1), b2: \(b2)")
        
        let e1 = RegExUtils.isEmail("rarnu1985@gmail.com")
        let e2 = RegExUtils.isEmail("abcdefg.com")
        self.addConsoleLog("e1: \(e1), e2: \(e2)")
    }
}

