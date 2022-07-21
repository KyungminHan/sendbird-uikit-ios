//
//  String+SBUIKit.swift
//  SendBirdUIKit
//
//  Created by Tez Park on 2021/05/21.
//  Copyright © 2021 Sendbird, Inc. All rights reserved.
//

import Foundation

extension String {
    var persistantHash: Int {
        return self.utf8.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
}

extension String {
    func containIndexes(in ranges: [Range<String.Index>]) -> [(start: Int, end: Int)] {
        return ranges.map {
            let startIndex = $0.lowerBound.utf16Offset(in: self)
            let endIndex = $0.upperBound.utf16Offset(in: self)
            return (start: startIndex, end: endIndex)
        }
    }

    func ranges(of targetString: Self, options: String.CompareOptions = [], locale: Locale? = nil) -> [Range<String.Index>] {
        let result: [Range<String.Index>] = self.indices.compactMap { startIndex in
            let targetStringEndIndex = index(startIndex, offsetBy: targetString.count, limitedBy: endIndex) ?? endIndex
            return range(of: targetString, options: options, range: startIndex..<targetStringEndIndex, locale: locale)
        }
        return result
    }
}
