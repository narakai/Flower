//
//  NSObject+Extension.swift
//  Flower
//
//  Created by lai leon on 2017/12/25.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

extension NSObject {
    // 显示错误信息
    func showErrorMessage(message: String) {
        // 只有UIView和UIViewController才能显示错误信息
        if self.isKind(of: UIView.self) || self.isKind(of: UIViewController.self) {
            UIAlertView(title: "花田小憩", message: message, delegate: nil, cancelButtonTitle: "好的").show()
        }
    }
}
