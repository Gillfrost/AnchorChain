# AnchorChain

[![Build Status](https://travis-ci.com/gillfrost/AnchorChain.svg?branch=master)](https://travis-ci.com/gillfrost/AnchorChain)
[![Version](https://img.shields.io/cocoapods/v/AnchorChain.svg?style=flat)](https://cocoapods.org/pods/AnchorChain)
[![License](https://img.shields.io/cocoapods/l/AnchorChain.svg?style=flat)](https://cocoapods.org/pods/AnchorChain)
[![Platform](https://img.shields.io/cocoapods/p/AnchorChain.svg?style=flat)](https://cocoapods.org/pods/AnchorChain)

A wrapper around the NSLayoutAnchor system, driven by the following set of design goals / trade-offs:

- Ease of expression should be proportional to frequency of use. In other words: constraining a view to its superview's edges should be trivial, and indeed it is: **view.anchor()**

- Intuitiveness at the point of use. Constraining a view's top to the bottom of another view should probably be expressed as: **view.anchor(.top, to: .bottom, of: anotherView)**, and indeed it is.
  - Trade-off: autocompletion will be of limited use, as the anchor method is heavily overloaded.

- Chainability to promote a little more declarative layout code. Constraining a view at its declaration point should be as easy as **let view = UIView().anchoring(.width, to: 100)**, and indeed it is.

- Be a little pro-active with the view hierarchy. When constraining anchors to match another view, such as this: **UIActivityIndicatorView().anchor(.centerX, .centerY, to: view)**, it could be assumed that the receiver, if it is without superview, should be added as subview to the other view, and indeed it is.
  - Trade-off: it's a pretty severe side effect, but it makes a lot of sense, since creating (activated) constraints between two views with no common ancestor constitutes a programmer error anyway.

## License

AnchorChain is available under the MIT license. See the LICENSE file for more info.
