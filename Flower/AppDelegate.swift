//
//  AppDelegate.swift
//  Flower
//
//  Created by lai leon on 2017/12/21.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 方便测试: 每次登录的时候, 都把登录状态设置false
//      LoginHelper.sharedInstance.setLoginStatus(false)

        // 设置全局的UINavigationBar属性
        let bar = UINavigationBar.appearance()
        bar.tintColor = UIColor.orange
        bar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15)];

        // 设置window
        window = UIWindow(frame: LLRect)

        // 根据版本号, 判断显示哪个控制器
        if toNewFeature() {
            ALinLog(message: "new")
            window?.rootViewController = ViewController()
        } else {
            ALinLog(message: "old")
            window?.rootViewController = ViewController()
        }

        // 显示窗口
        window?.makeKeyAndVisible()
        return true
    }

    private let SLBundleShortVersionString = "SLBundleShortVersionString"

    // MARK: - 判断版本号
    private func toNewFeature() -> Bool {
        // 根据版本号来确定是否进入新特性界面
        let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        let oldVersion = UserDefaults.standard.object(forKey: SLBundleShortVersionString) ?? ""

        // 如果当前的版本号和本地保存的版本比较是降序, 则需要显示新特性
        if (currentVersion.compare(oldVersion as! String)) == .orderedDescending {
            // 保存当前的版本
            UserDefaults.standard.set(currentVersion, forKey: SLBundleShortVersionString)
            return true
        }
        return false
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.

    }


    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }


    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }


    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// 首先要明确一点: swift里面是没有宏定义的概念
// 自定义内容输入格式: 文件名[行号]函数名: 输入内容
// 需要在info.plist的other swift flag的Debug中添加DEBUG
func ALinLog<T>(message: T, fileName: String = #file, lineNum: Int = #line, funcName: String = #function) {
#if DEBUG
    print("\((fileName as NSString).lastPathComponent)[\(lineNum)] \(funcName): \(message)")
#endif
}
