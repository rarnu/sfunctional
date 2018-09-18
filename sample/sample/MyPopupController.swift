//
//  MyPopupController.swift
//  sample
//
//  Created by rarnu on 2018/9/11.
//  Copyright © 2018 rarnu. All rights reserved.
//

import UIKit
import sfunctional

class MyPopupController: PopupViewController {

    override func layout(base: UIView) {
        let btnClose = UIButton(type: UIButton.ButtonType.system)
        btnClose.frame = CGRect(x: 8, y: 8, width: 80, height: 40)
        btnClose.setTitle("Close", for: UIControl.State.normal)
        btnClose.addTarget(self, action: #selector(btnCloseClicked(_:)), for: UIControl.Event.touchDown)
        base.addSubview(btnClose)
    }
    
    @objc func btnCloseClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
