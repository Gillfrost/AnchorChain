//  Copyright (c) 2018 André Gillfrost
//  Licensed under the MIT license

import UIKit
import XCTest

extension NSLayoutConstraint.Relation: CustomStringConvertible {

    public var description: String {
        switch self {
        case .equal: return "equal"
        case .greaterThanOrEqual: return "greaterThanOrEqual"
        case .lessThanOrEqual: return "lessThanOrEqual"
        @unknown default: fatalError()
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
        @unknown default: fatalError()
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

    static let allCases = [UIView.Anchor.top, .left, .bottom, .right, .leading, .trailing, .centerX, .centerY, .width, .height]

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

    static let allCases = [UIView.YAnchor.top, .bottom, .centerY]
}

extension UIView.XAnchor {

    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .left: return .left
        case .right: return .right
        case .centerX: return .centerX
        }
    }

    static let allCases = [UIView.XAnchor.left, .right, .centerX]
}

extension UIView.DirectionalXAnchor {

    var layoutAttribute: NSLayoutConstraint.Attribute {
        switch self {
        case .leading: return .leading
        case .trailing: return .trailing
        case .centerX: return .centerX
        }
    }

    static let allCases = [UIView.DirectionalXAnchor.leading, .trailing, .centerX]
}

enum CollectionError: String, Error {

    case noElements = "No elements"
    case moreThanOneElement = "More than one element"

    var localizedDescription: String { return rawValue }
}

extension Collection {

    var allCombinations: [(Element, Element)] {

        return flatMap { element in
            map { (element, $0) }
        }
    }

    func onlyElement() throws -> Element {
        guard let first = first else {
            throw CollectionError.noElements
        }
        guard count == 1 else {
            throw CollectionError.moreThanOneElement
        }
        return first
    }
}

func siblings(file: StaticString = #file, line: UInt = #line, block: (UIView, UIView) throws -> Void) rethrows {
    let superview = UIView()
    let one = UIView()
    let two = UIView()
    [one, two].forEach(superview.addSubview)
    try block(one, two)
}

func viewAndSuperview(file: StaticString = #file, line: UInt = #line, block: (UIView, UIView) throws -> Void) rethrows {
    let view = UIView()
    let superview = UIView()
    superview.addSubview(view)
    try block(view, superview)
}
