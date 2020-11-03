//
//  OnlyImageTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/11/3.
//

import UIKit

public class OnlyImageTabBarController: GLTabBarController {

    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    
    private lazy var quanquanItemContainerView: GLTabBarItemContainerView = {
        let quanquanItemContainerView = GLTabBarItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        return quanquanItemContainerView
    }()
    
    private lazy var tantanItemContainerView: GLTabBarItemContainerView = {
        let tantanItemContainerView = GLTabBarItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        return tantanItemContainerView
    }()
    
    private lazy var messageeItemContainerView: GLTabBarItemContainerView = {
        let messageeItemContainerView = GLTabBarItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        return messageeItemContainerView
    }()
    
    private lazy var meItemContainerView: GLTabBarItemContainerView = {
        let meItemContainerView = GLTabBarItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        return meItemContainerView
    }()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        
        let vc1 = OnlyImageViewController()
        let vc2 = OnlyImageViewController()
        let vc3 = OnlyImageViewController()
        let vc4 = OnlyImageViewController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        
        self.viewControllers = [navi1, navi2, navi3, navi4]
    }
}

