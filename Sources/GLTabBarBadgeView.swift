//
//  GLTabBarBadgeView.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

private let _defaultBadgeColor = UIColor(red: 255.0/255.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
private let _defaultDotSize = CGSize(width: 8.0, height: 8.0)
private let _defaultBadgeHeight: CGFloat = 18.0
private let _whiteColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
private let _clearColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
private let _defaultFont: UIFont = UIFont.systemFont(ofSize: 13.0)


public class GLTabBarBadgeView: UIView {
    
    public var badgeValue: String? {
        didSet {
            self.badgeLabel.text = badgeValue
            self.invalidateIntrinsicContentSize()
            self.layoutChangeClosure?()
        }
    }
    
    public var incrementWidth: CGFloat = 8.0 {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.layoutChangeClosure?()
        }
    }
    
    public var badgeColor: UIColor? = _defaultBadgeColor {
        didSet {
            self.backgroundColor = badgeColor
        }
    }
    
    public var badgeContentColor: UIColor? = _whiteColor {
        didSet {
            self.badgeLabel.textColor = badgeContentColor
        }
    }
    
    public var badgeContentFont: UIFont = _defaultFont {
        didSet {
            self.badgeLabel.font = badgeContentFont
        }
    }
    
    public var dotSize: CGSize = _defaultDotSize {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.layoutChangeClosure?()
        }
    }
    
    public var badgeHeight: CGFloat = _defaultBadgeHeight {
        didSet {
            self.invalidateIntrinsicContentSize()
            self.layoutChangeClosure?()
        }
    }
    
    public var badgeBorderWidth: CGFloat = .zero {
        didSet {
            self.layer.borderWidth = badgeBorderWidth
        }
    }
    
    public var badgeBorderColor: UIColor = _clearColor {
        didSet {
            self.layer.borderColor = badgeBorderColor.cgColor
        }
    }
    
    /// 布局改变的回调
    public var layoutChangeClosure: (()->())?
    
    
    private lazy var badgeLabel: UILabel = {
        let badgeLabel = UILabel.init(frame: CGRect.zero)
        badgeLabel.backgroundColor = _clearColor
        badgeLabel.font = UIFont.systemFont(ofSize: 13.0)
        badgeLabel.textAlignment = .center
        badgeLabel.numberOfLines = 1
        return badgeLabel
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setupUI()
    }
    
    public init() {
        super.init(frame: .zero)
        initUI()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GLTabBarBadgeView {
    private func initUI() {
        self.backgroundColor = self.badgeColor
        self.badgeLabel.textColor = self.badgeContentColor
        self.badgeLabel.font = self.badgeContentFont
        self.layer.borderWidth = self.badgeBorderWidth
        self.layer.borderColor = self.badgeBorderColor.cgColor
    }
    
    private func setupUI() {
        self.addSubview(self.badgeLabel)
    }
}


extension GLTabBarBadgeView {
    public override func layoutSubviews() {
        super.layoutSubviews()
        guard let badgeValue = self.badgeValue else {
            self.badgeLabel.isHidden = true
            self.isHidden = true
            return
        }
        self.isHidden = false
        if badgeValue == "" {
            self.badgeLabel.isHidden = true
        } else {
            self.badgeLabel.isHidden = false
            self.badgeLabel.frame = self.bounds
        }
        self.layer.cornerRadius = self.frame.height / 2.0
        self.layer.masksToBounds = true
    }
    
    
    public override var intrinsicContentSize: CGSize {
        guard let badgeValue = self.badgeValue else {
            return .zero
        }
        if badgeValue == "" {
            return self.dotSize
        } else {
            let textSize = self.badgeLabel.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
            let height: CGFloat = self.badgeHeight
            var width: CGFloat = textSize.width + self.incrementWidth
            if width.isLess(than: height) {
                width = height
            }
            return CGSize(width: width, height: height)
        }
    }
}
