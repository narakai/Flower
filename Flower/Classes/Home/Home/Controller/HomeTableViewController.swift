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
        tableView.register(HomeTableViewController.self, forCellReuseIdentifier: HomeArticleReuseIdentifier)
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

    }

    // MARK: 数据获取

    /**
     #1.获得专题的类型:(POST或者GET都行)
     http://m.htxq.net/servlet/SysCategoryServlet?action=getList
     */
    @objc private func getList() {

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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension HomeTableViewController: BlurViewDelegate {
//
//}
