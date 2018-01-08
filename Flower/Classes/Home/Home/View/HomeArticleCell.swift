//
//  HomeArticleCell.swift
//  Flower
//
//  Created by lai leon on 2018/1/7.
//  Copyright © 2018 clem. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class HomeArticleCell: UITableViewCell {
    var article: Article? {
        didSet {
            if let art = article {
                // 设置数据
//                smallIconView.kf.(NSURL(string: art.smallIcon!)!, placeholderImage: UIImage(named: "placehodler"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
//                headImgView.kf_setImageWithURL(NSURL(string: art.author!.headImg!)!, placeholderImage: UIImage(named: "pc_default_avatar"), optionsInfo: [], progressBlock: nil, completionHandler: nil)
                identityLabel.text = art.author!.identity!
                authorLabel.text = art.author!.userName ?? "佚名"
                categoryLabel.text = "[" + art.category!.name! + "]"
                titleLabel.text = art.title
                descLabel.text = art.desc
//                bottomView.article = art
                authView.image = art.author?.authImage
            }

        }
    }

    var clickHeadImage: ((_ article: Article?) -> ())?


    // MARK: - 生命周期相关
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI设置和布局
    private func setupUI() {
        backgroundColor = UIColor(gray: 241)
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(smallIconView)
        contentView.addSubview(authorLabel)
        contentView.addSubview(identityLabel)
        contentView.addSubview(headImgView)
        contentView.addSubview(authView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(underline)
//        contentView.addSubview(bottomView)

        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(8, 8, 0, -8))
        }

        smallIconView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(contentView)
            make.height.equalTo(160)
        }

        headImgView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 51, height: 51))
            make.right.equalTo(contentView).offset(-10)
            make.top.equalTo(smallIconView.snp.bottom).offset(-10)
        }

        authView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 14, height: 14))
            make.bottom.right.equalTo(headImgView)
        }

        authorLabel.snp.makeConstraints { (make) in
            make.right.equalTo(headImgView.snp.left).offset(-10)
            make.top.equalTo(smallIconView.snp.bottom).offset(8)
        }

        identityLabel.snp.makeConstraints { (make) in
            make.right.equalTo(authorLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
        }

        categoryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.top.equalTo(identityLabel.snp.bottom)
        }

        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(categoryLabel)
            make.top.equalTo((categoryLabel.snp.bottom)).offset(10)
            make.width.lessThanOrEqualTo(contentView).offset(-20)
        }

        descLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.width.lessThanOrEqualTo(contentView).offset(-40)
            make.height.equalTo(30)
        }

        underline.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp.bottom).offset(5)
            make.left.equalTo(descLabel).offset(5)
            make.right.equalTo(headImgView)
        }

//        bottomView.snp.makeConstraints { (make) in
//            make.top.equalTo(underline.snp.bottom).offset(5)
//            make.left.right.equalTo(contentView)
//            make.height.equalTo(30)
//        }

    }

    // MARK: - 懒加载

    /// 缩略图
    private lazy var smallIconView: UIImageView = UIImageView()

    /// 作者
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14.0)
        label.text = "花田小憩";
        return label
    }()

    /// 称号
    private lazy var identityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12.0)
        label.text = "资深专家";
        label.textColor = UIColor.black.withAlphaComponent(0.9)
        return label
    }()

    /// 头像
    private lazy var headImgView: UIImageView = {
        let headimage = UIImageView()
        headimage.image = UIImage(named: "pc_default_avatar")
        headimage.layer.cornerRadius = 51 * 0.5
        headimage.layer.masksToBounds = true
        headimage.layer.borderWidth = 0.5
        headimage.layer.borderColor = UIColor.lightGray.cgColor
        headimage.isUserInteractionEnabled = true
        headimage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(HomeArticleCell.toProfile)))
        return headimage
    }()

    /// 认证
    private lazy var authView: UIImageView = {
        let auth = UIImageView()
        auth.image = UIImage(named: "personAuth")
        return auth
    }()

    /// 分类
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14)
        label.textColor = UIColor(r: 199, g: 167, b: 98)
        label.text = "[家居庭院]";
        return label
    }()

    /// 标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 14)
        label.textColor = UIColor.black
        label.text = "旧物改造的灯旧物改造的灯旧物改造的";
        return label
    }()

    /// 摘要
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.init(name: "CODE LIGHT", size: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.8)
        label.text = "呵呵呵呵呵呵呵阿里大好事老客服哈;是打发;圣达菲号;是都发生法adfasdfasdfasdf";
        label.numberOfLines = 2
        return label
    }()

    /// 下划线
    let underline: UIImageView = {
        let underline = UIImageView(image: UIImage(named: "underLine"))
        return underline
    }()

//    private lazy var bottomView: ToolBottomView = ToolBottomView()

    // MARK: - private method
    @objc private func toProfile() {
        clickHeadImage!(article)
    }
}
