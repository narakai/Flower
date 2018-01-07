//
//  TitleBtn.swift
//  Flower
//
//  Created by lai leon on 2018/1/7.
//  Copyright © 2018 clem. All rights reserved.
//

import UIKit

class TitleBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)

        setTitle("主题", for: .normal)
        setImage(UIImage(named: "hp_arrow_down"), for: .normal)
        setImage(UIImage(named: "hp_arrow_up"), for: .selected)
        setTitleColor(UIColor.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView!.frame.origin.x < titleLabel!.frame.origin.x {
            titleLabel?.frame.origin.x = imageView!.frame.origin.x
            imageView?.frame.origin.x = titleLabel!.frame.maxX + 10
        }

    }
}
