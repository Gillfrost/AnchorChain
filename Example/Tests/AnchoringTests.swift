//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoringTests: XCTestCase {

    // MARK: - Automatic subview adding

    func testAnchoringOtherViewWithoutSuperviewAddsOtherToReceiverAutomatically() {
        let other = UIView()
        let view = UIView().anchoring(other)

        XCTAssertEqual(other.superview, view)
    }

    func testAnchoringOtherViewWithSuperviewDoesNotAddOtherToReceiver() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)

        _ = view.anchoring(other)

        XCTAssertEqual(view.superview, superview)
        XCTAssertNotEqual(other.superview, view)
    }

    // MARK: - Translates autoresizing mask into constraints

    func testTranslatesAutoresizingMaskIntoConstraintsIsSetToFalse() {
        let other = UIView()
        let view = UIView().anchoring(other)

        XCTAssertTrue(view.translatesAutoresizingMaskIntoConstraints)
        XCTAssertFalse(other.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Default parameters

    func testAnchorsDefaultToTopLeftBottomRight() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: other, toMatch: UIView().anchoring(other))
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
            let view = UIView().anchoring(anchor, of: other)

            expect(anchor.layoutAttribute, of: other, toMatch: view)
        }
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

    // MARK: - Dimensional anchors

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


    // MARK: - Priority

    func testDimensionalAnchoringPriority() {
        let constraint = UIView()
            .anchoring(.width, to: 123, priority: .defaultLow)
            .constraints
            .first

        XCTAssertEqual(constraint?.priority, .defaultLow)
    }

    func testXAnchoringPriority() {
        siblings { one, two in

            let constraint = one
                .anchoring(.left, to: .right, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    func testYAnchoringPriority() {
        siblings { one, two in

            let constraint = one
                .anchoring(.top, to: .bottom, of: two, priority: .defaultLow)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testDirectionalXAnchoringPriority() {
        siblings { one, two in

            let constraint = one
                .anchoring(.leading, to: .trailing, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    // MARK: - Layout guides

    func testAnchoringViewToLayoutGuide() {
        let view = UIView()

        expect(view, toMatch: UIView().anchoring(view, to: .safeArea).safeAreaLayoutGuide)
    }

    func testAnchoringSpecificAnchorsOfViewToLayoutGuide() {
        let view = UIView()

        expect(.top, .centerX, of: view, toMatch: UIView().anchoring(.top, .centerX, of: view, to: .layoutMargins).layoutMarginsGuide)
    }
}
