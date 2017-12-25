//
// Created by lai leon on 2017/12/25.
// Copyright (c) 2017 clem. All rights reserved.
//

import UIKit

extension UIImage {
// 改变图片的颜色
    class func imageWithColor(imageName: String, color: UIColor) -> UIImage {
        let image = UIImage(named: imageName)!
        UIGraphicsBeginImageContext(image.size)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: image.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: image.size.width, height: image.size.height))
        context.clip(to: rect, mask: image.cgImage!)
        color.setFill()
        context.fill(rect);
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!;
    }
}

