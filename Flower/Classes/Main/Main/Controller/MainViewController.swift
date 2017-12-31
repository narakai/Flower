//
//  MainViewController.swift
//  Flower
//
//  Created by lai leon on 2017/12/31.
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

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpView()
    }

    private func setUpView() {
        view.backgroundColor = UIColor.white
        // 设置tabBar的tintColor
        tabBar.tintColor = UIColor.black

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITabBarControllerDelegate {

}