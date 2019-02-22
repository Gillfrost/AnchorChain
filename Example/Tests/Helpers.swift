//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit
import XCTest

extension UIView {

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute, of layoutGuide: UILayoutGuide? = nil, constrainedTo view: UIView) -> Bool {
        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === layoutGuide ?? self
                && $0.secondAttribute == attribute
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute,
                     of view: UIView,
                     constrainedTo otherAttribute: NSLayoutConstraint.Attribute,
                     of other: AnyObject,
                     withConstant constant: CGFloat) -> Bool {

        return constraints.contains {
            $0.firstItem === view
                && $0.firstAttribute == attribute
                && $0.secondItem === other
                && $0.secondAttribute == otherAttribute
                && $0.constant == constant
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute, equalTo constant: CGFloat) -> Bool {
        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem == nil
                && $0.secondAttribute == .notAnAttribute
        }
    }

    func isAttribute(_ attribute: NSLayoutConstraint.Attribute, constrainedTo otherAttribute: NSLayoutConstraint.Attribute) -> Bool {
        return constraints.contains {
            $0.firstItem === self
                && $0.firstAttribute == attribute
                && $0.secondItem === self
                && $0.secondAttribute == otherAttribute
        }
    }
}

extension NSLayoutConstraint.Relation: CustomStringConvertible {

    public var description: String {
        switch self {
        case .equal: return "equal"
        case .greaterThanOrEqual: return "greaterThanOrEqual"
        case .lessThanOrEqual: return "lessThanOrEqual"
        }
    }
}

extension NSLayoutConstraint.Relation {

    static var all: [NSLayoutConstraint.Relation] {
        return [.equal, .lessThanOrEqual, .greaterThanOrEqual]
    }
}

extension NSLayoutConstraint.Attribute: CustomStringConvertible {

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

    var layoutAttribute: NSLayoutConstraint.Attribute {
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

    static var random: UIView.Anchor {
        return UIView.Anchor.allCases.randomElement()!
    }
}

extension UIView.YAnchor {

    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        case .centerY: return .centerY
        }
    }
}

extension UIView.XAnchor {

    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left: return .left
        case .right: return .right
        case .centerX: return .centerX
        }
    }
}

extension UIView.DirectionalXAnchor {

    var layoutAttribute: NSLayoutConstraint.Attribute {
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

    XCTAssert(superview.isAttribute(attribute, of: view, constrainedTo: otherAttribute, of: other, withConstant: constant),
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
