//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorChain

class AnchoredTests: XCTestCase {

    // MARK: - Automatic subview adding

    func testViewWithoutSuperviewIsAddedToOtherViewAutomatically() {
        let other = UIView()

        XCTAssertEqual(UIView().anchored(to: other).superview, other)
    }

    func testViewWithSuperviewIsNotAddedToOtherView() {
        let view = UIView()
        let superview = UIView()
        let other = UIView()

        [view, other].forEach(superview.addSubview)

        XCTAssertEqual(view.anchored(to: other).superview, superview)
    }

    // MARK: - Translates autoresizing mask into constraints

    func testTranslatesAutoresizingMaskIntoConstraintsIsSetToFalse() {
        XCTAssertFalse(UIView().anchored(to: UIView()).translatesAutoresizingMaskIntoConstraints)
    }

    // MARK: - Default parameters

    func testTargetDefaultsToSuperview() {
        viewAndSuperview { view, superview in
            expect(view.anchored(), toMatch: superview)
        }
    }

    // MARK: - Edge anchoring

    func testAnchoredToImplicitSuperview() {
        viewAndSuperview { view, superview in

            expect(.top, .left, .bottom, .right, of: view.anchored(), toMatch: superview)
        }
    }

    func testAnchoredToOther() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: UIView().anchored(to: other), toMatch: other)
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchored(anchor, to: other)

            expect(anchor.layoutAttribute, of: view, toMatch: other)
        }
    }

    // MARK: - Priority

    func testAnchoredWithPriority() throws {
        try viewAndSuperview { view, superview in

            let constraint = try view.anchored(.random, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testAnchoredToLayoutGuideWithPriority() {
        viewAndSuperview { view, superview in

            let constraint = view.anchored(.random, to: .safeArea, priority: .defaultHigh)
                .superview?
                .constraints
                .first

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    func testAnchoredToOtherWithPriority() throws {
        try siblings { one, two in
            let constraint = try one.anchored(.random, to: two, priority: .defaultLow)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultLow)
        }
    }

    func testAnchoredToLayoutGuideOfOtherWithPriority() throws {
        try siblings { one, two in

            let constraint = try one.anchored(.random, to: .layoutMargins, of: two, priority: .defaultHigh)
                .superview?
                .constraints
                .onlyElement()

            XCTAssertEqual(constraint?.priority, .defaultHigh)
        }
    }

    // MARK: - Layout guides

    func testAnchoredToLayoutGuide() {
        viewAndSuperview { view, superview in
            expect(view.anchored(to: .safeArea), toMatch: superview.safeAreaLayoutGuide)
        }
    }

    func testAnchoredToLayoutGuideOfOther() {
        let other = UIView()
        let view = UIView().anchored(to: .layoutMargins, of: other)

        expect(view, toMatch: other.layoutMarginsGuide)
    }

    // MARK: - Edge anchoring insets

    func testAnchoredToImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(with: insets), toMatch: superview, withInsets: insets)
        }
    }

    func testAnchoredToLayoutGuideOfImplicitSuperviewWithInsets() {
        viewAndSuperview { view, superview in
            let insets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)

            expect(view.anchored(to: .safeArea, with: insets), toMatch: superview.safeAreaLayoutGuide, withInsets: insets)
        }
    }

    func testAnchoredToOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: other, with: insets), toMatch: other, withInsets: insets)
    }

    func testAnchoredToLayoutGuideOfOtherWithInsets() {
        let view = UIView()
        let other = UIView()
        let insets = UIEdgeInsets(top: 11, left: 22, bottom: 33, right: 44)

        expect(view.anchored(to: .layoutMargins, of: other, with: insets), toMatch: other.layoutMarginsGuide, withInsets: insets)
    }
}
