//
//  AlertManager.swift
//  SendBirdUIKit-Sample
//
//  Created by Tez Park on 2020/07/03.
//  Copyright © 2020 SendBird, Inc. All rights reserved.
//

import UIKit
import SendBirdSDK

// This function handles alertController to be used in the sample app.
class AlertManager: NSObject {
    static func show(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Close", style: .cancel, handler: nil)
        alert.addAction(closeAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController  {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showCustomInfo(_ function: String) {
        self.show(title: "Custom", message: "\(function) function can be customized.")
    }
}

// This function handles channel object to be used in the sample app.
class ChannelManager: NSObject {
    static func getSampleChannel(completionHandler: @escaping (_ channel: SBDGroupChannel) -> Void) {
        // Sendbird provides various access control options when using the Chat SDK. By default, the Allow retrieving user list attribute is turned on to facilitate creating sample apps. However, this may grant access to unwanted data or operations, leading to potential security concerns. To manage your access control settings, you can turn on or off each setting on Sendbird Dashboard.
        let channelListQuery = SBDGroupChannel.createMyGroupChannelListQuery()
        channelListQuery?.order = .latestLastMessage
        channelListQuery?.limit = 10
        channelListQuery?.includeEmptyChannel = true
        
        channelListQuery?.loadNextPage(completionHandler: { channels, error in
            guard error == nil else {
                SBULog.error(error?.localizedDescription)
                return
            }
            
            guard let channel = channels?.first else {
                AlertManager.show(title: "No channel", message: "Create a channel and proceed.")
                return
            }
            
            completionHandler(channel)
        })
    }
}
