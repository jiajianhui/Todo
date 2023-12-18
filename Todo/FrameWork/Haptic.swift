//
//  Haptic.swift
//  Todo
//
//  Created by 贾建辉 on 2023/12/18.
//

import Foundation
import SwiftUI

extension UIImpactFeedbackGenerator {
    static func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
