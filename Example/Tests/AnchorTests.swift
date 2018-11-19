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
        UIView.Anchor.allCases.forEach { testAnchor($0) }
    }

    // MARK: - Helpers

    private func testAnchor(_ anchor: UIView.Anchor, file: StaticString = #file, line: UInt = #line) {
        let view = UIView()
        let other = UIView()

        view.anchor(anchor, to: other)

        expect(anchor.layoutAttribute, of: view, toMatch: other, file: file, line: line)
    }

    private func expect(_ view: UIView, toMatch other: UIView, file: StaticString = #file, line: UInt = #line) {
        expect(.top, .left, .bottom, .right,
               of: view,
               toMatch: other,
               file: file,
               line: line)
    }

    private func expect(_ attribute: NSLayoutAttribute,
                        _ moreAttributes: NSLayoutAttribute...,
                        of view: UIView,
                        toMatch other: UIView,
                        file: StaticString = #file,
                        line: UInt = #line) {

        let attributes = [attribute] + moreAttributes

        XCTAssertEqual(other.constraints.count, attributes.count,
                       "Unexpected number of constraints",
                       file: file,
                       line: line)

        for attribute in attributes {
            XCTAssert(other.isAttribute(attribute, constrainedTo: view),
                      "Attribute \(attribute) doesn't match",
                      file: file,
                      line: line)
        }
    }
}
