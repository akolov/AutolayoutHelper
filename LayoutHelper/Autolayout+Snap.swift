//
//  Autolayout+Snap.swift
//  AutolayoutHelper
//
//  Created by Alexander Kolov on 14.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public extension Autolayout {

  public func snap(
    to edges: Edge,
    constant: CGFloat = 0,
    guides: Guides = .bounds,
    priority: UILayoutPriority = UILayoutPriorityRequired,
    identifier: String? = nil
  ) {
    let _identifier = identifier.map { "(\($0))" } ?? ""

    if edges.contains(.leading) {
      let leadingAnchor: NSLayoutXAxisAnchor

      switch guides {
      case .bounds:
        precondition(view.superview != nil, "Superview must not be nil")
        leadingAnchor = view.superview!.leadingAnchor
      case .boundsOf(let parentView):
        leadingAnchor = parentView.leadingAnchor
      case .margins:
        precondition(view.superview != nil, "Superview must not be nil")
        leadingAnchor = view.superview!.layoutMarginsGuide.leadingAnchor
      case .marginsOf(let parentView):
        leadingAnchor = parentView.layoutMarginsGuide.leadingAnchor
      }

      let leadingConstraint = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: constant)
      leadingConstraint.priority = priority
      leadingConstraint.identifier = "snap.leading\(_identifier)"
    }

    if edges.contains(.trailing) {
      let trailingAnchor: NSLayoutXAxisAnchor

      switch guides {
      case .bounds:
        precondition(view.superview != nil, "Superview must not be nil")
        trailingAnchor = view.superview!.trailingAnchor
      case .boundsOf(let parentView):
        trailingAnchor = parentView.trailingAnchor
      case .margins:
        precondition(view.superview != nil, "Superview must not be nil")
        trailingAnchor = view.superview!.layoutMarginsGuide.trailingAnchor
      case .marginsOf(let parentView):
        trailingAnchor = parentView.layoutMarginsGuide.trailingAnchor
      }

      let trailingConstraint = trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: constant)
      trailingConstraint.priority = priority
      trailingConstraint.identifier = "snap.trailing\(_identifier)"
    }

    if edges.contains(.top) {
      let topAnchor: NSLayoutYAxisAnchor

      switch guides {
      case .bounds:
        precondition(view.superview != nil, "Superview must not be nil")
        topAnchor = view.superview!.topAnchor
      case .boundsOf(let parentView):
        topAnchor = parentView.topAnchor
      case .margins:
        precondition(view.superview != nil, "Superview must not be nil")
        topAnchor = view.superview!.layoutMarginsGuide.topAnchor
      case .marginsOf(let parentView):
        topAnchor = parentView.layoutMarginsGuide.topAnchor
      }

      let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: constant)
      topConstraint.priority = priority
      topConstraint.identifier = "snap.top\(_identifier)"
    }

    if edges.contains(.bottom) {
      let bottomAnchor: NSLayoutYAxisAnchor

      switch guides {
      case .bounds:
        precondition(view.superview != nil, "Superview must not be nil")
        bottomAnchor = view.superview!.bottomAnchor
      case .boundsOf(let parentView):
        bottomAnchor = parentView.bottomAnchor
      case .margins:
        precondition(view.superview != nil, "Superview must not be nil")
        bottomAnchor = view.superview!.layoutMarginsGuide.bottomAnchor
      case .marginsOf(let parentView):
        bottomAnchor = parentView.layoutMarginsGuide.bottomAnchor
      }

      let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: constant)
      bottomConstraint.priority = priority
      bottomConstraint.identifier = "snap.bottom\(_identifier)"
    }
  }

}
