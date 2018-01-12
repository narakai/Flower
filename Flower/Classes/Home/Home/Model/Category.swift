//
//  Category.swift
//  Floral
//
//  Created by ALin on 16/4/26.
//  Copyright © 2016年 ALin. All rights reserved.
//  首页的专题分类

import UIKit
import SwiftyJSON

class Category: NSObject {
    // 专题创建时间
    var createDate: String?
    // 专题类型ID
    var id: String?
    // 专题类型名称
    var name: String?
    // 专题序号
    var order: Int?

    var img: String?

//    // 遍历构造器
//    init(dict: [String: AnyObject]) {
//        super.init()
////        setValuesForKeys(dict)
//    }

    init(jsonData: JSON) {
        createDate = jsonData["createDate"].stringValue
        id = jsonData["id"].stringValue
        name = jsonData["name"].stringValue
        order = jsonData["order"].intValue
        img = jsonData["img"].stringValue
        super.init()
    }

//
//    // MARK: - 序列化和反序列化
//    private let createDate_Key = "createDate"
//    private let id_Key = "id"
//    private let name_Key = "name"
//    private let order_Key = "order"
//    private let img_Key = "img"
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(createDate, forKey: createDate_Key)
//        aCoder.encode(id, forKey: id_Key)
//        aCoder.encode(order, forKey: order_Key)
//        aCoder.encode(name, forKey: name_Key)
//        aCoder.encode(img, forKey: img_Key)
//    }
//
//    // 反序列化
//    required init?(coder aDecoder: NSCoder) {
//        createDate = aDecoder.decodeObject(forKey: createDate_Key) as? String
//        id = aDecoder.decodeObject(forKey: id_Key) as? String
//        order = aDecoder.decodeObject(forKey: order_Key) as? Int
//        name = aDecoder.decodeObject(forKey: name_Key) as? String
//        img = aDecoder.decodeObject(forKey: img_Key) as? String
//    }
//
//    // MARK: - 保存和获取所有分类
//    static let CategoriesKey = "CategoriesKey"
//
//    /**
//     保存所有的分类
//
//     - parameter categories: 分类数组
//     */
//    class func savaCategories(categories: [Category]) {
//        let data = NSKeyedArchiver.archivedData(withRootObject: categories)
//        UserDefaults.standard.set(data, forKey: Category.CategoriesKey)
//    }
//
//    /**
//     取出本地保存的分类
//
//     - returns: 分类数组或者nil
//     */
//    class func loadLocalCategories() -> [Category]? {
//        if let array = UserDefaults.standard.object(forKey: Category.CategoriesKey) {
//            return NSKeyedUnarchiver.unarchiveObject(with: array as! Data) as? [Category]
//        }
//        return nil
//    }
}
