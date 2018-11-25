//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorWhat

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

        let combinations = UIView.YAnchor.allCases.allCombinations

        combinations.forEach { anchor, otherAnchor in

            let view = UIView()
            let otherView = UIView()
            let superview = UIView()
            [view, otherView].forEach(superview.addSubview)

            view.anchor(anchor, to: otherAnchor, of: otherView)

            expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
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

            view.anchor(anchor, to: otherAnchor, of: otherView)

            expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
        }
    }

    func testAnchorAllCombinationsOfDirectionalHorizontalAnchors() {

        let combinations = UIView.DirectionalXAnchor.allCases.allCombinations

        combinations.forEach { anchor, otherAnchor in

            let view = UIView()
            let otherView = UIView()
            let superview = UIView()
            [view, otherView].forEach(superview.addSubview)

            view.anchor(anchor, to: otherAnchor, of: otherView)

            expect(anchor.layoutAttribute, of: view, toMatch: otherAnchor.layoutAttribute, of: otherView)
        }
    }
}
