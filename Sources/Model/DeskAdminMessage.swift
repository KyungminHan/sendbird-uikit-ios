//
//  DeskAdminMessage.swift
//  QuickStart
//
//  Created by Kyungmin Han on 2022/10/24.
//  Copyright © 2022 SendBird, Inc. All rights reserved.
//

import Foundation
import SendbirdChatSDK

final class DeskAdminMessage {
    private static let ADMIN_MESSAGE_CUSTOM_TYPE = "SENDBIRD_DESK_ADMIN_MESSAGE_CUSTOM_TYPE"
    private static let EVENT_TYPE_ASSIGN = "TICKET_ASSIGN"
    private static let EVENT_TYPE_TRANSFER = "TICKET_TRANSFER"
    private static let EVENT_TYPE_CLOSE = "TICKET_CLOSE"

    private static var filterList: [String] = [
        ADMIN_MESSAGE_CUSTOM_TYPE,
        EVENT_TYPE_ASSIGN,
        EVENT_TYPE_TRANSFER,
        EVENT_TYPE_CLOSE
    ]

    static func matched(_ message: AdminMessage) -> Bool {
        return filterList
            .filter { message.customType == $0 }
            .isEmpty == false
    }
}
