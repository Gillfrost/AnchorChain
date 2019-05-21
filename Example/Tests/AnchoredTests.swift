//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoredTests: XCTestCase {

    // MARK: - Default parameters

    func testTargetDefaultsToSuperview() {
        viewAndSuperview { view, superview in
            expect(view.anchored(), toMatch: superview)
        }
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchored(anchor, to: other)

            expect(anchor.layoutAttribute, of: view, toMatch: other)
        }
    }
}
