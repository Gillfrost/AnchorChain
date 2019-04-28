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

    // MARK: - Edge anchoring

    func testAnchoringOther() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: other, toMatch: UIView().anchoring(other))
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

    func testAnchorAllCombinationsOfDirectionalHorizontalAnchors() {
        UIView.DirectionalXAnchor
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

    func testXAnchorWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in
            try siblings { one, two in

                let constraint = try one.anchoring(.left, relation, to: .right, of: two)
                    .superview?
                    .constraints
                    .onlyElement()

                XCTAssertEqual(constraint?.relation, relation)
            }
        }
    }

    func testYAnchorWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in
            try siblings { one, two in

                let constraint = try one.anchoring(.top, relation, to: .bottom, of: two)
                    .superview?
                    .constraints
                    .onlyElement()

                XCTAssertEqual(constraint?.relation, relation)
            }
        }
    }

    func testDimensionalAnchorWithRelation() throws {
        try NSLayoutConstraint.Relation.all.forEach { relation in

            let constraint = try UIView().anchoring(.height, relation, to: 123)
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint.relation, relation)
        }
    }

    // MARK: - Constants

    func testYAnchorWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.top, to: .bottom, of: two, constant: 123)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 123)
        }
    }

    func testXAnchorWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.right, to: .left, of: two, constant: 231)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 231)
        }
    }

    func testDirectionalXAnchorWithConstant() throws {
        try siblings { one, two in

            let constraint = try one.anchoring(.leading, to: .trailing, of: two, constant: 312)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.constant, 312)
        }
    }

    // MARK: - Priority

    func testDimensionalAnchoringWithPriority() throws {
        let constraint = try UIView()
            .anchoring(.width, to: 123, priority: .defaultLow)
            .constraints
            .onlyElement()

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testXAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.left, to: .right, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    func testYAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.top, to: .bottom, of: two, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testDirectionalXAnchoringWithPriority() throws {
        try siblings { one, two in

            let constraint = try one
                .anchoring(.leading, to: .trailing, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

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

        expect(.top, .centerX,
               of: view,
               toMatch: UIView().anchoring(.top, .centerX, of: view, to: .layoutMargins).layoutMarginsGuide)
    }

    // MARK: - Edge anchoring insets

    func testAnchoringViewWithInsets() {
        let view = UIView()
        let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

        expect(view, toMatch: UIView().anchoring(view, with: insets), withInsets: insets)
    }

    func testAnchoringViewToLayoutGuideWithInsets() {
        let view = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view,
               toMatch: UIView().anchoring(view, to: .safeArea, with: insets).safeAreaLayoutGuide,
               withInsets: insets)
    }
}
