//
//  SBUHighlightInfo.swift
//  SendBirdUIKit
//
//  Created by Hoon Sung on 2021/02/15.
//  Copyright © 2021 Sendbird, Inc. All rights reserved.
//

import Foundation
import SendBirdSDK

@objcMembers
public class SBUHighlightMessageInfo: NSObject {
    
    public let messageId: Int64
    public let updatedAt: Int64
    public let keyword: String?
    
    public init(messageId: Int64, updatedAt: Int64, keyword: String? = nil) {
        self.messageId = messageId
        self.updatedAt = updatedAt
        self.keyword = keyword
    }
}
