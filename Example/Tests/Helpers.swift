//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit
import XCTest

extension UIView {

    func isAttribute(_ attribute: NSLayoutAttribute, constrainedTo view: UIView) -> Bool {
        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === self
                && $0.secondAttribute == attribute
        }
    }

    func isAttribute(_ attribute: NSLayoutAttribute,
                     of view: UIView,
                     constrainedTo otherAttribute: NSLayoutAttribute,
                     of otherView: UIView) -> Bool {

        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === otherView
                && $0.secondAttribute == otherAttribute
        }
    }
}

extension NSLayoutAttribute: CustomStringConvertible {

    public var description: String {
        switch self {
        case .top: return "top"
        case .left: return "left"
        case .bottom: return "bottom"
        case .right: return "right"
        case .leading: return "leading"
        case .trailing: return "trailing"
        case .centerX: return "centerX"
        case .centerY: return "centerY"
        case .topMargin: return "topMargin"
        case .leftMargin: return "leftMargin"
        case .bottomMargin: return "bottomMargin"
        case .rightMargin: return "rightMargin"
        case .leadingMargin: return "leadingMargin"
        case .trailingMargin: return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        case .firstBaseline: return "firstBaseline"
        case .lastBaseline: return "lastBaseline"
        case .width: return "width"
        case .height: return "height"
        case .notAnAttribute: return "notAnAttribute"
        }
    }
}

extension UIView.Anchor {

    var layoutAttribute: NSLayoutAttribute {
        switch self {
        case .top: return .top
        case .left: return .left
        case .bottom: return .bottom
        case .right: return .right
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        case .centerY: return .centerY
        }
    }
}

extension UIView.XAnchor {

    var layoutAttribute: NSLayoutAttribute {
        switch self {
        case .left: return .left
        case .right: return .right
        case .centerX: return .centerX
        }
    }
}

extension UIView.DirectionalXAnchor {

    var layoutAttribute: NSLayoutAttribute {
        switch self {
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        }
    }
}

func expect(_ view: UIView, toMatch other: UIView, file: StaticString = #file, line: UInt = #line) {
    expect(.top, .left, .bottom, .right,
           of: view,
           toMatch: other,
           file: file,
           line: line)
}

func expect(_ attribute: NSLayoutAttribute,
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

func expect(_ attribute: NSLayoutAttribute,
            of view: UIView,
            toMatch otherAttribute: NSLayoutAttribute,
            of otherView: UIView,
            file: StaticString = #file,
            line: UInt = #line) {

    guard let superview = view.superview, otherView.superview == superview else {
        XCTFail("Views do not share superview")
        return
    }

    XCTAssert(superview.isAttribute(attribute, of: view, constrainedTo: otherAttribute, of: otherView),
              "Attribute \(attribute) is not constrained to \(otherAttribute)",
              file: file,
              line: line)
}
