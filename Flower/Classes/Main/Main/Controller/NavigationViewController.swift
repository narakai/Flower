//
//  NavigationViewController.swift
//  Flower
//
//  Created by lai leon on 2017/12/31.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count > 0 {
            // push的时候, 隐藏tabbar
            viewController.hidesBottomBarWhenPushed = true
            // 添加返回按钮
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back"), style: .done, target: self, action: #selector(NavigationViewController.back))
        }
        super.pushViewController(viewController, animated: animated)
    }

    @objc func back() {
        popViewController(animated: true)
    }
}
