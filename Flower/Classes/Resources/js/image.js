//
//  SettingViewController.swift
//  Flower
//
//  Created by lai leon on 2017/12/31.
//  Copyright © 2017 clem. All rights reserved.
//

//setImage的作用是为页面的中img元素添加onClick事件，即设置点击时调用imageClick
function setImageClick() {
    var imgs = document.getElementsByTagName("img");
    for (var i = 0; i < imgs.length; i++) {
        var src = imgs[i].src;
        imgs[i].setAttribute("onClick", "imageClick(src)");
    }
    document.location = imageurls;
}

//imageClick即图片 onClick时触发的方法，document.location = url;的作用是使调用
//webView: shouldStartLoadWithRequest: navigationType:方法，在该方法中我们真正处理图片的点击
function imageClick(imagesrc) {
    var url = "imageClick::" + imagesrc;
    document.location = url;
}
