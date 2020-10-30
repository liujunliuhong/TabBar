//
//  ViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/27.
//

import UIKit

fileprivate class Model{
    let cls: AnyClass
    let title: String?
    init(title: String?, cls: AnyClass) {
        self.title = title
        self.cls = cls
    }
}



public class ViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        return tableView
    }()
    
    private var dataSource: [Model] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .always
        } else {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        self.view.addSubview(self.tableView)
        
        let model1 = Model(title: "动态修改TabBar高度", cls: DynamicHeightTabBarController.classForCoder())
        let model2 = Model(title: "badge的各种样式", cls: BadgeTabBarController.classForCoder())
        let model3 = Model(title: "GLTabBarItem 和 UITabBarItem 混合使用", cls: MixTabBarController.classForCoder())
        let model4 = Model(title: "动态修改item宽度", cls: DynamicWidthTabBarController.classForCoder())
        let model5 = Model(title: "拦截点击事件(index=1的item将被拦截)", cls: HijackTabBarController.classForCoder())
        let model6 = Model(title: "显示或者隐藏tabbar", cls: HideOrShowTabBarController.classForCoder())
        let model7 = Model(title: "不规则tabbar - 1", cls: Irregular_1_TabBarController.classForCoder())
        self.dataSource = [model1, model2, model3, model4, model5, model6, model7]
        self.tableView.reloadData()
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
}

extension ViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        let model = self.dataSource[indexPath.row]
        cell?.textLabel?.text = model.title
        return cell!
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.dataSource[indexPath.row]
        guard let cls = model.cls as? UIViewController.Type else {
            return
        }
        let vc = cls.init()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
