//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchorTests: XCTestCase {

    // MARK: - Automatic subview adding

    func testViewWithoutSuperviewIsAddedToOtherViewAutomatically() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: other)

        XCTAssertEqual(view.superview, other)
    }

    func testViewWithSuperviewIsNotAddedToOtherView() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)
        view.anchor(to: other)

        XCTAssertEqual(view.superview, superview)
    }

    // MARK: - Translates autoresizing mask into constraints

    func testTranslatesAutoresizingMaskIntoConstraintsIsSetToFalse() {
        let view = UIView()

        view.anchor(to: UIView())

        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Default parameters

    func testAnchorsDefaultToTopLeftBottomRight() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: other)

        expect(.top, .left, .bottom, .right, of: view, toMatch: other)
    }

    func testTargetDefaultsToSuperview() {
        let view = UIView()
        let superview = UIView()

        superview.addSubview(view)
        view.anchor()

        expect(view, toMatch: superview)
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

    // MARK: - Dimensional anchors

    func testAnchorWidthToConstant() {
        let constant: CGFloat = 123
        let view = UIView()

        view.anchor(.width, to: constant)

        expect(.width, of: view, toMatch: constant)
    }

    func testAnchorHeightToConstant() {
        let constant: CGFloat = 312
        let view = UIView()

        view.anchor(.height, to: constant)

        expect(.height, of: view, toMatch: constant)
    }

    func testAnchorSizeAnchorsWidthToHeight() {
        let constant: CGFloat = 231
        let view = UIView()

        view.anchor(.size, to: constant)

        expect(.width, of: view, toMatch: constant)
        expect(.width, toMatch: .height, of: view)
    }

    // MARK: - Relations

    func testEqualRelation() {
        siblings { one, two in

            let constraint = one.anchor(.left, .equal, to: .right, of: two)

            XCTAssertEqual(constraint.relation, .equal)
        }
    }

    func testGreaterThanOrEqualRelation() {
        siblings { one, two in

            let constraint = one.anchor(.top, .greaterThanOrEqual, to: .bottom, of: two)

            XCTAssertEqual(constraint.relation, .greaterThanOrEqual)
        }
    }

    func testLessThanOrEqualRelation() {
        siblings { one, two in
            
            let constraint = one.anchor(.centerX, .lessThanOrEqual, to: .right, of: two)

            XCTAssertEqual(constraint.relation, .lessThanOrEqual)
        }
    }

    // MARK: - Priority

    func testDimensionalAnchorPriority() {
        let constraint = UIView().anchor(.width, to: 123, priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testXAnchorPriority() {
        siblings { one, two in

            let constraint = one.anchor(.left, to: .right, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    func testYAnchorPriority() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testDirectionalXAnchorPriority() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .trailing, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    // MARK: - Inactive constraints

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
