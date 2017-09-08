//
//  Autolayout+Limit.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public extension Autolayout {

  @discardableResult
  public func limit(
    inside guides: Autolayout.Guides = .bounds,
    insets: UIEdgeInsets = .zero,
    priority: UILayoutPriority = .required,
    identifier: String? = nil
  ) -> FillConstraintSet {
    let _identifier = identifier.map { "(\($0))" } ?? ""

    let horizontalSet = limitHorizontally(
      inside: guides,
      leading: insets.left,
      trailing: insets.right,
      priority: priority
    )

    horizontalSet.leading.identifier = "limit.leading\(_identifier)"
    horizontalSet.trailing.identifier = "limit.trailing\(_identifier)"

    let verticalSet = limitVertically(inside: guides, top: insets.top, bottom: insets.bottom, priority: priority)
    verticalSet.top.identifier = "limit.top\(_identifier)"
    verticalSet.bottom.identifier = "limit.bottom\(_identifier)"

    return FillConstraintSet(horizontal: horizontalSet, vertical: verticalSet)
  }

  @discardableResult
  public func limitHorizontally(
    inside guides: Autolayout.Guides = .bounds,
    leading: CGFloat = 0,
    trailing: CGFloat = 0,
    priority: UILayoutPriority = .required,
    identifier: String? = nil
  ) -> HorizontalFillConstraintSet {
    let leadingAnchor: NSLayoutXAxisAnchor
    let trailingAnchor: NSLayoutXAxisAnchor

    switch guides {
    case .bounds:
      precondition(view.superview != nil, "Superview must not be nil")
      leadingAnchor = view.superview!.leadingAnchor
      trailingAnchor = view.superview!.trailingAnchor
    case .boundsOf(let parentView):
      leadingAnchor = parentView.leadingAnchor
      trailingAnchor = parentView.trailingAnchor
    case .margins:
      precondition(view.superview != nil, "Superview must not be nil")
      leadingAnchor = view.superview!.layoutMarginsGuide.leadingAnchor
      trailingAnchor = view.superview!.layoutMarginsGuide.trailingAnchor
    case .marginsOf(let parentView):
      leadingAnchor = parentView.layoutMarginsGuide.leadingAnchor
      trailingAnchor = parentView.layoutMarginsGuide.trailingAnchor
    }

    let _identifier = identifier.map { "(\($0))" } ?? ""

    let leadingConstraint = view.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: leading)
    leadingConstraint.priority = priority
    leadingConstraint.identifier = "limitHorizontally.leading\(_identifier)"

    let trailingConstraint = trailingAnchor.constraint(greaterThanOrEqualTo: view.trailingAnchor, constant: trailing)
    trailingConstraint.priority = priority
    trailingConstraint.identifier = "limitHorizontally.trailing\(_identifier)"

    return HorizontalFillConstraintSet(leading: leadingConstraint, trailing: trailingConstraint).activate()
  }

  @discardableResult
  public func limitVertically(
    inside guides: Autolayout.Guides = .bounds,
    top: CGFloat = 0,
    bottom: CGFloat = 0,
    priority: UILayoutPriority = .required,
    identifier: String? = nil
  ) -> VerticalFillConstraintSet {
    let topAnchor: NSLayoutYAxisAnchor
    let bottomAnchor: NSLayoutYAxisAnchor

    switch guides {
    case .bounds:
      precondition(view.superview != nil, "Superview must not be nil")
      topAnchor = view.superview!.topAnchor
      bottomAnchor = view.superview!.bottomAnchor
    case .boundsOf(let parentView):
      topAnchor = parentView.topAnchor
      bottomAnchor = parentView.bottomAnchor
    case .margins:
      precondition(view.superview != nil, "Superview must not be nil")
      topAnchor = view.superview!.layoutMarginsGuide.topAnchor
      bottomAnchor = view.superview!.layoutMarginsGuide.bottomAnchor
    case .marginsOf(let parentView):
      topAnchor = parentView.layoutMarginsGuide.topAnchor
      bottomAnchor = parentView.layoutMarginsGuide.bottomAnchor
    }

    let _identifier = identifier.map { "(\($0))" } ?? ""

    let topConstraint = view.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: top)
    topConstraint.priority = priority
    topConstraint.identifier = "limitVertically.top\(_identifier)"

    let bottomConstraint = bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: bottom)
    bottomConstraint.priority = priority
    bottomConstraint.identifier = "limitVertically.bottom\(_identifier)"

    return VerticalFillConstraintSet(top: topConstraint, bottom: bottomConstraint).activate()
  }

}
