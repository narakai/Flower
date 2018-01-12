//
//  Article.swift
//  Floral
//
//  Created by ALin on 16/4/26.
//  Copyright © 2016年 ALin. All rights reserved.
//

import UIKit
import SwiftyJSON

class Article: NSObject {
    // 创建时间
//    var createDate: String? {
//        didSet {
//            /*这个方法主要是属性被赋值的时候会被调用
//            *如果是对象初始化的时候，是不会调用的，如果想被调用，要使用kvc
//             */
//            print("didset")
//            if var date = createDate {
//                if date.contains(".0") {
//                    date = date.replacingOccurrences(of: ".0", with: "");
//                }
//                let time: Date? = Date.dateWithStr(dateStr: date)
//                if let t = time {
//                    createDateDesc = t.description;
//                }
//            }
//        }
//    }

    var createDate: String?

    // 描述创建时间, 比如昨天, 今天, 去年等
    var createDateDesc: String?

    // 摘要
    var desc: String?
    // 评论数
    var fnCommentNum: Int = 0
    // 点赞数
    var favo: Int = 0
    // 文章ID
    var id: String?
    // 序号
    var order: Int = 0
    // 文章的H5地址
    var pageUrl: String?
    // 阅读数
    var read: Int = 0
    // 分享数
    var share: Int = 0
    // 用户分享的URL
    var sharePageUrl: String?
    // 缩略图
    var smallIcon: String?
    // 文章标题
    var title: String?
    // 是否是首页的, 如果是首页不显示时间
    var isNotHomeList: Bool = false


    // 作者
    var author: Author?

    // 所属分类
    var category: Category?

    init(jsonData: JSON) {
        createDateDesc = jsonData["createDateDesc"].stringValue
        desc = jsonData["desc"].stringValue
        fnCommentNum = jsonData["fnCommentNum"].intValue
        favo = jsonData["favo"].intValue
        order = jsonData["order"].intValue
        read = jsonData["read"].intValue
        share = jsonData["share"].intValue
        id = jsonData["id"].stringValue
        pageUrl = jsonData["pageUrl"].stringValue
        sharePageUrl = jsonData["sharePageUrl"].stringValue
        smallIcon = jsonData["smallIcon"].stringValue
        title = jsonData["title"].stringValue
        isNotHomeList = jsonData["isNotHomeList"].boolValue
        author = Author(jsonData: JSON(jsonData["author"].rawValue))
        category = Category(jsonData: JSON(jsonData["category"].rawValue))
        super.init()
    }

//    override func setValue(_ value: Any?, forKey key: String) {
//        // 单独处理author和category
//        if key == "author" {
//            if let valueOfKey = value {
//                author = Author(dict: valueOfKey as! [String: AnyObject])
//            }
//            return;
//        }
//        if key == "category" {
//            if let valueOfKey = value {
//                category = Category(dict: valueOfKey as! [String: AnyObject])
//            }
//            return
//        }
//        super.setValue(value, forKey: key)
//    }
}
