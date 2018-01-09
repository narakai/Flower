//
//  HomeTableViewController.swift
//  Flower
//
//  Created by lai leon on 2017/12/31.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit
import Alamofire


private let HomeArticleReuseIdentifier = "HomeArticleReuseIdentifier"

class HomeTableViewController: UITableViewController {
    // MARK: - 懒加载
    let menuBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "menu"), for: .normal)
        btn.frame.size = CGSize(width: 20, height: 20)
        btn.addTarget(self, action: #selector(selectedCategory), for: .touchUpInside)
        return btn
    }()

    let titleBtn: TitleBtn = {
        let btn = TitleBtn()
        return btn
    }()


    // MARK: - 参数/变量
    // 文章数组
    var articles: [Article]?
    // 当前页
    var currentPage: Int = 0
    // 所有的主题分类
    var categories: [Category]?
    // 选中的分类
    var selectedCategry: Category?

    // 是否加载更多
    private var toLoadMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - 基本设置
    // 设置导航栏和tableview相关
    private func setup() {
        // 设置左右item
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuBtn)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "TOP", style: .plain, target: self, action: #selector(toTop))

        // 设置titleView
        navigationItem.titleView = titleBtn

        // 设置tableview相关
        tableView.register(HomeArticleCell.self, forCellReuseIdentifier: HomeArticleReuseIdentifier)
        tableView.rowHeight = 330;
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()

        // 设置下拉刷新控件
        refreshControl = RefreshControl(frame: CGRect.zero)
        refreshControl?.addTarget(self, action: #selector(getList), for: .valueChanged)
        refreshControl?.beginRefreshing()
        getList()
        getCategories()
    }

    @objc private func getCategories() {
// 1. 获取本地保存的
//        if let array = Category.loadLocalCategories() {
//            self.categories = array
//        }
        // 2. 获取网络数据
        NetworkTool.sharedTools.getCategories { (categories, error) in
            if error == nil {
                self.categories = categories
                // 3. 保存在本地(已在方法中实现了)
            } else {
                ALinLog(message: error?.localizedDescription)
            }
        }
    }

    // MARK: 数据获取

    /**
     #1.获得专题的类型:(POST或者GET都行)
     http://m.htxq.net/servlet/SysCategoryServlet?action=getList
     */
    @objc private func getList() {
// 如果是刷新的话.重置currentPage
        if refreshControl!.isRefreshing {
            reSet()
        }

        // 参数设置

//        String is the value type. AnyObject only accepts reference types.
//        So in order to add both value types and reference types in Dictionary use Any instead of AnyObject, i.e.
//        var parameters = [String: Any]()
//        This is an addition to Swift 3.0.

        var paramters = [String: Any]()
        paramters["currentPageIndex"] = "\(currentPage)"
        paramters["pageSize"] = "5"
        // 如果选择了分类就设置分类的请求ID
        if let categry = selectedCategry {
            paramters["cateId"] = categry.id
        }
        NetworkTool.sharedTools.getHomeList(paramters: paramters) { (articles, error, loadAll) in
            // 停止加载数据
            if self.refreshControl!.isRefreshing {
                self.refreshControl!.endRefreshing()
            }

            if loadAll {
                self.showHint(hint: "已经到最后了", duration: 2, yOffset: 0)
                self.currentPage -= 1
                return
            }

            // 显示数据
            if error == nil {
                if var _ = self.articles {
                    self.toLoadMore = false
                    self.articles! += articles!
                } else {
                    self.articles = articles!
                }
                self.tableView.reloadData()
            } else {
                // 获取数据失败后
                self.currentPage -= 1
                if self.toLoadMore {
                    self.toLoadMore = false
                }
                self.showHint(hint: "网络异常", duration: 2, yOffset: 0)
            }
        }
    }

    // MARK: - 内部控制方法
    /**
     重置数据
     */
    private func reSet() {
        // 重置当前页
        currentPage = 0
        // 重置数组
        articles?.removeAll()
        articles = [Article]()
    }

    /*******  START *********/
    // OC中的方法都是运行时加载, 是属于动态的, 用的时候才加载
    // SWift中的方法都是编译时加载, 属于静态的.
    // 如果使用addTarget, 且是private修饰的, 就需要告诉编辑器, 我这个方法是objc的, 属于动态加载
    @objc private func toTop() {
//        navigationController?.pushViewController(TopViewController(), animated: true)
    }

    @objc private func selectedCategory() {

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*******  END *********/

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeArticleReuseIdentifier) as! HomeArticleCell
        cell.selectionStyle = .none
        let count = articles?.count ?? 0
        if count > 0 {
            let article = articles![indexPath.row]
            cell.article = article
            //            cell.clickHeadImage = { [weak self] article in
            //                let columnist = ColumnistViewController()
            //                columnist.author = article?.author
            //                self!.navigationController?.pushViewController(columnist, animated: true)
            //            }
        }

        // 为了增强用户体验, 我们可以学习新浪微博的做法, 当用户滚动到最后一个Cell的时候,自动加载下一页数据
        // 每次要用户手动的去加载更多, 就仿佛在告诉用户, 你在我这个APP已经玩了很久了, 该休息了...源源不断的刷新, 就会让用户一直停留在APP上
        if count > 0 && indexPath.row == count - 1 && !toLoadMore {
            toLoadMore = true
            // 这儿写自增, 竟然有警告, swift语言更新确实有点快, 我记得1.2的时候还是可以的
            currentPage += 1
            getList()
        }
        return cell
    }

}

//extension HomeTableViewController: BlurViewDelegate {
//
//}
