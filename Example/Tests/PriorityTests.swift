//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class PriorityTests: XCTestCase {

    // MARK: - Anchor API

    func testAnchorApi_AnchoringWithPriority() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.random, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testAnchorApi_AnchoringToLayoutGuideWithPriority() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.random, to: .safeArea, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    func testAnchorApi_AnchoringToOtherWithPriority() {
        let constraint = UIView().anchor(.random, to: UIView(), priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testAnchorApi_AnchoringToLayoutGuideOfOtherWithPriority() {
        let constraint = UIView().anchor(.random, to: .layoutMargins, of: UIView(), priority: .defaultHigh)

        XCTAssertEqual(constraint.priority, .defaultHigh)
    }

    func testAnchorApi_DimensionalAnchoringWithPriority() {
        let constraint = UIView().anchor(.width, to: 123, priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testAnchorApi_DimensionalAnchoringToOtherWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testAnchorApi_XAnchoringWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.left, to: .right, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    func testAnchorApi_YAnchoringWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testAnchorApi_DirectionalXAnchoringWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .trailing, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    // MARK: - Anchored API

    func testAnchoredApi_AnchoringWithPriority() throws {
        try viewAndSuperview { view, superview in

            let constraint = try view.anchored(.random, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testAnchoredApi_AnchoringToLayoutGuideWithPriority() {
        viewAndSuperview { view, superview in

            let constraint = view.anchored(.random, to: .safeArea, priority: .defaultHigh)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    func testAnchoredApi_AnchoringToOtherWithPriority() throws {
        try siblings { one, two in
            let constraint = try one.anchored(.random, to: two, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testAnchoredApi_AnchoringToLayoutGuideOfOtherWithPriority() throws {
        try siblings { one, two in

            let constraint = try one.anchored(.random, to: .layoutMargins, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    // MARK: - Anchoring API

    func testAnchoringApi_DimensionalAnchoringWithPriority() throws {
        let constraint = try UIView()
            .anchoring(.width, to: 123, priority: .defaultLow)
            .constraints
            .onlyElement()

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testAnchoringApi_XAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.left, to: .right, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    func testAnchoringApi_YAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.top, to: .bottom, of: two, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testAnchoringApi_DirectionalXAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.leading, to: .trailing, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }
}
