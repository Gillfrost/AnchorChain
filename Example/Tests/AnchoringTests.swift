//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoringTests: XCTestCase {

    // MARK: - Default parameters

    func testRelationDefaultsToEqual() throws {
        try siblings { view, otherView in

            let defaultRelation = try view.anchoring(.left, to: .right, of: otherView)
                .superview?
                .constraints
                .onlyElement()
                .relation

            XCTAssertEqual(defaultRelation, .equal)
        }
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchoring(anchor, of: other)

            expect(anchor.layoutAttribute, of: other, toMatch: view)
        }
    }

    // MARK: - Vertical anchors

    func testAnchorAllCombinationsOfVerticalAnchors() {
        UIView.YAnchor
            .allCases
            .allCombinations
            .forEach { combination in
                let (anchor, otherAnchor) = combination
                siblings { view, otherView in

                    expect(anchor.layoutAttribute,
                           of: view.anchoring(anchor, to: otherAnchor, of: otherView),
                           toMatch: otherAnchor.layoutAttribute,
                           of: otherView)
                }
        }
    }

    // MARK: - Horizontal anchors

    func testAnchorAllCombinationsOfHorizontalAnchors() {
        UIView.XAnchor
            .allCases
            .allCombinations
            .forEach { combination in
                let (anchor, otherAnchor) = combination
                siblings { view, otherView in

                    expect(anchor.layoutAttribute,
                           of: view.anchoring(anchor, to: otherAnchor, of: otherView),
                           toMatch: otherAnchor.layoutAttribute,
                           of: otherView)
                }
        }
    }
}
