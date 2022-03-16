//
//  HideOrShowViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/29.
//

import UIKit
import SnapKit

/*
 注意`tabbar`显示或者隐藏时，`tableView`是否被遮挡，需要动态改变`tableView`的`contentInset`
 同时需要在`viewWillLayoutSubviews`方法里面去改变`self.view的frame`
 */
public class HideOrShowViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.navigationItem.title = "tabbar的显示与隐藏"
        
        self.view.addSubview(self.tableView)
        
        self.updateTableViewInset()
    }
    
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.frame = UIScreen.main.bounds
    }
 
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds
    }
    
    
    @objc private func dismissAction() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
    
    private func updateTableViewInset() {
        let tabBarVC = self.tabBarController as? GLTabBarController
        let isHide = tabBarVC?.tabBar.isHidden ?? false
        if isHide {
            if #available(iOS 11.0, *) {
                self.tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height + 44.0,
                                                           left: 0,
                                                           bottom: UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0,
                                                           right: 0)
            } else {
                self.tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height + 44.0,
                                                           left: 0,
                                                           bottom: 0,
                                                           right: 0)
            }
            
            
        } else {
            self.tableView.contentInset = UIEdgeInsets(top: UIApplication.shared.statusBarFrame.height + 44.0,
                                                       left: 0,
                                                       bottom: self.tabBarController?.tabBar.frame.height ?? 0,
                                                       right: 0)
        }
    }
}

extension HideOrShowViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.classForCoder()))
        cell?.textLabel?.text = "显示或者隐藏tabbar"
        return cell!
    }
}

extension HideOrShowViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tabBarVC = self.tabBarController as? GLTabBarController
        var isHide = tabBarVC?.tabBar.isHidden ?? false
        isHide = !isHide
        tabBarVC?.tabBar.isHidden = isHide
        
        self.updateTableViewInset()
    }
}
