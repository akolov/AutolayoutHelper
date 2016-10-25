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
  case width = "width"
  case height = "height"
  case leading = "leading"
  case trailing = "trailing"
  case top = "top"
  case bottom = "bottom"
  case centerX = "centerX"
  case centerY = "centerY"
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

    fileprivate init(view: UIView?) {
      self.theView = view
      view?.translatesAutoresizingMaskIntoConstraints = false
    }

    fileprivate weak var theView: UIView?

    // MARK: Size

    @discardableResult
    public func constrained(
      to size: CGSize,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View must not be nil")
      let widthConstraint = theView!.widthAnchor.constraint(equalToConstant: size.width)
      let heightConstraint = theView!.heightAnchor.constraint(equalToConstant: size.height)

      widthConstraint.priority = priority
      heightConstraint.priority = priority

      return [
        .width: widthConstraint,
        .height: heightConstraint
      ].activate()
    }

    // MARK: Edges

    @discardableResult
    public func fill(
      in view: UIView,
      inset: UIEdgeInsets = .zero,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      fillHorizontally(
        in: view,
        leading: inset.left,
        trailing: inset.right,
        margins: margins,
        priority: priority
      ).forEach {
        (key, value) in constraints[key] = value
      }

      fillVertically(in: view, top: inset.top, bottom: inset.bottom, margins: margins, priority: priority).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    @discardableResult
    public func limit(
      in view: UIView,
      inset: UIEdgeInsets = .zero,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()

      limitHorizontally(
        in: view,
        leading: inset.left,
        trailing: inset.right,
        margins: margins,
        priority: priority
      ).forEach {
        (key, value) in constraints[key] = value
      }

      limitVertically(in: view, top: inset.top, bottom: inset.bottom, margins: margins, priority: priority).forEach {
        (key, value) in constraints[key] = value
      }

      return constraints
    }

    // MARK: Horizontal edges

    @discardableResult
    public func fillHorizontally(
      in view: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let leadingAnchor = margins ? view.layoutMarginsGuide.leadingAnchor : view.leadingAnchor
      let trailingAnchor = margins ? view.layoutMarginsGuide.trailingAnchor : view.trailingAnchor
      let leadingConstraint = theView!.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leading)
      let trailingConstraint = trailingAnchor.constraint(equalTo: theView!.trailingAnchor, constant: trailing)

      leadingConstraint.priority = priority
      trailingConstraint.priority = priority

      return [
        .leading: leadingConstraint,
        .trailing: trailingConstraint
      ].activate()
    }

    @discardableResult
    public func limitHorizontally(
      in view: UIView,
      leading: CGFloat = 0,
      trailing: CGFloat = 0,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let leadingAnchor = margins ? view.layoutMarginsGuide.leadingAnchor : view.leadingAnchor
      let trailingAnchor = margins ? view.layoutMarginsGuide.trailingAnchor : view.trailingAnchor
      let leadingConstraint = theView!.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: leading)
      let trailingConstraint = trailingAnchor.constraint(
        greaterThanOrEqualTo: theView!.trailingAnchor, constant: trailing
      )

      leadingConstraint.priority = priority
      trailingConstraint.priority = priority

      return [
        .leading: leadingConstraint,
        .trailing: trailingConstraint
      ].activate()
    }

    // MARK: Vertical edges

    @discardableResult
    public func fillVertically(
      in view: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let topAnchor = margins ? view.layoutMarginsGuide.topAnchor : view.topAnchor
      let bottomAnchor = margins ? view.layoutMarginsGuide.bottomAnchor : view.bottomAnchor
      let topConstraint = theView!.topAnchor.constraint(equalTo: topAnchor, constant: top)
      let bottomConstraint = bottomAnchor.constraint(equalTo: theView!.bottomAnchor, constant: bottom)

      topConstraint.priority = priority
      bottomConstraint.priority = priority

      return [
        .top: topConstraint,
        .bottom: bottomConstraint
      ].activate()
    }

    @discardableResult
    public func limitVertically(
      in view: UIView,
      top: CGFloat = 0,
      bottom: CGFloat = 0,
      margins: Bool = false,
      priority: UILayoutPriority = UILayoutPriorityRequired
    ) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      let topAnchor = margins ? view.layoutMarginsGuide.topAnchor : view.topAnchor
      let bottomAnchor = margins ? view.layoutMarginsGuide.bottomAnchor : view.bottomAnchor
      let topConstraint = theView!.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: top)
      let bottomConstraint = bottomAnchor.constraint(greaterThanOrEqualTo: theView!.bottomAnchor, constant: bottom)

      topConstraint.priority = priority
      bottomConstraint.priority = priority

      return [
        .top: topConstraint,
        .bottom: bottomConstraint
      ].activate()
    }

    // MARK: Centering

    @discardableResult
    public func center(in view: UIView, offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
      var constraints = ConstraintsDictionary()
      centerHorizontally(in: view, constant: offset.x).forEach { (key, value) in constraints[key] = value }
      centerVertically(in: view, constant: offset.y).forEach { (key, value) in constraints[key] = value }
      return constraints
    }

    @discardableResult
    public func centerHorizontally(in view: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      return [
        .centerX: theView!.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
      ].activate()
    }

    @discardableResult
    public func centerVertically(in view: UIView, constant: CGFloat = 0) -> ConstraintsDictionary {
      precondition(theView != nil, "View is nil")
      return [
        .centerY: theView!.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
      ].activate()
    }

  }

}

// Constraints to the superview

public extension UIView.Autolayout {

  // MARK: Edges

  @discardableResult
  public func fill(
    to inset: UIEdgeInsets = .zero,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fill(in: superview!, inset: inset, margins: margins, priority: priority)
  }

  @discardableResult
  public func limit(
    to inset: UIEdgeInsets = .zero,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limit(in: superview!, inset: inset, margins: margins, priority: priority)
  }

  // MARK: Horizontal edges

  @discardableResult
  public func fillHorizontally(
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fillHorizontally(in: superview!, leading: leading, trailing: trailing, margins: margins, priority: priority)
  }

  @discardableResult
  public func limitHorizontally(
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limitHorizontally(in: superview!, leading: leading, trailing: trailing, margins: margins, priority: priority)
  }

  // MARK: Vertical edges

  @discardableResult
  public func fillVertically(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return fillVertically(in: superview!, top: top, bottom: bottom, margins: margins, priority: priority)
  }

  @discardableResult
  public func limitVertically(
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    margins: Bool = false,
    priority: UILayoutPriority = UILayoutPriorityRequired
  ) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return limitVertically(in: superview!, top: top, bottom: bottom, margins: margins, priority: priority)
  }

  // MARK: Centering

  @discardableResult
  public func center(with offset: CGPoint = CGPoint.zero) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return center(in: superview!, offset: offset)
  }

  @discardableResult
  public func centerHorizontally(with constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return centerHorizontally(in: superview!, constant: constant)
  }

  @discardableResult
  public func centerVertically(with constant: CGFloat = 0) -> ConstraintsDictionary {
    let superview = theView!.superview
    precondition(superview != nil, "Superview is nil")
    return centerVertically(in: superview!, constant: constant)
  }

}
