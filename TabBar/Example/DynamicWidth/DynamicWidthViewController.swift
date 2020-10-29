//
//  DynamicWidthViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit


public class DynamicWidthViewController: UIViewController {

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
        self.navigationItem.title = "动态改变item宽度"
        
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
        let widths: [CGFloat] = [60, 70, 80, 90]
        let index = arc4random() % UInt32(widths.count)
        let width = widths[Int(index)]
        let item = self.navigationController?.tabBarItem as? GLTabBarItem
        item?.itemWidth = width
    }
}
