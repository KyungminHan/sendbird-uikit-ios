//
//  SBUOpenChannelBaseMessageCell.swift
//  SendBirdUIKit
//
//  Created by Tez Park on 2020/10/27.
//  Copyright © 2020 Sendbird, Inc. All rights reserved.
//

import UIKit
import SendBirdSDK

@objcMembers @IBDesignable
open class SBUOpenChannelBaseMessageCell: UITableViewCell {
    // MARK: - Public
    public var message: SBDBaseMessage = .init()
    public var groupPosition: MessageGroupPosition = .none

    public lazy var dateView: UIView = SBUMessageDateView()

    public lazy var messageContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    @SBUThemeWrapper(theme: SBUTheme.messageCellTheme)
    public var theme: SBUMessageCellTheme
    @SBUThemeWrapper(theme: SBUTheme.overlayTheme.messageCellTheme, setToDefault: true)
    public var overlayTheme: SBUMessageCellTheme
    
    // MARK: - Private
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 16
        stackView.axis = .vertical
        return stackView
    }()
    
    var stackViewTopConstraint: NSLayoutConstraint?
    
    var isOverlay = false

    
    // MARK: - Action
    var userProfileTapHandler: (() -> Void)? = nil
    var tapHandlerToContent: (() -> Void)? = nil
    var longPressHandlerToContent: (() -> Void)? = nil


    // MARK: - View Lifecycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
        self.setupAutolayout()
        self.setupActions()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupViews()
        self.setupAutolayout()
        self.setupActions()
    }
    
    /// This function handles the initialization of views.
    open func setupViews() {
        self.dateView.isHidden = true
        
        self.stackView.addArrangedSubview(self.dateView)
        self.stackView.addArrangedSubview(self.messageContentView)
        
        self.contentView.addSubview(self.stackView)
    }
    
    /// This function handles the initialization of actions.
    open func setupActions() {
        
    }
    
    /// This function handles the initialization of autolayouts.
    open func setupAutolayout() {
        self.stackView
            .setConstraint(from: self.contentView, left: 0, bottom: 0)
            .setConstraint(from: self.contentView, right: 0)
        
        self.updateTopAnchorConstraint()
    }

    /// This function handles the initialization of styles.
    open func setupStyles() {
        self.backgroundColor = .clear
        
        if let dateView = self.dateView as? SBUMessageDateView {
            dateView.setupStyles()
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.setupStyles()
    }
    
    func updateTopAnchorConstraint() {
        let isGrouped = SBUGlobals.UsingMessageGrouping
        && self.groupPosition != .none
        && self.groupPosition != .top
        let constant: CGFloat = isGrouped ? 4 : 16
        
        self.stackViewTopConstraint?.isActive = false
        self.stackViewTopConstraint = self.stackView.topAnchor.constraint(
            equalTo: self.contentView.topAnchor,
            constant: constant
        )
        self.stackViewTopConstraint?.isActive = true
    }
    
    
    // MARK: - Common
    
    /// This function configure a cell using informations.
    /// - Parameters:
    ///   - message: Message object
    ///   - hideDateView: Hide or expose date information
    ///   - isOverlay: Whether to use in overlay
    open func configure(message: SBDBaseMessage,
                        hideDateView: Bool,
                        groupPosition: MessageGroupPosition = .none,
                        isOverlay: Bool = false) {
        self.message = message
        self.groupPosition = groupPosition
        self.dateView.isHidden = hideDateView
        self.isOverlay = isOverlay
        
        if let dateView = self.dateView as? SBUMessageDateView {
            dateView.configure(timestamp: self.message.createdAt)
        }
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        let theme = self.isOverlay ? self.overlayTheme : self.theme
        
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = theme.leftBackgroundColor
        } else {
            self.backgroundColor = theme.backgroundColor
        }
    }
    
    // MARK: -
    open override func prepareForReuse() {
        super.prepareForReuse()
    }
}
