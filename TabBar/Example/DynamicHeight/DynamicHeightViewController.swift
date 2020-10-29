//
//  DynamicHeightViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit

public class DynamicHeightViewController: UIViewController {

    lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("点我试试", for: .normal)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonClickAction), for: .touchUpInside)
        return button
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.navigationItem.title = "动态改变tabBar高度"
        
        self.view.addSubview(self.button)
        
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.button.center = self.view.center
        self.button.bounds = CGRect(x: 0, y: 0, width: 150, height: 50)
    }

    @objc private func dismissAction() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func buttonClickAction() {
        let heights: [CGFloat] = [60, 70, 80, 90, 100, 120, 130]
        let index = arc4random() % UInt32(heights.count)
        let height = heights[Int(index)]
        let tabBarVC = self.tabBarController as? GLTabBarController
        tabBarVC?.tabBarHeight = height /// 高度如果比较大，会使图片和文字之间的间距增加，若要进行矫正，可以使用`GLTabBarItemContainerView`的`insets`属性
    }
}
