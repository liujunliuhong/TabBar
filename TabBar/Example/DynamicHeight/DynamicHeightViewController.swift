//
//  DynamicHeightViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit
import SnapKit

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
    
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
    }
    

    @objc private func dismissAction() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func buttonClickAction() {
        let heights: [CGFloat] = [20, 30, 40, 50, 60, 70, 80]
        let index = arc4random() % UInt32(heights.count)
        let height = heights[Int(index)]
        let tabBarVC = self.tabBarController as? GLTabBarController
//        tabBarVC?.incrementTabBarHeight = height
        (tabBarVC?.tabBar as? GLTabBar)?.incrementTabBarHeight = height
        // 高度如果比较大，会使图片和文字之间的间距增加，若要进行矫正，可以修改`GLTabBarItemContainerView`的`insets`属性
    }
}
