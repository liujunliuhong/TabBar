//
//  IndicatorTabBarController.swift
//  TabBar
//
//  Created by galaxy on 2020/11/3.
//

import UIKit

extension Notification.Name {
    fileprivate static let name = Notification.Name(rawValue: "notification")
}

fileprivate class _ItemContainerView: GLTabBarItemContainerView {
    override init() {
        super.init()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func select() {
        let newFrame = self.convert(self.frame, to: self.tabBar) // frame转换
        print("\(newFrame)")
        NotificationCenter.default.post(name: .name, object: nil, userInfo: ["frame": newFrame])
    }
    override func reselect() {
        let newFrame = self.convert(self.frame, to: self.tabBar) // frame转换
        print("\(newFrame)")
        NotificationCenter.default.post(name: .name, object: nil, userInfo: ["frame": newFrame])
    }
}

fileprivate class _BackgroundView: UIView {
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.orange.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        return gradientLayer
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    init() {
        super.init(frame: .zero)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        self.layer.addSublayer(self.gradientLayer)
        NotificationCenter.default.addObserver(self, selector: #selector(change(noti:)), name: .name, object: nil)
    }
    
    @objc func change(noti: Notification) {
        guard let frame = noti.userInfo?["frame"] as? CGRect else { return }
        //CATransaction.begin()
        //CATransaction.setDisableActions(true)
        self.gradientLayer.frame = frame.inset(by: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        self.gradientLayer.cornerRadius = frame.height / 2.0
        self.gradientLayer.masksToBounds = true
        //CATransaction.commit()
    }
}


public class IndicatorTabBarController: GLTabBarController {

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
        
        let vc1 = IndicatorViewController()
        let vc2 = IndicatorViewController()
        let vc3 = IndicatorViewController()
        let vc4 = IndicatorViewController()
        let navi1 = Navi(rootViewController: vc1)
        let navi2 = Navi(rootViewController: vc2)
        let navi3 = Navi(rootViewController: vc3)
        let navi4 = Navi(rootViewController: vc4)
        
        navi1.tabBarItem = quanquanItem
        navi2.tabBarItem = tantanItem
        navi3.tabBarItem = messageItem
        navi4.tabBarItem = meItem
        
        if let myTabBar = self.tabBar as? GLTabBar {
            myTabBar.isTranslucent = false
            myTabBar.barTintColor = .white
            myTabBar.backgroundView = _BackgroundView()
        }
        
        self.viewControllers = [navi1, navi2, navi3, navi4]
    }
}
