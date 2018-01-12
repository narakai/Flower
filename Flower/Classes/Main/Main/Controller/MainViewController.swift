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
        // 一个简单的本地化...
        addViewController(childController: HomeTableViewController(), title: NSLocalizedString("tab_theme", comment: ""))
        addViewController(childController: MallsTableViewController(), title: NSLocalizedString("tab_malls", comment: ""))

        // 设置UITabBarControllerDelegate
        delegate = self

        // 添加通知监听
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.logout), name: NSNotification.Name.init(LoginOutNotify), object: nil)
    }

    // 监听到退出登录
    @objc func logout() {
        // 1. 选中首页
        selectedIndex = 0
        // 2. 弹出登录界面
        login()
    }

    // MARK: - private method
    /// 跳转到登录界面
    private func login() {

    }

    // 添加子控件
    private func addViewController(childController: UIViewController, title: String) {
        let nav = NavigationViewController(rootViewController: childController)
        addChildViewController(nav)
        childController.tabBarItem.title = title
        childController.tabBarItem.image = UIImage(named: "tb_\(childViewControllers.count - 1)")
        childController.tabBarItem.selectedImage = UIImage(named: "tb_\(childViewControllers.count - 1)" + "_selected")
        // 设置tabBarItem的tag, 方便判断点击
        childController.tabBarItem.tag = childViewControllers.count - 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainViewController: UITabBarControllerDelegate {

}