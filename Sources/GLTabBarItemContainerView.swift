//
//  GLTabBarItemContainerView.swift
//  SwiftTool
//
//  Created by galaxy on 2020/10/27.
//  Copyright © 2020 yinhe. All rights reserved.
//

import UIKit

private let _clearColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)

open class GLTabBarItemContainerView: UIView {
    
    public private(set) var isSelected: Bool = false
    
    public var insets = UIEdgeInsets.zero {
        didSet {
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        }
    }
    
    public var normalTextColor: UIColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var selectedTextColor: UIColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var normalIconColor: UIColor = UIColor(white: 0.57254902, alpha: 1.0) {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var selectedIconColor: UIColor = UIColor(red: 0.0, green: 0.47843137, blue: 1.0, alpha: 1.0) {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var normalBackgroundColor: UIColor = _clearColor {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var selectedBackgroundColor: UIColor = _clearColor {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var normalImage: UIImage? {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var selectedImage: UIImage? {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var title: String? {
        didSet {
            self.updateDisplay()
            self.updateLayout()
        }
    }
    
    public var iconRenderingMode: UIImage.RenderingMode = UIImage.RenderingMode.alwaysOriginal {
        didSet {
            self.updateDisplay()
        }
    }
    
    public var badgeOffset: UIOffset = UIOffset(horizontal: 6.0, vertical: -22.0) {
        didSet {
            if badgeOffset != oldValue {
                self.updateLayout()
            }
        }
    }
    
    public var titlePositionAdjustment: UIOffset = UIOffset.zero {
        didSet {
            self.updateLayout()
        }
    }
    
    public var imagePositionAdjustment: UIOffset = UIOffset.zero {
        didSet {
            self.updateLayout()
        }
    }
    
    public var imageWidth: CGFloat = 20.0 {
        didSet {
            self.updateLayout()
        }
    }
    
    public var font: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            self.updateDisplay()
            self.updateLayout()
        }
    }
    
    public private(set) lazy var badgeView: GLTabBarBadgeView = {
        let badgeView = GLTabBarBadgeView()
        return badgeView
    }()
//
//    open var badgeValue: String? {
//        didSet {
//            if let _ = badgeValue {
//                self.badgeView.badgeValue = badgeValue
//                self.addSubview(badgeView)
//                self.updateLayout()
//            } else {
//                // Remove when nil.
//                self.badgeView.removeFromSuperview()
//            }
//            self.badgeChanged(animated: true, completion: nil)
//        }
//    }
//
//    public var badgeView: SwiftyTabBarBadgeView = SwiftyTabBarBadgeView() {
//        willSet {
//            if let _ = badgeView.superview {
//                badgeView.removeFromSuperview()
//            }
//        }
//        didSet {
//            if let _ = badgeView.superview {
//                self.updateLayout()
//            }
//        }
//    }
//
//
    
    
    public lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .clear
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        setupUI()
        updateDisplay()
    }
    
    public init() {
        super.init(frame: .zero)
        initUI()
        setupUI()
        updateDisplay()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GLTabBarItemContainerView {
    private func initUI() {
        self.isUserInteractionEnabled = false
    }
    
    private func setupUI() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.badgeView)
        self.badgeView.layoutChangeClosure = { [weak self] in
            guard let self = self else { return }
            self.updateLayout()
        }
    }
    
    private func updateDisplay() {
        self.superview?.backgroundColor = self.isSelected ? self.selectedBackgroundColor : self.normalBackgroundColor
        self.imageView.image = (self.isSelected ? (self.selectedImage ?? self.normalImage) : self.normalImage)?.withRenderingMode(self.iconRenderingMode)
        self.imageView.tintColor = self.isSelected ? self.selectedIconColor : self.normalIconColor
        self.titleLabel.textColor = self.isSelected ? self.selectedTextColor : self.normalTextColor
        self.backgroundColor = self.isSelected ? self.selectedBackgroundColor : self.normalBackgroundColor
        self.titleLabel.text = self.title
        self.titleLabel.font = self.font
    }
}


extension GLTabBarItemContainerView {
    open func updateLayout() {
        self.imageView.isHidden = (self.imageView.image == nil)
        self.titleLabel.isHidden = (self.titleLabel.text ?? "").count <= 0
        
        let w = self.bounds.size.width
        let h = self.bounds.size.height
        
        let isLandscape = UIApplication.shared.statusBarOrientation.isLandscape
        let isWide = isLandscape || traitCollection.horizontalSizeClass == .regular
        
        if !self.imageView.isHidden && !self.titleLabel.isHidden {
            self.titleLabel.sizeToFit()
            
            var titleWidth = self.titleLabel.bounds.size.width
            
            if #available(iOS 11, *), isWide {
                // If it is iOS 11, and it is horizontal screen (icons and text are arranged horizontally)
                let space: CGFloat = 5.0 // image and title space
                
                titleWidth = min(titleWidth, (w - self.imageWidth - space))
                
                let sumWidth: CGFloat = self.imageWidth + space + titleWidth
                
                self.imageView.frame = CGRect(x: (w - sumWidth) / 2.0 + self.imagePositionAdjustment.horizontal,
                                              y: (h - self.imageWidth) / 2.0 + self.imagePositionAdjustment.vertical,
                                              width: self.imageWidth,
                                              height: self.imageWidth)
                
                self.titleLabel.frame = CGRect(x: w - (w - sumWidth) / 2.0 - titleWidth + self.titlePositionAdjustment.horizontal,
                                               y: (h - self.titleLabel.bounds.height) / 2.0 + self.titlePositionAdjustment.vertical,
                                               width: titleWidth,
                                               height: self.titleLabel.bounds.height)
                
            } else {
                titleWidth = min(titleWidth, w)
                
                self.titleLabel.frame = CGRect(x: (w - titleWidth) / 2.0 + self.titlePositionAdjustment.horizontal,
                                               y: h - self.titleLabel.bounds.height - 2.0 + self.titlePositionAdjustment.vertical,
                                               width: titleWidth,
                                               height: self.titleLabel.bounds.height)
                
                self.imageView.frame = CGRect(x: (w - self.imageWidth) / 2.0 + self.imagePositionAdjustment.horizontal,
                                              y: (h - self.imageWidth) / 2.0 - 6.0 + self.imagePositionAdjustment.vertical,
                                              width: self.imageWidth,
                                              height: self.imageWidth)
            }
        } else if !self.imageView.isHidden {
            self.imageView.frame = CGRect(x: (w - self.imageWidth) / 2.0 + self.imagePositionAdjustment.horizontal,
                                          y: (h - self.imageWidth) / 2.0 + self.imagePositionAdjustment.vertical,
                                          width: self.imageWidth,
                                          height: self.imageWidth)
            
        } else if !self.titleLabel.isHidden {
            self.titleLabel.sizeToFit()
            let titleWidth = min(self.titleLabel.bounds.size.width, w)
            titleLabel.frame = CGRect(x: (w - titleWidth) / 2.0 + self.titlePositionAdjustment.horizontal,
                                      y: (h - self.titleLabel.bounds.size.height) / 2.0 + self.titlePositionAdjustment.vertical,
                                      width: titleWidth,
                                      height: self.titleLabel.bounds.size.height)
        }
        
        
        let badgeSize = self.badgeView.intrinsicContentSize
        if #available(iOS 11.0, *), isWide {
            self.badgeView.frame = CGRect(x: self.imageView.frame.midX - 3 + self.badgeOffset.horizontal,
                                          y: self.imageView.frame.midY + 3 + self.badgeOffset.vertical,
                                          width: badgeSize.width,
                                          height: badgeSize.height)
        } else {
            self.badgeView.frame = CGRect(x: w / 2.0 + self.badgeOffset.horizontal,
                                          y: h / 2.0 + self.badgeOffset.vertical,
                                          width: badgeSize.width,
                                          height: badgeSize.height)
        }
    }
}

extension GLTabBarItemContainerView {
    /// 选中
    internal final func _select(animated: Bool, completion: (() -> ())?) {
        self.isSelected = true
        self.updateDisplay()
        self.select()
    }
    
    /// 取消选中
    internal final func _deselect(animated: Bool, completion: (() -> ())?) {
        self.isSelected = false
        self.updateDisplay()
        self.deselect()
    }
    
    /// 重新选中
    internal final func _reselect(animated: Bool, completion: (() -> ())?) {
        if self.isSelected == false {
            self.select()
        } else {
            self.reselect()
        }
    }
}

extension GLTabBarItemContainerView {
    open func select() {
        
    }
    
    open func deselect() {
        
    }
    
    open func reselect() {
        
    }
}
