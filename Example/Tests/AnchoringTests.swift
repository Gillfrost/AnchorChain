//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoringTests: XCTestCase {

    // MARK: - Automatic subview adding

    func testViewWithoutSuperviewIsAddedToOtherViewAutomatically() {
        let view = UIView()
        let other = UIView().anchoring(to: view)

        XCTAssertEqual(view.superview, other)
    }

    func testViewWithSuperviewIsNotAddedToOtherView() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)

        _ = other.anchoring(to: view)

        XCTAssertEqual(view.superview, superview)
    }

    // MARK: - Translates autoresizing mask into constraints

    func testTranslatesAutoresizingMaskIntoConstraintsIsSetToFalse() {
        let view = UIView()
        let other = UIView().anchoring(to: view)

        XCTAssertTrue(other.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Default parameters

    func testAnchorsDefaultToTopLeftBottomRight() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: other, toMatch: UIView().anchoring(to: other))
    }

    func testRelationDefaultsToEqual() {
        siblings { view, otherView in

            let defaultRelation = view.anchoring(.left, to: .right, of: otherView)
                .superview?
                .constraints
                .first?
                .relation

            XCTAssertEqual(defaultRelation, .equal)
        }
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchoring(anchor, to: other)

            expect(anchor.layoutAttribute, of: other, toMatch: view)
        }
    }

    // MARK: - Inner anchors

    func testAnchoringWidthToConstant() {
        let constant: CGFloat = 123

        expect(.width, of: UIView().anchoring(.width, to: constant), toMatch: constant)
    }

    func testAnchoringHeightToConstant() {
        let constant: CGFloat = 312

        expect(.height, of: UIView().anchoring(.height, to: constant), toMatch: constant)
    }

    func testAnchoringSizeAnchorsWidthToHeight() {
        let constant: CGFloat = 231
        let view = UIView().anchoring(.size, to: constant)

        expect(.width, of: view, toMatch: constant)
        expect(.width, toMatch: .height, of: view)
    }

    // MARK: - Vertical anchors

    func testAnchorAllCombinationsOfVerticalAnchors() {
        UIView.YAnchor
            .allCases
            .allCombinations
            .forEach { anchor, otherAnchor in
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
            .forEach { anchor, otherAnchor in
                siblings { view, otherView in

                    expect(anchor.layoutAttribute,
                           of: view.anchoring(anchor, to: otherAnchor, of: otherView),
                           toMatch: otherAnchor.layoutAttribute,
                           of: otherView)
                }
        }
    }

    func testAnchorAllCombinationsOfDirectionalHorizontalAnchors() {
        UIView.DirectionalXAnchor
            .allCases
            .allCombinations
            .forEach { anchor, otherAnchor in
                siblings { view, otherView in

                    expect(anchor.layoutAttribute,
                           of: view.anchoring(anchor, to: otherAnchor, of: otherView),
                           toMatch: otherAnchor.layoutAttribute,
                           of: otherView)
                }
        }
    }

    // MARK: - Relations

    func testEqualRelation() {
        siblings { one, two in

            let constraint = one.anchoring(.left, .equal, to: .right, of: two)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.relation, .equal)
        }
    }

    func testGreaterThanOrEqualRelation() {
        siblings { one, two in

            let constraint = one.anchoring(.top, .greaterThanOrEqual, to: .bottom, of: two)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.relation, .greaterThanOrEqual)
        }
    }

    func testLessThanOrEqualRelation() {
        siblings { one, two in

            let constraint = one.anchoring(.centerX, .lessThanOrEqual, to: .right, of: two)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.relation, .lessThanOrEqual)
        }
    }
}
