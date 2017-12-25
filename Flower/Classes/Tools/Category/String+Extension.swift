//
// Created by lai leon on 2017/12/25.
// Copyright (c) 2017 clem. All rights reserved.
//

import Foundation

extension String {
    // 判断是否是手机号
    func isPhoneNumber() -> Bool {
        let pattern = "^1[345789]\\d{9}$"
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }


    // 判断是否是邮政编码
    func isPostCode() -> Bool {
        let pattern = "^\\d{6}$"
        return NSPredicate.init(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
}