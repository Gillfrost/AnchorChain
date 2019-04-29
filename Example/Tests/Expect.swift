//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit
import XCTest

func expect(_ view: UIView, toMatch other: UIView, file: StaticString = #file, line: UInt = #line) {

    expect(.top, .left, .bottom, .right,
           of: view,
           toMatch: other,
           file: file,
           line: line)
}

func expect(_ view: UIView, toMatch layoutGuide: UILayoutGuide, file: StaticString = #file, line: UInt = #line) {

    expect(.top, .left, .bottom, .right,
           of: view,
           toMatch: layoutGuide,
           file: file,
           line: line)
}

func expect(_ attribute: NSLayoutConstraint.Attribute,
            _ moreAttributes: NSLayoutConstraint.Attribute...,
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

func expect(_ attribute: NSLayoutConstraint.Attribute,
            _ moreAttributes: NSLayoutConstraint.Attribute...,
            of view: UIView,
            toMatch layoutGuide: UILayoutGuide,
            file: StaticString = #file,
            line: UInt = #line) {

    guard let other = layoutGuide.owningView else {
        XCTFail("Layout guide has no owning view")
        return
    }

    let attributes = [attribute] + moreAttributes

    let count = other.constraints.filter { $0.firstItem === view }.count
    XCTAssertEqual(count, attributes.count,
                   "Unexpected number of constraints",
                   file: file,
                   line: line)

    for attribute in attributes {
        XCTAssert(other.isAttribute(attribute, of: layoutGuide, constrainedTo: view),
                  "Attribute \(attribute) doesn't match",
            file: file,
            line: line)
    }
}

func expect(_ view: UIView,
            toMatch other: AnyObject,
            withInsets insets: UIEdgeInsets,
            file: StaticString = #file,
            line: UInt = #line) {

    expect(.top, of: view, toMatch: .top, of: other, withConstant: insets.top, file: file, line: line)
    expect(.left, of: view, toMatch: .left, of: other, withConstant: insets.left, file: file, line: line)
    expect(.bottom, of: view, toMatch: .bottom, of: other, withConstant: -insets.bottom, file: file, line: line)
    expect(.right, of: view, toMatch: .right, of: other, withConstant: -insets.right, file: file, line: line)
}

func expect(_ attribute: NSLayoutConstraint.Attribute,
            of view: UIView,
            toMatch otherAttribute: NSLayoutConstraint.Attribute,
            of other: AnyObject,
            withConstant constant: CGFloat = 0,
            file: StaticString = #file,
            line: UInt = #line) {

    guard let superview = view.superview else {
        XCTFail("View has no superview", file: file, line: line)
        return
    }

    XCTAssert(superview.isAttribute(attribute, of: view,
                                    constrainedTo: otherAttribute, of: other, withConstant: constant),
              "Attribute \(attribute) is not constrained to \(otherAttribute) with constant \(constant)",
        file: file,
        line: line)
}

func expect(_ attribute: NSLayoutConstraint.Attribute,
            of view: UIView,
            toMatch constant: CGFloat,
            file: StaticString = #file,
            line: UInt = #line) {

    XCTAssert(view.isAttribute(attribute, equalTo: constant),
              "Attribute \(attribute) not equal to \(constant)",
        file: file,
        line: line)
}

func expect(_ attribute: NSLayoutConstraint.Attribute,
            toMatch otherAttribute: NSLayoutConstraint.Attribute,
            of view: UIView,
            file: StaticString = #file,
            line: UInt = #line) {

    XCTAssert(view.isAttribute(attribute, constrainedTo: otherAttribute),
              "Attribute \(attribute) not constrained to \(otherAttribute)",
        file: file,
        line: line)
}
