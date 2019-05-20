//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class SingleAnchorInsetTests: XCTestCase {

    // MARK: - Anchor API

    func test_AnchorApi_AnchoringTopWithInset() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.top, inset: 1)

            XCTAssertEqual(constraint.constant, 1)
        }
    }

    func test_AnchorApi_AnchoringLeftToLayoutGuideWithInset() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.left, to: .safeArea, inset: 2)

            XCTAssertEqual(constraint.constant, 2)
        }
    }

    func test_AnchorApi_AnchoringBottomToOtherWithInset_InvertsConstant() {
        let constraint = UIView().anchor(.bottom, to: UIView(), inset: 3)

        XCTAssertEqual(constraint.constant, -3)
    }

    func test_AnchorApi_AnchoringRightToLayoutGuideOfOtherWithInset_InvertsConstant() {
        let constraint = UIView().anchor(.right, to: .layoutMargins, of: UIView(), inset: 4)

        XCTAssertEqual(constraint.constant, -4)
    }

    // MARK: - Anchored API

    func test_AnchoredApi_AnchoringTopWithInset() throws {
        try viewAndSuperview { view, _ in

            let constraint = try view.anchored(.top, inset: 1)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 1)
        }
    }

    func test_AnchoredApi_AnchoringLeftToLayoutGuideWithInset() {
        viewAndSuperview { view, _ in

            let constraint = view.anchored(.left, to: .safeArea, inset: 2)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.constant, 2)
        }
    }

    func test_AnchoredApi_AnchoringBottomToOtherWithInset_InvertsConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchored(.bottom, to: two, inset: 3)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, -3)
        }
    }

    func test_AnchoredApi_AnchoringRightToLayoutGuideOfOtherWithInset_InvertsConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchored(.right, to: .layoutMargins, of: two, inset: 4)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, -4)
        }
    }
}
