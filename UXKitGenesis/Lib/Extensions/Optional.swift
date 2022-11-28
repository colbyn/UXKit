//
// Created by Colbyn Wadman on 11/20/22.
//

import Foundation

extension Optional {
    var isNone: Bool {
        switch self {
        case .none: return true
        default: return false
        }
    }
    var isSome: Bool {
        switch self {
        case .some(_): return true
        default: return false
        }
    }
}
