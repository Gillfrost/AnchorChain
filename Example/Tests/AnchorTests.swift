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

    // MARK: - Edge anchoring

    func testAnchorToImplicitSuperview() {
        viewAndSuperview { view, superview in

            view.anchor()

            expect(.top, .left, .bottom, .right, of: view, toMatch: superview)
        }
    }

    func testAnchorToOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: other)

        expect(.top, .left, .bottom, .right, of: view, toMatch: other)
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

    func testAnchorDifferentDimensionalAnchors() {
        siblings { one, two in

            one.anchor(.width, to: .height, of: two)

            expect(.width, of: one, toMatch: .height, of: two)
        }
    }

    // MARK: - Relations

    func testXAnchorWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.left, relation, to: .right, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testYAnchorWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.top, relation, to: .bottom, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testDimensionalAnchorWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in

            let constraint = UIView().anchor(.height, relation, to: 123)

            XCTAssertEqual(constraint.relation, relation)
        }
    }

    func testDimensionalAnchorToOtherWithRelation() {
        NSLayoutConstraint.Relation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.width, relation, to: .height, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    // MARK: - Multipliers

    func testDimensionalAnchorToOtherWithMultiplier() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, multiplier: 1.5)

            XCTAssertEqual(constraint.multiplier, 1.5)
        }
    }

    // MARK: - Constants

    func testYAnchorWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, constant: 123)

            XCTAssertEqual(constraint.constant, 123)
        }
    }

    func testXAnchorWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.right, to: .left, of: two, constant: 231)

            XCTAssertEqual(constraint.constant, 231)
        }
    }

    func testDirectionalXAnchorWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .trailing, of: two, constant: 312)

            XCTAssertEqual(constraint.constant, 312)
        }
    }

    func testDimensionalAnchorToOtherWithConstant() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, constant: 123)

            XCTAssertEqual(constraint.constant, 123)
        }
    }

    // MARK: - Priority

    func testAnchorWithPriority() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.random, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testAnchorToLayoutGuideWithPriority() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.random, to: .safeArea, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    func testAnchorToOtherWithPriority() {
        let constraint = UIView().anchor(.random, to: UIView(), priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testAnchorToLayoutGuideOfOtherWithPriority() {
        let constraint = UIView().anchor(.random, to: .layoutMargins, of: UIView(), priority: .defaultHigh)

        XCTAssertEqual(constraint.priority, .defaultHigh)
    }

    func testDimensionalAnchorWithPriority() {
        let constraint = UIView().anchor(.width, to: 123, priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testDimensionalAnchorToOtherWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testXAnchorWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.left, to: .right, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    func testYAnchorWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.top, to: .bottom, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
    }

    func testDirectionalXAnchorWithPriority() {
        siblings { one, two in

            let constraint = one.anchor(.leading, to: .trailing, of: two, priority: .defaultHigh)

            XCTAssertEqual(constraint.priority, .defaultHigh)
        }
    }

    // MARK: - Layout guides

    func testAnchorToSafeArea() {
        viewAndSuperview { view, superview in

            view.anchor(to: .safeArea)

            expect(view, toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchorToLayoutMargins() {
        viewAndSuperview { view, superview in

            view.anchor(to: .layoutMargins)

            expect(view, toMatch: superview.layoutMarginsGuide)
        }
    }

    func testAnchorToReadableContentGuide() {
        viewAndSuperview { view, superview in

            view.anchor(to: .readableContent)

            expect(view, toMatch: superview.readableContentGuide)
        }
    }

    func testAnchorToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(to: .safeArea, of: other)

        expect(view, toMatch: other.safeAreaLayoutGuide)
    }

    func testAnchorOneAnchorToLayoutGuide() {
        viewAndSuperview { view, superview in

            view.anchor(.top, to: .layoutMargins)

            expect(.top, of: view, toMatch: superview.layoutMarginsGuide)
        }
    }

    func testAnchorOneAnchorToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(.left, to: .readableContent, of: other)

        expect(.left, of: view, toMatch: other.readableContentGuide)
    }

    func testAnchorMultipleAnchorsToLayoutGuide() {
        viewAndSuperview { view, superview in

            view.anchor(.leading, .bottom, to: .safeArea)

            expect(.leading, .bottom, of: view, toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchorMultipleAnchorsToLayoutGuideOfOther() {
        let view = UIView()
        let other = UIView()

        view.anchor(.trailing, .centerY, to: .layoutMargins, of: other)

        expect(.trailing, .centerY, of: view, toMatch: other.layoutMarginsGuide)
    }

    // MARK: - Edge anchoring insets

    func testAnchorToImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            view.anchor(with: insets)

            expect(view, toMatch: superview, withInsets: insets)
        }
    }

    func testAnchorToLayoutGuideOfImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            view.anchor(to: .safeArea, with: insets)

            expect(view, toMatch: superview.safeAreaLayoutGuide, withInsets: insets)
        }
    }

    func testAnchorToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: other, with: insets)

        expect(view, toMatch: other, withInsets: insets)
    }

    func testAnchorToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: .layoutMargins, of: other, with: insets)

        expect(view, toMatch: other.layoutMarginsGuide, withInsets: insets)
    }

    // MARK: - Single anchor inset

    func testAnchorTopWithInset() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.top, inset: 1)

            XCTAssertEqual(constraint.constant, 1)
        }
    }

    func testAnchorLeftToLayoutGuideWithInset() {
        viewAndSuperview { view, _ in

            let constraint = view.anchor(.left, to: .safeArea, inset: 2)

            XCTAssertEqual(constraint.constant, 2)
        }
    }

    func testAnchorBottomToOtherWithInset() {
        let constraint = UIView().anchor(.bottom, to: UIView(), inset: 3)

        XCTAssertEqual(constraint.constant, -3)
    }

    func testAnchorRightToLayoutGuideOfOtherWithInset() {
        let constraint = UIView().anchor(.right, to: .layoutMargins, of: UIView(), inset: 4)

        XCTAssertEqual(constraint.constant, -4)
    }
}
