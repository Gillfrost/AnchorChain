//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import XCTest
import AnchorWhat

class Tests: XCTestCase {

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

    // MARK: - Different directional anchors

    func testAnchorLeadingToTrailingOfOtherView() {
        let view = UIView()
        let other = UIView()
        let superview = UIView()
        [view, other].forEach(superview.addSubview)

        view.anchor(.leading, to: .trailing, of: other)

        expect(.leading, of: view, toMatch: .trailing, of: other)
    }
}
