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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tb = MyTable(frame: CGRect(x: 0, y: 0, width: screenWidth(), height: screenHeight()))
        tb.adapterDelegate = self
        self.view.addSubview(tb)
        
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
        tb.assignList(arr: arr)
        tb.reloadData()
        
        /*
        
         */
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
        default:
            break
        }
    }
    
    func tableView<T>(_ tableView: AdapterTableView<T>, longPressAt indexPath: IndexPath) {
        
    }

    // ===========================================================
    // THREAD
    // ===========================================================
    private func sampleThread() {
        self.thread() {
            print("Call in sub thread 1")
            self.mainThread() {
                print("Call in main thread")
            }
            print("Call in sub thread 2")
        }
    }

    // ===========================================================
    // HTTP
    // ===========================================================
    private func sampleHttpGet() {
        // sample http get
        http("\(HTTPURL)?m=get&gp=rarnuget") { (code, data, error) in
            print("code: \(code)")
            if (data == nil) {
                print("data: N/A")
                if (error != nil) {
                    print("error: \(error!)")
                }
            } else {
                print("data: \(data!)")
            }
        }
    }

    private func sampleHttpPost() {
        // sample http post
        http(HTTPURL, method: "POST", mimeType: "", data: "", getParam: "", postParam: ["m": "post", "pp": "rarnupost"], fileParam: nil) { (code, data, error) in
            print("code: \(code)")
            if (data == nil) {
                print("data: N/A")
                if (error != nil) {
                    print("error: \(error!)")
                }
            } else {
                print("data: \(data!)")
            }
        }
    }

    private func sampleHttpUploadFile() {
        // sample http uploda file
        fileIO(src: "sample upload file", dest: "\(documentPath())/upload.txt", isSrcText: true) { (succ, data, error) in }
        http(HTTPURL, method: "POST", mimeType: "", data: "", getParam: "", postParam: ["m": "file", "fp": "rarnufile"], fileParam: ["file": "\(documentPath())/upload.txt"]) { (code, data, error) in
            print("code: \(code)")
            if (data == nil) {
                print("data: N/A")
                if (error != nil) {
                    print("error: \(error!)")
                }
            } else {
                print("data: \(data!)")
            }
        }
    }

    // ===========================================================
    // DOWNLOAD
    // ===========================================================
    private func sampleDownload() {
        // sample download
        download("\(HTTPROOT)/sample.txt", "\(documentPath())/server.txt") { (state, position, fileSize, error) in
            print("\(state), \(position), \(fileSize)")
            if (state == DownloadState.Error) {
                print("Download Error => \(error!)")
            }
            if (state == DownloadState.Complete) {
                print(documentPath())
            }
        }
    }

    // ===========================================================
    // FILEIO
    // ===========================================================
    private func sampleFileIOTF() {
        // sample fileio text -> file
        print(documentPath())
        fileIO(src: "sample text", dest: "\(documentPath())/sample.txt", isSrcText: true) { (succ, data, error) in
            print(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleFileIOTD() {
        // sample fileio text -> data
        fileIO(src: "sample text", dest: Data(), isSrcText: true) { (succ, data, error) in
            let s = String(data: data! as! Data, encoding: .utf8)
            print(s!)
        }
    }

    private func sampleFileIOFD() {
        // sample fileio file -> data
        fileIO(src: "\(documentPath())/sample.txt", dest: Data()) { (succ, data, error) in
            if (data != nil) {
                let s = String(data: data! as! Data, encoding: .utf8)
                print(s!)
            } else {
                print("File not exists")
            }
         }
    }

    private func sampleFileIODT() {
        // sample fileio data -> text
        let data = "sample text".data(using: .utf8)!
        fileIO(src: data, dest: "", isDestText: true) { (succ, data, error) in
            if (succ) {
                print(data! as! String)
            } else {
                print("File not exits")
            }
        }
    }

    private func sampleFileIODF() {
        // sample fileio data -> file
        let data = "sample text".data(using: .utf8)!
        fileIO(src: data, dest: "\(documentPath())/sample.txt") { (succ, data, error) in
            print(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleFileIOFT() {
        // sample fileio file -> text
        fileIO(src: "\(documentPath())/sample.txt", dest: "", isDestText: true) { (succ, data, error) in
            if (succ) {
                print(data! as! String)
            } else {
                print("File not exits")
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
                print(data! as! String)
            } else {
                print("Bundle File not exits")
            }
        }
    }

    private func sampleBundleIOFD() {
        // sample bundle io file -> data
        bundleIO(filename: "b.txt", dest: Data()) { (succ, data, error) in
            if (data != nil) {
                let s = String(data: data! as! Data, encoding: .utf8)
                print(s!)
            } else {
                print("Bundle File not exists")
            }
        }
    }

    private func sampleBundleIOFF() {
        // sample bundle io file -> file
        print(documentPath())
        bundleIO(filename: "b.txt", dest: "\(documentPath())/bundle.txt") { (succ, data, error) in
            print(succ ? "TRUE" : "FALSE")
        }
    }

    // ===========================================================
    // URL DECODE
    // ===========================================================

    private func sampleUrlDecode() {
        func testurl(_ url: String) {
            let info = decodeUrl(url)
            print("info => protocol: \(info.proto), port: \(info.port), host: \(info.host), uri: \(info.uri)")
            for (k, v) in info.params {
                print("k: \(k), v: \(v)")
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
        print("system version: \(systemVersion())")
        print("system name: \(systemName())")
        print("app version: \(appVersion())")
        print("screen size: \(screenWidth()) x \(screenHeight())")
        print("statusbar size: \(statusbarSize())")

        writeConfig(key: "samplekey", value: "sample value")
        let cfg = readConfig(key: "samplekey", def: "")
        print("config: \(cfg!)")
    }

    // ===========================================================
    // SYSTEM
    // ===========================================================
    private func sampleSystem() {
        // sample system
        print("Emulator: \(isEmulator() ? "TRUE" : "FALSE")")
        print("Jailbreak: \(isJailbreak() ? "TRUE" : "FALSE")")
    }

    // ===========================================================
    // ZIP
    // ===========================================================
    private func sampleZipZip() {
        // sample zip zip
        print(documentPath())
        let mgr = FileManager.default
        do {
            try mgr.createDirectory(atPath: "\(documentPath())/zip", withIntermediateDirectories: true)
            fileIO(src: "SampleA", dest: "\(documentPath())/zip/a.txt", isSrcText: true) { (succ, data, error) in }
            fileIO(src: "SampleB", dest: "\(documentPath())/zip/b.txt", isSrcText: true) { (succ, data, error) in }
            fileIO(src: "SampleC", dest: "\(documentPath())/zip/c.txt", isSrcText: true) { (succ, data, error) in }
        } catch {

        }

        zip("\(documentPath())/sample.zip", "\(documentPath())/zip") { succ in
            print(succ ? "TRUE" : "FALSE")
        }
    }

    private func sampleZipUnzip() {
        // sample zip unzip
        print(documentPath())
        unzip("\(documentPath())/sample.zip", "\(documentPath())/unzip") { succ in
            print(succ ? "TRUE" : "FALSE")
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

}

