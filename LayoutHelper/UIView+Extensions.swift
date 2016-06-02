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
    NSLayoutConstraint.activateConstraints(Array(values))
    return self
  }

  public func deactivate() -> Dictionary {
    NSLayoutConstraint.deactivateConstraints(Array(values))
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
      self.view = view
      view?.translatesAutoresizingMaskIntoConstraints = false
    }

    private weak var view: UIView?

    // MARK: Size

    func constrainedToSize(size: CGSize) -> ConstraintsDictionary {
      precondition(view != nil, "View must not be nil")
      return [
        .Width: view!.widthAnchor.constraintEqualToConstant(size.width),
        .Height: view!.heightAnchor.constraintEqualToConstant(size.height)
      ].activate()
    }

    // MARK: Edges

    func fillInView(
      toView: UIView,
      inset: UIEdgeInsets = UIEdgeInsetsZero,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      fillHorizontallyInView(toView, leading: inset.left, trailing: inset.right, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      fillVerticallyInView(toView, top: inset.top, bottom: inset.bottom, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    func limitInView(
      toView: UIView,
      inset: UIEdgeInsets = UIEdgeInsetsZero,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      limitHorizontallyInView(toView, leading: inset.left, trailing: inset.right, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      limitVerticallyInView(toView, top: inset.top, bottom: inset.bottom, margins: margins).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    // MARK: Horizontal edges

    func fillHorizontallyInView(
      toView: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      let leadingAnchor = margins ? toView.layoutMarginsGuide.leadingAnchor : toView.leadingAnchor
      let trailingAnchor = margins ? toView.layoutMarginsGuide.trailingAnchor : toView.trailingAnchor
      return [
        .Leading: view!.leadingAnchor.constraintEqualToAnchor(leadingAnchor, constant: leading),
        .Trailing: trailingAnchor.constraintEqualToAnchor(view!.trailingAnchor, constant: trailing)
      ].activate()
    }

    func limitHorizontallyInView(
      toView: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      let leadingAnchor = margins ? toView.layoutMarginsGuide.leadingAnchor : toView.leadingAnchor
      let trailingAnchor = margins ? toView.layoutMarginsGuide.trailingAnchor : toView.trailingAnchor
      return [
        .Leading: view!.leadingAnchor.constraintGreaterThanOrEqualToAnchor(leadingAnchor, constant: leading),
        .Trailing: trailingAnchor.constraintGreaterThanOrEqualToAnchor(view!.trailingAnchor, constant: trailing)
      ].activate()
    }

    // MARK: Vertical edges

    func fillVerticallyInView(
      toView: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      let topAnchor = margins ? toView.layoutMarginsGuide.topAnchor : toView.topAnchor
      let bottomAnchor = margins ? toView.layoutMarginsGuide.bottomAnchor : toView.bottomAnchor
      return [
        .Top: view!.topAnchor.constraintEqualToAnchor(topAnchor, constant: top),
        .Bottom: bottomAnchor.constraintEqualToAnchor(view!.bottomAnchor, constant: bottom)
      ].activate()
    }

    func limitVerticallyInView(
      toView: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false
    ) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      let topAnchor = margins ? toView.layoutMarginsGuide.topAnchor : toView.topAnchor
      let bottomAnchor = margins ? toView.layoutMarginsGuide.bottomAnchor : toView.bottomAnchor
      return [
        .Top: view!.topAnchor.constraintGreaterThanOrEqualToAnchor(topAnchor, constant: top),
        .Bottom: bottomAnchor.constraintGreaterThanOrEqualToAnchor(view!.bottomAnchor, constant: bottom)
      ].activate()
    }

    // MARK: Centering

    func centerInView(inView: UIView, offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()
      centerHorizontallyInView(inView, constant: offset.x).forEach { (key, value) in constraints[key] = value }
      centerVerticallyInView(inView, constant: offset.y).forEach { (key, value) in constraints[key] = value }
      return constraints
    }

    func centerHorizontallyInView(inView: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      return [
        .CenterX: view!.centerXAnchor.constraintEqualToAnchor(inView.centerXAnchor, constant: constant)
      ].activate()
    }

    func centerVerticallyInView(inView: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(view != nil, "View is nil")
      return [
        .CenterY: view!.centerYAnchor.constraintEqualToAnchor(inView.centerYAnchor, constant: constant)
      ].activate()
    }

  }

}

// Constraints to the superview

public extension UIView.Autolayout {

  // MARK: Edges

  func fill(inset: UIEdgeInsets = UIEdgeInsetsZero, margins: Bool = false) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return fillInView(superview!, inset: inset, margins: margins)
  }

  func limit(inset: UIEdgeInsets = UIEdgeInsetsZero, margins: Bool = false) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return limitInView(superview!, inset: inset, margins: margins)
  }

  // MARK: Horizontal edges

  func fillHorizontally(
    leading leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return fillHorizontallyInView(superview!, leading: leading, trailing: trailing, margins: margins)
  }

  func limitHorizontally(
    leading leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return limitHorizontallyInView(superview!, leading: leading, trailing: trailing, margins: margins)
  }

  // MARK: Vertical edges

  func fillVertically(
    top top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return fillVerticallyInView(superview!, top: top, bottom: bottom, margins: margins)
  }

  func limitVertically(
    top top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false
  ) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return limitVerticallyInView(superview!, top: top, bottom: bottom, margins: margins)
  }

  // MARK: Centering

  func center(offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return centerInView(superview!, offset: offset)
  }

  func centerHorizontally(constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return centerHorizontallyInView(superview!, constant: constant)
  }

  func centerVertically(constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = view!.superview
    precondition(superview != nil, "Superview is nil")
    return centerVerticallyInView(superview!, constant: constant)
  }

}
