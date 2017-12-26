//
//  ViewController.swift
//  Flower
//
//  Created by lai leon on 2017/12/21.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

let LLRect = UIScreen.main.bounds
let LLHeight = LLRect.size.height
let LLWidth = LLRect.size.width
let LLNoNavRect = CGRect(x: 0, y: 0, width: LLWidth, height: LLHeight - 64)
let LLTestRect = CGRect(x: 100, y: 100, width: LLWidth, height: LLHeight - 64)
let LLNoTarRect = CGRect(x: 0, y: 0, width: LLWidth, height: LLHeight - 49)
let LLNoNavTarRect = CGRect(x: 0, y: 0, width: LLWidth, height: LLHeight - 49 - 64)

class ViewController: UIViewController {

    let textView: UITextView = {
        let textView = UITextView(frame: LLTestRect)
        textView.text = Date.dateWithStr(dateStr: "2017-12-21 23:10:24")!.dateDesc
        return textView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        view.addSubview(textView)
    }

    override func viewDidAppear(_ animated: Bool) {
//        if !"13677777711123123".isPhoneNumber() {
//            showErrorMessage(message: "Oho");
//        }
        showHudInView(view: view, hint: "Loading", yOffset: 0)
//        super.viewDidAppear(animated)
//        let alertController = UIAlertController(title: "花田小憩", message: "消息", preferredStyle: UIAlertControllerStyle.alert)
//        let action = UIAlertAction(title: "好的", style: UIAlertActionStyle.cancel, handler: nil)
//        alertController.addAction(action)
//        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
