//
//  Date+Extension.swift
//  Flower
//
//  Created by lai leon on 2017/12/21.
//  Copyright © 2017 clem. All rights reserved.
//

import UIKit

extension Date {

    static func dateWithStr(dateStr: String) -> Date? {
        let formatter = DateFormatter()
        // 2016-04-24 15:10:24
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 有的时候, 有的服务器生成的时间是采用的其他地区或者语音,这种情况, 一定要设置本地化, 比如这儿的Aug, 如果你不设置成en, 那么鬼才知道你要解析成什么样的.
//        formatter.locale = NSLocale(localeIdentifier: "en")
        return formatter.date(from: dateStr)
    }

    // 分类中可以直接添加计算型属性, 因为他不需要分配存储空间
    var dateDesc: String {
        let formatter = DateFormatter()
        var formatterStr: String?
        let calendar = Calendar.current
        let components: DateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())
        let second = components.second!
        let year = components.year!
        if calendar.isDateInToday(self) {
            if second < 60 {
                return "刚刚"
            } else if second < 60 * 60 {
                return "\(second / 60)分钟前"
            } else {
                return "\(second / 60 / 60)小时前"
            }
        } else if calendar.isDateInYesterday(self) {
            // 昨天: 昨天 17:xx
            formatterStr = "昨天 HH:mm"
        } else {
            // 很多年前: 2014-12-14 17:xx
            // 如果枚举可以选择多个, 就用数组[]包起来, 如果为空, 就直接一个空数组
            // 今年: 03-15 17:xx
            if year < 1 {
                formatterStr = "MM-dd HH:mm"
            } else {
                formatterStr = "yyyy-MM-dd HH:mm"
            }
        }
        formatter.dateFormat = formatterStr
        return formatter.string(from: self)
    }
}
