//
//  UXFont.swift
//  UXKitGenesis
//
//  Created by Colbyn Wadman on 11/20/22.
//

import Foundation

extension UX {
    struct FontStyle {
        let size: Double
        let design: Design
        let weight: Weight
        func with(size: Double) -> FontStyle {
            FontStyle(size: size, design: self.design, weight: self.weight)
        }
        func with(design: Design) -> FontStyle {
            FontStyle(size: self.size, design: design, weight: self.weight)
        }
        func with(weight: Weight) -> FontStyle {
            FontStyle(size: self.size, design: self.design, weight: weight)
        }
        static func `default`() -> FontStyle {
            FontStyle(size: 12, design: Design.default, weight: Weight.regular)
        }
    }
}

extension UX.FontStyle {
    enum Design {
        case `default`
        case serif
        case rounded
        case monospaced
    }
}

extension UX.FontStyle {
    enum Weight {
        case ultraLight
        case thin
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        case black
    }
}
