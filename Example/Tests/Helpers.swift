//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit
import XCTest

extension UIView {

    func isAttribute(_ attribute: NSLayoutAttribute, of layoutGuide: UILayoutGuide? = nil, constrainedTo view: UIView) -> Bool {
        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === layoutGuide ?? self
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

    func isAttribute(_ attribute: NSLayoutAttribute, equalTo constant: CGFloat) -> Bool {
        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem == nil
                && $0.secondAttribute == .notAnAttribute
        }
    }

    func isAttribute(_ attribute: NSLayoutAttribute, constrainedTo otherAttribute: NSLayoutAttribute) -> Bool {
        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem === self
                && $0.secondAttribute == otherAttribute
        }
    }
}

extension NSLayoutRelation: CustomStringConvertible {

    public var description: String {
        switch self {
        case .equal: return "equal"
        case .greaterThanOrEqual: return "greaterThanOrEqual"
        case .lessThanOrEqual: return "lessThanOrEqual"
        }
    }
}

extension NSLayoutRelation {

    static var all: [NSLayoutRelation] {
        return [.equal, .lessThanOrEqual, .greaterThanOrEqual]
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
        case .width: return .width
        case .height: return .height
        }
    }
}

extension UIView.YAnchor {

    var layoutAttribute: NSLayoutAttribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
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

extension Collection {

    var allCombinations: [(Element, Element)] {

        return flatMap { element in
            map { (element, $0) }
        }
    }
}

func siblings(file: StaticString = #file, line: UInt = #line, block: (UIView, UIView) -> Void) {
    let superview = UIView()
    let one = UIView()
    let two = UIView()
    [one, two].forEach(superview.addSubview)
    block(one, two)
}

func viewAndSuperview(file: StaticString = #file, line: UInt = #line, block: (UIView, UIView) -> Void) {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)
    block(view, superview)
}

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
            _ moreAttributes: NSLayoutAttribute...,
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

func expect(_ attribute: NSLayoutAttribute,
            of view: UIView,
            toMatch otherAttribute: NSLayoutAttribute,
            of otherView: UIView,
            file: StaticString = #file,
            line: UInt = #line) {

    guard let superview = view.superview, otherView.superview == superview else {
        XCTFail("Views do not share superview", file: file, line: line)
        return
    }

    XCTAssert(superview.isAttribute(attribute, of: view, constrainedTo: otherAttribute, of: otherView),
              "Attribute \(attribute) is not constrained to \(otherAttribute)",
              file: file,
              line: line)
}

func expect(_ attribute: NSLayoutAttribute,
            of view: UIView,
            toMatch constant: CGFloat,
            file: StaticString = #file,
            line: UInt = #line) {

    XCTAssert(view.isAttribute(attribute, equalTo: constant),
              "Attribute \(attribute) not equal to \(constant)",
              file: file,
              line: line)
}

func expect(_ attribute: NSLayoutAttribute,
            toMatch otherAttribute: NSLayoutAttribute,
            of view: UIView,
            file: StaticString = #file,
            line: UInt = #line) {

    XCTAssert(view.isAttribute(attribute, constrainedTo: otherAttribute),
              "Attribute \(attribute) not constrained to \(otherAttribute)",
              file: file,
              line: line)
}
