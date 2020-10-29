//
//  MixTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit

public class MixTabBarController: GLTabBarController {

    deinit {
        print("\(NSStringFromClass(self.classForCoder)) deinit")
    }
    
    private lazy var quanquanItemContainerView: GLTabBarItemContainerView = {
        let quanquanItemContainerView = GLTabBarItemContainerView()
        quanquanItemContainerView.normalImage = UIImage(named: "tab_bar_quanquan_normal")
        quanquanItemContainerView.selectedImage = UIImage(named: "tab_bar_quanquan_selected")
        quanquanItemContainerView.title = "圈圈"
        quanquanItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        quanquanItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return quanquanItemContainerView
    }()
    
    private lazy var tantanItemContainerView: GLTabBarItemContainerView = {
        let tantanItemContainerView = GLTabBarItemContainerView()
        tantanItemContainerView.normalImage = UIImage(named: "tab_bar_tantan_normal")
        tantanItemContainerView.selectedImage = UIImage(named: "tab_bar_tantan_selected")
        tantanItemContainerView.title = "摊摊"
        tantanItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        tantanItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return tantanItemContainerView
    }()
    
    private lazy var messageeItemContainerView: GLTabBarItemContainerView = {
        let messageeItemContainerView = GLTabBarItemContainerView()
        messageeItemContainerView.normalImage = UIImage(named: "tab_bar_message_normal")
        messageeItemContainerView.selectedImage = UIImage(named: "tab_bar_message_selected")
        messageeItemContainerView.title = "消息"
        messageeItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        messageeItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return messageeItemContainerView
    }()
    
    private lazy var meItemContainerView: GLTabBarItemContainerView = {
        let meItemContainerView = GLTabBarItemContainerView()
        meItemContainerView.normalImage = UIImage(named: "tab_bar_me_normal")
        meItemContainerView.selectedImage = UIImage(named: "tab_bar_me_selected")
        meItemContainerView.title = "我的"
        meItemContainerView.normalTextColor = UIColor.orange // 未选中状态下文本颜色
        meItemContainerView.selectedTextColor = UIColor.red // 选中状态下文本颜色
        return meItemContainerView
    }()
    
    private lazy var systemItem: UITabBarItem = {
        let systemItem = UITabBarItem(title: "系统", image: UIImage(named: "system_tab_normal")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "system_tab_select")?.withRenderingMode(.alwaysOriginal))
        return systemItem
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let quanquanItem = GLTabBarItem(containerView: self.quanquanItemContainerView)
        let tantanItem = GLTabBarItem(containerView: self.tantanItemContainerView)
        let messageItem = GLTabBarItem(containerView: self.messageeItemContainerView)
        let meItem = GLTabBarItem(containerView: self.meItemContainerView)
        
        let vc1 = MixViewController()
        let vc2 = MixViewController()
        let vc3 = MixViewController()
        let vc4 = MixViewController()
        let vc5 = MixViewController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        let navi5 = Navi(rootViewController: vc5)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        navi5.tabBarItem = self.systemItem
        
        self.viewControllers = [navi1, navi2, navi3, navi4, navi5]
    }
}
