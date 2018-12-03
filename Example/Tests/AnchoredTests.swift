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

    func testAnchorsDefaultToTopLeftBottomRight() {
        let other = UIView()

        expect(.top, .left, .bottom, .right, of: UIView().anchored(to: other), toMatch: other)
    }

    func testTargetDefaultsToSuperview() {
        let view = UIView()
        let superview = UIView()

        superview.addSubview(view)

        expect(view.anchored(), toMatch: superview)
    }

    // MARK: - Separate anchors

    func testSeparateAnchors() {
        UIView.Anchor.allCases.forEach { anchor in
            let other = UIView()
            let view = UIView().anchored(anchor, to: other)

            expect(anchor.layoutAttribute, of: view, toMatch: other)
        }
    }

    // MARK: - Vertical anchors

    func testAnchorAllCombinationsOfVerticalAnchors() {

        let combinations = UIView.YAnchor.allCases.allCombinations

        combinations.forEach { anchor, otherAnchor in

            let view = UIView()
            let otherView = UIView()
            let superview = UIView()
            [view, otherView].forEach(superview.addSubview)

            expect(anchor.layoutAttribute,
                   of: view.anchored(anchor, to: otherAnchor, of: otherView),
                   toMatch: otherAnchor.layoutAttribute,
                   of: otherView)
        }
    }

    // MARK: - Horizontal anchors

    func testAnchorAllCombinationsOfHorizontalAnchors() {

        let combinations = UIView.XAnchor.allCases.allCombinations

        combinations.forEach { anchor, otherAnchor in

            let view = UIView()
            let otherView = UIView()
            let superview = UIView()
            [view, otherView].forEach(superview.addSubview)

            expect(anchor.layoutAttribute,
                   of: view.anchored(anchor, to: otherAnchor, of: otherView),
                   toMatch: otherAnchor.layoutAttribute,
                   of: otherView)
        }
    }

    func testAnchorAllCombinationsOfDirectionalHorizontalAnchors() {

        let combinations = UIView.DirectionalXAnchor.allCases.allCombinations

        combinations.forEach { anchor, otherAnchor in

            let view = UIView()
            let otherView = UIView()
            let superview = UIView()
            [view, otherView].forEach(superview.addSubview)

            expect(anchor.layoutAttribute,
                   of: view.anchored(anchor, to: otherAnchor, of: otherView),
                   toMatch: otherAnchor.layoutAttribute,
                   of: otherView)
        }
    }

    // MARK: - Inner anchors

    func testAnchorWidthToConstant() {
        let constant: CGFloat = 123

        expect(.width, of: UIView().anchored(.width, to: constant), toMatch: constant)
    }

    func testAnchorHeightToConstant() {
        let constant: CGFloat = 312

        expect(.height, of: UIView().anchored(.height, to: constant), toMatch: constant)
    }

    func testAnchorSizeAnchorsWidthToHeight() {
        let constant: CGFloat = 231
        let view = UIView().anchored(.size, to: constant)

        expect(.width, of: view, toMatch: constant)
        expect(.width, toMatch: .height, of: view)
    }
}

