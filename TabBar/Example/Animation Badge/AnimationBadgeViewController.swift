//
//  AnimationBadgeViewController.swift
//  TabBar
//
//  Created by galaxy on 2020/11/3.
//

import UIKit

public class AnimationBadgeViewController: UIViewController {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        self.navigationItem.title = "Badge动画"
    }
    
    @objc private func dismissAction() {
        self.tabBarController?.dismiss(animated: true, completion: nil)
    }
}
