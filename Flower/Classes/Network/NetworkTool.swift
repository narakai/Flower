//
//  NetworkTool.swift
//  Flower
//
//  Created by lai leon on 2018/1/7.
//  Copyright © 2018 clem. All rights reserved.
//

import UIKit
import Alamofire

// 每周Top10的action的枚举
enum TOP10Action: String {
    // 作者
    case TopArticleAuthor = "topArticleAuthor"
    // 专栏
    case TopContents = "topContents"
}

// 商城列表的identity的枚举
enum MallIdentity: String {
    case MallJingxuan = "jingList/1"
    case MallTheme = "theme"
}

class NetworkTool: Alamofire.SessionManager {
    let headers: HTTPHeaders = [
        "Content-Type": "application/json;charset=UTF-8",
        "client-channel": "qqmark",
        "client-platform": "Android7.0",
        "client-terminal": "7s",
        "client-version": "5.8.1",
    ]

// MARK: - 单例
    internal static let sharedTools: NetworkTool = {
        let configuration = URLSessionConfiguration.default
        var header: Dictionary = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        return NetworkTool(configuration: configuration)
    }()

    // MARK: - 首页的数据请求
    /**
     获取所有的主题分类

     - parameter finished: 返回的block闭包
     */
    func getCategories(finished: @escaping (_ categories: [Category]?, _ error: Error?) -> ()) {
        request("http://api.htxq.net/servlet/SysCategoryServlet?action=getList", method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
//                if let json = response.result.value {
//                    print("JSON: \(json)") // serialized json response
//                }
                if let dictValue = response.result.value as?  [String:AnyObject] {
                    if let resultValue = dictValue["result"] as? [[String: AnyObject]] {
                        var categories = [Category]()
                        for dict in resultValue as! [[String: AnyObject]] {
                            categories.append(Category(dict: dict))
                        }
                        finished(categories, nil)
                        // 保存在本地
                        Category.savaCategories(categories: categories)
                    } else {
                        finished(nil, NSError.init(domain: "数据异常", code: 44, userInfo: nil))
                    }
                } else {
                    finished(nil, NSError.init(domain: "服务器异常", code: 44, userInfo: nil))
                }
            } else {
                finished(nil, response.result.error)
            }
        }
    }

    /**
     获取首页的文章列表

     - parameter paramters: 参数字典
        - 必传:currentPageIndex,pageSize(当currentPageIndex=0时,该参数无效, 但是必须传)
        - 根据情景传:
            - isVideo	true (是否是获取视频列表)
            - cateId	a56aa5d0-aa6b-42b7-967d-59b77771e6eb(专题的类型, 不传的话是默认)
     - parameter finished:  回传的闭包
     */
    func getHomeList(paramters: [String: Any]?, finished: @escaping (_ articles: [Article]?, _ error: Error?, _ loadAll: Bool) -> ()) {
        request("http://api.htxq.net/servlet/SysArticleServlet?action=mainList", method: HTTPMethod.post, parameters: paramters, encoding: JSONEncoding.default, headers: headers).responseJSON(queue: DispatchQueue.main, options: .mutableContainers) { (response) in
            ALinLog(message: response.result.value)
            if response.result.isSuccess {
                if let value = response.result.value as? NSDictionary {
                    if (value["msg"] as! NSString).isEqual(to: "已经到最后") {
                        finished(nil, response.result.error, true)
                    } else if let result = value["result"] {
                        var arcicles = [Article]()
                        for dict in result as! [[String: AnyObject]] {
                            arcicles.append(Article(dict: dict))
                        }
                        finished(arcicles, nil, false)

                    }
                }
            } else {
                finished(nil, response.result.error, false)
            }
        }
    }
}
