//
//  ImageViewController.swift
//  sample
//
//  Created by rarnu on 2018/8/30.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class ImageViewController: UIViewController {
    
    let originPic = UIImage.loadFromBundle("sample.png")
    var img: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Image"
        
        var top = navigationbarHeight() + statusbarSize().height + 8
        img = UIImageView(frame: CGRect(x: (screenWidth() - 240) / 2, y: top, width: 240, height: 240))
        img?.image = originPic
        self.view.addSubview(img!)
        
        top += 240 + 8
        
        func makeButton(_ t: CGFloat, _ title: String, _ tag: Int) {
            let btn = UIButton(type: UIButton.ButtonType.system)
            btn.frame = CGRect(x: 8, y: t, width: screenWidth() - 16, height: 30)
            btn.tag = tag
            btn.setTitle(title, for: UIControl.State.normal)
            btn.addTarget(self, action: #selector(btnClicked(_:)), for: UIControl.Event.touchDown)
            self.view.addSubview(btn)
        }
        
        makeButton(top, "blackWhite", 0)
        makeButton(top + 30, "blur", 1)
        makeButton(top + 60, "rotate 90 clockwise", 2)
        makeButton(top + 90, "rotate 90 counter clockwise", 3)
        makeButton(top + 120, "rotate 180", 4)
        makeButton(top + 150, "rotate origin", 5)
        makeButton(top + 180, "flip horizontal", 6)
        makeButton(top + 210, "flip vertical", 7)
        makeButton(top + 240, "flip all", 8)
        makeButton(top + 270, "origin", 9)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func btnClicked(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let p0 = originPic?.blackWhite()
            img?.image = p0
            break
        case 1:
            let p1 = originPic?.blur(2)
            img?.image = p1
            break
        case 2:
            let p2 = originPic?.rotate90Clockwise()
            img?.image = p2
            break
        case 3:
            let p3 = originPic?.rotate90CounterClockwise()
            img?.image = p3
            break
        case 4:
            let p4 = originPic?.rotate180()
            img?.image = p4
            break
        case 5:
            let p5 = originPic?.rotateOrigin()
            img?.image = p5
            break
        case 6:
            let p6 = originPic?.flipHorizontal()
            img?.image = p6
            break
        case 7:
            let p7 = originPic?.flipVertical()
            img?.image = p7
            break
        case 8:
            let p8 = originPic?.flipAll()
            img?.image = p8
            break
        case 9:
            img?.image = originPic
            break
        default:
            break
        }
    }
}
