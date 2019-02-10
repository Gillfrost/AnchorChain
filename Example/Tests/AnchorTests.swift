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
        NSLayoutRelation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.left, relation, to: .right, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testYAnchorWithRelation() {
        NSLayoutRelation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.top, relation, to: .bottom, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    func testDimensionalAnchorWithRelation() {
        NSLayoutRelation.all.forEach { relation in

            let constraint = UIView().anchor(.height, relation, to: 123)

            XCTAssertEqual(constraint.relation, relation)
        }
    }

    func testDimensionalAnchorToOtherWithRelation() {
        NSLayoutRelation.all.forEach { relation in
            siblings { one, two in

                let constraint = one.anchor(.width, relation, to: .height, of: two)

                XCTAssertEqual(constraint.relation, relation)
            }
        }
    }

    // MARK: - Priority

    func testDimensionalAnchorPriority() {
        let constraint = UIView().anchor(.width, to: 123, priority: .defaultLow)

        XCTAssertEqual(constraint.priority, .defaultLow)
    }

    func testDimensionalAnchorToOtherPriority() {
        siblings { one, two in

            let constraint = one.anchor(.width, to: .height, of: two, priority: .defaultLow)

            XCTAssertEqual(constraint.priority, .defaultLow)
        }
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

            view.anchor(insets: insets)

            expect(view, toMatch: superview, withInsets: insets)
        }
    }

    func testAnchorToLayoutGuideOfImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            view.anchor(to: .safeArea, insets: insets)

            expect(view, toMatch: superview.safeAreaLayoutGuide, withInsets: insets)
        }
    }

    func testAnchorToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: other, insets: insets)

        expect(view, toMatch: other, withInsets: insets)
    }

    func testAnchorToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        view.anchor(to: .layoutMargins, of: other, insets: insets)

        expect(view, toMatch: other.layoutMarginsGuide, withInsets: insets)
    }
}
