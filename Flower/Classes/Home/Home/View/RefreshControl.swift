//
//  RefreshControl.swift
//  Flower
//
//  Created by lai leon on 2018/1/7.
//  Copyright © 2018 clem. All rights reserved.
//

import UIKit
import SnapKit

class RefreshControl: UIRefreshControl {
    // MARK:  懒加载
    let tipView: RefreshTipView = {
        let tipView = RefreshTipView()
        return tipView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(tipView)

        tipView.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: 200, height: 60))
        }

        // 监听frame的变化
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        removeObserver(self, forKeyPath: "frame")
    }

    /// 监听frame的变化
    // 是否旋转箭头的标记
    private var rotationFlag = false
    // 是否执行动画的标记
    private var animtoringFlag = false
    // 是否一开始就直接刷新, 没有进行下拉
    private var beginAnimFlag = false
    // 刷新的时候, 不再进行其他操作
    private var isLoading = false

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        let y = frame.origin.y
        // 1. 最开始一进来的时候, 刷新按钮是隐藏的, y就是-64, 需要先判断掉, y>=0 , 说明刷新控件已经完全缩回去了...
        if y >= 0 || y == -64 {
            return
        }

        // 2. 判断是否一进来就进行刷新
        if beginAnimFlag && (y == -60.0 || y == -124.0) {
            if !isLoading {
                isLoading = true
                animtoringFlag = true
                tipView.beginLoadingAnimator()
            }
            return
        }

        // 3. 释放已经触发了刷新事件, 如果触发了, 需要进行旋转
        if isRefreshing && !animtoringFlag {
            animtoringFlag = true
            tipView.beginLoadingAnimator()
            return
        }

        if y <= -50 && !rotationFlag {
            rotationFlag = true
            tipView.rotationRefresh(flag: rotationFlag)
        } else if (y > -50 && rotationFlag) {
            rotationFlag = false
            tipView.rotationRefresh(flag: rotationFlag)
        }
    }

    // 重写停止刷新
    override func endRefreshing() {
        super.endRefreshing()
        animtoringFlag = false
        beginAnimFlag = false
        isLoading = false

        DispatchQueue.main.asyncAfter(deadline: 2, execute: {
            self.tipView.stopLoadingAnimator()
        })
    }

    // 重写开始刷新
    override func beginRefreshing() {
        super.beginRefreshing()
        // 开始刷新的时候, 直接开始菊花动画
        beginAnimFlag = true
    }

}

extension DispatchTime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
