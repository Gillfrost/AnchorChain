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

    // MARK: - Constraints

    func testAnchor() {
        let view = UIView()
        let superview = UIView()

        superview.addSubview(view)
        view.anchor()

        expect(view, toMatch: superview)
    }

    func testAnchorToOther() {
        let view = UIView()
        let other = UIView()
        view.anchor(to: other)

        XCTAssertEqual(other.constraints.count, 4)

        expect(view, toMatch: other)
    }

    // MARK: - Helpers

    private func expect(_ view: UIView, toMatch other: UIView, file: StaticString = #file, line: UInt = #line) {
        expect(.top, .leading, .bottom, .trailing, of: view, toMatch: other)
    }

    private func expect(_ attribute: NSLayoutAttribute,
                        _ moreAttributes: NSLayoutAttribute...,
                        of view: UIView,
                        toMatch other: UIView,
                        file: StaticString = #file,
                        line: UInt = #line) {

        for attribute in [attribute] + moreAttributes {
            XCTAssert(other.isAttribute(attribute, constrainedTo: view),
                      "Attribute \(attribute) doesn't match",
                      file: file,
                      line: line)
        }
    }
}
