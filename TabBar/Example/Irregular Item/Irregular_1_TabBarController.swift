//
//  Irregular_1_TabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit

fileprivate class PlusItemContainerView: GLTabBarItemContainerView {
    
    override init() {
        super.init()
        self.normalImage = UIImage(named: "tab_bar_publish")
        self.selectedImage = UIImage(named: "tab_bar_publish")
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateLayout() {
        super.updateLayout()
        let imageSize: CGSize = CGSize(width: 90, height: 90)
        self.imageView.center = CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0 - 15)
        self.imageView.bounds = CGRect(origin: .zero, size: imageSize)
    }
}

fileprivate class _PlusViewController: UIViewController {
    
}

public class Irregular_1_TabBarController: GLTabBarController {

    private lazy var quanquanItemContainerView: GLTabBarItemContainerView = {
        let quanquanItemContainerView = GLTabBarItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        quanquanItemContainerView.title = "圈圈"
        return quanquanItemContainerView
    }()
    
    private lazy var tantanItemContainerView: GLTabBarItemContainerView = {
        let tantanItemContainerView = GLTabBarItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        tantanItemContainerView.title = "摊摊"
        return tantanItemContainerView
    }()
    
    private lazy var messageeItemContainerView: GLTabBarItemContainerView = {
        let messageeItemContainerView = GLTabBarItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        messageeItemContainerView.title = "消息"
        return messageeItemContainerView
    }()
    
    private lazy var meItemContainerView: GLTabBarItemContainerView = {
        let meItemContainerView = GLTabBarItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        meItemContainerView.title = "我的"
        return meItemContainerView
    }()
    
    private lazy var plusContainerView: PlusItemContainerView = {
        let plusContainerView = PlusItemContainerView()
        return plusContainerView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        let plusItem = GLTabBarItem(containerView: self.plusContainerView)
        
        let vc1 = IrregularViewController()
        let vc2 = IrregularViewController()
        let vc3 = IrregularViewController()
        let vc4 = IrregularViewController()
        let vc5 = _PlusViewController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        vc5.tabBarItem = plusItem
        
        self.viewControllers = [navi1, navi2, vc5, navi3, navi4]
        
        self.canHijackHandler = { (_, _, index) -> Bool in
            if index == 2 {
                return true
            }
            return false
        }
        
        self.didHijackHandler = { (_, _, index) in
            if index == 2 {
                print("点击了plus按钮")
            }
        }
    }
}
