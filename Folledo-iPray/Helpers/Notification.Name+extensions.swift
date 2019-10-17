//
//  Notification.Name+extensions.swift
//  Folledo-iPray
//
//  Created by Macbook Pro 15 on 10/16/19.
//  Copyright © 2019 SamuelFolledo. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didCompleteTask = Notification.Name("didCompleteTask")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
}
