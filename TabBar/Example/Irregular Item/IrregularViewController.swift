//
//  IrregularViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/10/30.
//

import UIKit

public class IrregularViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.navigationItem.title = "不规则tabbar"
    }
    
    @objc private func dismissAction() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
}
