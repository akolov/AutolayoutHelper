//
//  UIView+Extensions.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 02/06/2016.
//  Copyright (c) 2016 Alexander Kolov. All rights reserved.
//

import UIKit


public protocol AutolayoutConstraintType: RawRepresentable { }

public enum AutolayoutConstraint: String, AutolayoutConstraintType {
  case Width = "width"
  case Height = "height"
  case Leading = "leading"
  case Trailing = "trailing"
  case Top = "top"
  case Bottom = "bottom"
  case CenterX = "centerX"
  case CenterY = "centerY"
}

public extension Dictionary where Key: AutolayoutConstraintType, Value: NSLayoutConstraint {

  public func activate() -> Dictionary {
    NSLayoutConstraint.activate(Array(values))
    return self
  }

  public func deactivate() -> Dictionary {
    NSLayoutConstraint.deactivate(Array(values))
    return self
  }

}

public extension UIView {

  public var autolayout: Autolayout {
    return Autolayout(view: self)
  }

  public struct Autolayout {

    public typealias ConstraintsDictionary = [AutolayoutConstraint: NSLayoutConstraint]

    init(view: UIView?) {
      self.theView = view
      view?.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate weak var theView: UIView?

    // MARK: Size

    func constrained(to size: CGSize) -> ConstraintsDictionary {
      precondition(theView != nil, "View must not be nil")
      return [
        .Width: theView!.widthAnchor.constraint(equalToConstant: size.width),
        .Height: theView!.heightAnchor.constraint(equalToConstant: size.height)
      ].activate()
    }

    // MARK: Edges

    func fill(
      in view: UIView,
      inset: UIEdgeInsets = UIEdgeInsets.zero,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      fillHorizontally(in: view, leading: inset.left, trailing: inset.right, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      fillVertically(in: view, top: inset.top, bottom: inset.bottom, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    func limit(
      in view: UIView,
      inset: UIEdgeInsets = UIEdgeInsets.zero,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      limitHorizontally(in: view, leading: inset.left, trailing: inset.right, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      limitVertically(in: view, top: inset.top, bottom: inset.bottom, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    // MARK: Horizontal edges

    func fillHorizontally(
      in view: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let leadingAnchor = margins ? view.layoutMarginsGuide.leadingAnchor : view.leadingAnchor
      let trailingAnchor = margins ? view.layoutMarginsGuide.trailingAnchor : view.trailingAnchor
      return [
        .Leading: theView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading),
        .Trailing: trailingAnchor.constraint(equalTo: theView!.trailingAnchor, constant: trailing)
      ].activate()
    }

    func limitHorizontally(
      in view: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let leadingAnchor = margins ? view.layoutMarginsGuide.leadingAnchor : view.leadingAnchor
      let trailingAnchor = margins ? view.layoutMarginsGuide.trailingAnchor : view.trailingAnchor
      return [
        .Leading: theView!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: leading),
        .Trailing: trailingAnchor.constraint(greaterThanOrEqualTo: theView!.trailingAnchor, constant: trailing)
      ].activate()
    }

    // MARK: Vertical edges

    func fillVertically(
      in view: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let topAnchor = margins ? view.layoutMarginsGuide.topAnchor : view.topAnchor
      let bottomAnchor = margins ? view.layoutMarginsGuide.bottomAnchor : view.bottomAnchor
      return [
        .Top: theView!.topAnchor.constraint(equalTo: topAnchor, constant: top),
        .Bottom: bottomAnchor.constraint(equalTo: theView!.bottomAnchor, constant: bottom)
      ].activate()
    }

    func limitVertically(
      in view: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let topAnchor = margins ? view.layoutMarginsGuide.topAnchor : view.topAnchor
      let bottomAnchor = margins ? view.layoutMarginsGuide.bottomAnchor : view.bottomAnchor
      return [
        .Top: theView!.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: top),
        .Bottom: bottomAnchor.constraint(greaterThanOrEqualTo: theView!.bottomAnchor, constant: bottom)
      ].activate()
    }

    // MARK: Centering

    func center(in view: UIView, offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()
      centerHorizontally(in: view, constant: offset.x).forEach { (key, value) in constraints[key] = value }
      centerVertically(in: view, constant: offset.y).forEach { (key, value) in constraints[key] = value }
      return constraints
    }

    func centerHorizontally(in view: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      return [
        .CenterX: theView!.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
      ].activate()
    }

    func centerVertically(in view: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      return [
        .CenterY: theView!.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
      ].activate()
    }

  }

}

// Constraints to the superview

public extension UIView.Autolayout {

  // MARK: Edges

  func fill(to inset: UIEdgeInsets = UIEdgeInsets.zero, margins: Bool = false) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fill(in: superview!, inset: inset, margins: margins)
  }

  func limit(to inset: UIEdgeInsets = UIEdgeInsets.zero, margins: Bool = false) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limit(in: superview!, inset: inset, margins: margins)
  }

  // MARK: Horizontal edges

  func fillHorizontally(
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fillHorizontally(in: superview!, leading: leading, trailing: trailing, margins: margins)
  }

  func limitHorizontally(
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limitHorizontally(in: superview!, leading: leading, trailing: trailing, margins: margins)
  }

  // MARK: Vertical edges

  func fillVertically(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fillVertically(in: superview!, top: top, bottom: bottom, margins: margins)
  }

  func limitVertically(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limitVertically(in: superview!, top: top, bottom: bottom, margins: margins)
  }

  // MARK: Centering

  func center(with offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return center(in: superview!, offset: offset)
  }

  func centerHorizontally(with constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return centerHorizontally(in: superview!, constant: constant)
  }

  func centerVertically(with constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return centerVertically(in: superview!, constant: constant)
  }

}
