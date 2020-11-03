//
//  BackgroundItemTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/11/3.
//

import UIKit

fileprivate class _ItemContainerView: GLTabBarItemContainerView {
    override init() {
        super.init()
        self.selectedBackgroundColor = .red
        self.normalBackgroundColor = .white
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class BackgroundItemTabBarController: GLTabBarController {

    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    
    private lazy var quanquanItemContainerView: _ItemContainerView = {
        let quanquanItemContainerView = _ItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        quanquanItemContainerView.title = "圈圈"
        return quanquanItemContainerView
    }()
    
    private lazy var tantanItemContainerView: _ItemContainerView = {
        let tantanItemContainerView = _ItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        tantanItemContainerView.title = "摊摊"
        return tantanItemContainerView
    }()
    
    private lazy var messageeItemContainerView: _ItemContainerView = {
        let messageeItemContainerView = _ItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        messageeItemContainerView.title = "消息"
        return messageeItemContainerView
    }()
    
    private lazy var meItemContainerView: _ItemContainerView = {
        let meItemContainerView = _ItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        meItemContainerView.title = "我的"
        return meItemContainerView
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        
        let vc1 = BackgroundItemController()
        let vc2 = BackgroundItemController()
        let vc3 = BackgroundItemController()
        let vc4 = BackgroundItemController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        
        self.viewControllers = [navi1, navi2, navi3, navi4]
        
        if let myTabBar = self.tabBar as? GLTabBar {
            myTabBar.isTranslucent = false
            myTabBar.barTintColor = .white
            myTabBar.layoutType = .fillUp
            
        }
    }
}
