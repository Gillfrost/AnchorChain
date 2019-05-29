//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchorTests: XCTestCase {

    // MARK: - Default parameters

    func testTargetDefaultsToSuperview() {
        viewAndSuperview { view, superview in

            view.anchor()

            expect(view, toMatch: superview)
        }
    }

    func testRelationDefaultsToEqual() {
        siblings { view, otherView in

            let defaultRelation = view.anchor(.left, to: .right, of: otherView).relation

            XCTAssertEqual(defaultRelation, .equal)
        }
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let view = UIView()
            let other = UIView()

            view.anchor(anchor, to: other)

            expect(anchor.layoutAttribute, of: view, toMatch: other)
        }
    }

    // MARK: - Vertical anchors

    func testAnchorAllCombinationsOfVerticalAnchors() {
        UIView.YAnchor
            .allCases
            .allCombinations
            .forEach { anchor, otherAnchor in
                siblings { view, otherView in

                    view.anchor(anchor, to: otherAnchor, of: otherView)

                    expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
                }
        }
    }

    // MARK: - Horizontal anchors

    func testAnchorAllCombinationsOfHorizontalAnchors() {
        UIView.XAnchor
            .allCases
            .allCombinations
            .forEach { anchor, otherAnchor in
                siblings { view, otherView in

                    view.anchor(anchor, to: otherAnchor, of: otherView)

                    expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
                }
        }
    }

    func testAnchorAllCombinationsOfDirectionalHorizontalAnchors() {
        UIView.DirectionalXAnchor
            .allCases
            .allCombinations
            .forEach { anchor, otherAnchor in
                siblings { view, otherView in

                    view.anchor(anchor, to: otherAnchor, of: otherView)

                    expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
                }
        }
    }
}
