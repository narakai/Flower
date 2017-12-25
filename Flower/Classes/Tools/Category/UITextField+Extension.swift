//
// Created by lai leon on 2017/12/25.
// Copyright (c) 2017 clem. All rights reserved.
//

import UIKit

extension UITextField {
    convenience init(frame: CGRect, isPlaceHolderSpace: Bool) {
        self.init(frame: frame)

        if isPlaceHolderSpace {
            let space = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            leftView = space
            leftViewMode = .always
        }
    }

    // 判断当前的textfiled的值是否为空
    func isNil() -> Bool {
        if (text?.count)! < 1 {
            return true
        }
        return false
    }
}