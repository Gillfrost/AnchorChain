//  Copyright (c) 2019 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class ConstantTests: XCTestCase {

    // MARK: - Anchor API

    func testAnchorApi_YAnchoringWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, constant: 123)

            XCTAssertEqual(constraint.constant, 123)
        }
    }

    func testAnchorApi_XAnchoringWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.right, to: .left, of: two, constant: 231)

            XCTAssertEqual(constraint.constant, 231)
        }
    }

    func testAnchorApi_DirectionalXAnchoringWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .trailing, of: two, constant: 312)

            XCTAssertEqual(constraint.constant, 312)
        }
    }

    func testAnchorApi_DimensionalAnchoringToOtherWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, constant: 123)

            XCTAssertEqual(constraint.constant, 123)
        }
    }

    // MARK: - Anchoring API

    func testAnchoringApi_YAnchoringWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.top, to: .bottom, of: two, constant: 123)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 123)
        }
    }

    func testAnchoringApi_XAnchoringWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.right, to: .left, of: two, constant: 231)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 231)
        }
    }

    func testAnchoringApi_DirectionalXAnchoringWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.leading, to: .trailing, of: two, constant: 312)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 312)
        }
    }
}
