//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class MultiplierTests: XCTestCase {

    // MARK: - Anchor API

    func test_AnchorApi_DimensionalAnchoringToOtherWithMultiplier() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, multiplier: 1.5)

            XCTAssertEqual(constraint.multiplier, 1.5)
        }
    }
}
