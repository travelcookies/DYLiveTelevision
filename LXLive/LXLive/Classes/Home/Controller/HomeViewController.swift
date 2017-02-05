//
//  HomeViewController.swift
//  LXLive
//
//  Created by pxl on 2017/1/18.
//  Copyright © 2017年 pxl. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40


class HomeViewController: UIViewController {
    
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
        }()
    
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        
        // 1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView
        }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK:- 懒加载属性
        
        
        
        setupUI()
        
        
        
    }
    
    
}


// MARK:- 设置UI界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        // 1.设置导航栏
        setupNavigationBar()
        
        // 2.添加TitleView
        view.addSubview(pageTitleView)
        
        // 3.添加ContentView
        view.addSubview(pageContentView)
    }
    
    
    private func setupNavigationBar(){
        let size = CGSize(width: 40, height: 40)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageNormal: #imageLiteral(resourceName: "logo"))
        
        let historyItem = UIBarButtonItem(imageNormal: #imageLiteral(resourceName: "image_my_history"), imageHigh: #imageLiteral(resourceName: "Image_my_history_click"), size: size)
        
        let searchItem = UIBarButtonItem(imageNormal: #imageLiteral(resourceName: "btn_search"), imageHigh: #imageLiteral(resourceName: "btn_search_clicked"), size: size)
        
        let qrcodeItem = UIBarButtonItem(imageNormal: #imageLiteral(resourceName: "Image_scan"), imageHigh: #imageLiteral(resourceName: "Image_scan_click"), size: size)
        
        navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}


// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


extension HomeViewController{
}
