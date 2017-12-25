//
// Created by lai leon on 2017/12/25.
// Copyright (c) 2017 clem. All rights reserved.
//

import UIKit

extension UIButton {
    convenience init(title: String?, imageName: String?, target: AnyObject?, selector: Selector?, font: UIFont?, titleColor: UIColor?) {
        self.init()
        if let imageN = imageName {
            setImage(UIImage(named: imageN), for: .normal)
        }
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        setTitle(title, for: .normal)
        if let sel = selector {
            addTarget(target, action: sel, for: .touchUpInside)
        }
    }
}
