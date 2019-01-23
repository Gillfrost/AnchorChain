//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchorTests_IsActive: XCTestCase {

    func testActiveDimensionalAnchor() {
        let view = UIView()
        let constraint = view.anchor(.width, to: 123, isActive: true)

        XCTAssertTrue(constraint.isActive)
    }

    func testInactiveDimensionalAnchor() {
        let view = UIView()
        let constraint = view.anchor(.width, to: 123, isActive: false)

        XCTAssertFalse(constraint.isActive)
    }

    func testActiveAnchorToImplicitSuperview() {
        let superview = UIView()
        let view = UIView()

        superview.addSubview(view)
        let constraint = view.anchor(.centerX, isActive: true)

        XCTAssertTrue(constraint.isActive)
    }

    func testInactiveAnchorToImplicitSuperview() {
        let superview = UIView()
        let view = UIView()

        superview.addSubview(view)
        let constraint = view.anchor(.centerX, isActive: false)

        XCTAssertFalse(constraint.isActive)
    }

    func testActiveAnchorToExplicitSuperview() {
        let view = UIView()
        let superview = UIView()

        let constraint = view.anchor(.centerY, to: superview, isActive: true)

        XCTAssertTrue(constraint.isActive)
    }

    func testInactiveAnchorToExplicitSuperview() {
        let view = UIView()
        let superview = UIView()

        let constraint = view.anchor(.centerY, to: superview, isActive: false)

        XCTAssertFalse(constraint.isActive)
    }

    func testActiveXAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.left, to: .right, of: two, isActive: true)

            XCTAssertTrue(constraint.isActive)
        }
    }

    func testInactiveXAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.left, to: .right, of: two, isActive: false)

            XCTAssertFalse(constraint.isActive)
        }
    }

    func testActiveYAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, isActive: true)

            XCTAssertTrue(constraint.isActive)
        }
    }

    func testInactiveYAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, isActive: false)

            XCTAssertFalse(constraint.isActive)
        }
    }

    func testActiveDimensionalXAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .centerX, of: two, isActive: true)

            XCTAssertTrue(constraint.isActive)
        }
    }

    func testInactiveDimensionalXAnchor() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .centerX, of: two, isActive: false)

            XCTAssertFalse(constraint.isActive)
        }
    }
}
