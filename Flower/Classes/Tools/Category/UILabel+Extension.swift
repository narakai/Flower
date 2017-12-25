//
// Created by lai leon on 2017/12/25.
// Copyright (c) 2017 clem. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(textColor: UIColor, font: UIFont) {
        self.init()
        self.font = font
        self.textColor = textColor
    }
}