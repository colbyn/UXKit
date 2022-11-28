//
//  LinearScale.swift
//  UXKitGenesis
//
//  Created by Colbyn Wadman on 11/18/22.
//

import Foundation

struct LinearScale {
    private let domain: (CGFloat, CGFloat)
    private let range: (CGFloat, CGFloat)
    init(domain: (CGFloat, CGFloat), range: (CGFloat, CGFloat)) {
        self.domain = domain
        self.range = range
    }
    func scale(_ value: CGFloat) -> CGFloat {
        let minDomain = domain.0;
        let maxDomain = domain.1;
        let minRange = range.0;
        let maxRange = range.1;
        return (maxRange - minRange) * (value - minDomain) / (maxDomain - minDomain) + minRange
    }
}
