//
//  Autolayout+ConstraintSet.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public protocol ConstraintSet {

  @discardableResult
  func activate() -> Self

  @discardableResult
  func deactivate() -> Self

}

public struct AxialConstraintSet: ConstraintSet {

  @discardableResult
  public func activate() -> AxialConstraintSet {
    horizontal.isActive = true
    vertical.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> AxialConstraintSet {
    horizontal.isActive = false
    vertical.isActive = false
    return self
  }

  let horizontal: NSLayoutConstraint
  let vertical: NSLayoutConstraint

}

public struct HorizontalFillConstraintSet: ConstraintSet {

  @discardableResult
  public func activate() -> HorizontalFillConstraintSet {
    leading.isActive = true
    trailing.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> HorizontalFillConstraintSet {
    leading.isActive = false
    trailing.isActive = false
    return self
  }

  let leading: NSLayoutConstraint
  let trailing: NSLayoutConstraint
}

public struct VerticalFillConstraintSet {

  @discardableResult
  public func activate() -> VerticalFillConstraintSet {
    top.isActive = true
    bottom.isActive = true
    return self
  }

  @discardableResult
  public func deactivate() -> VerticalFillConstraintSet {
    top.isActive = false
    bottom.isActive = false
    return self
  }

  let top: NSLayoutConstraint
  let bottom: NSLayoutConstraint
}

public struct FillConstraintSet {

  @discardableResult
  public func activate() -> FillConstraintSet {
    horizontal.activate()
    vertical.activate()
    return self
  }

  @discardableResult
  public func deactivate() -> FillConstraintSet {
    horizontal.deactivate()
    vertical.deactivate()
    return self
  }

  let horizontal: HorizontalFillConstraintSet
  let vertical: VerticalFillConstraintSet

  var top: NSLayoutConstraint {
    return vertical.top
  }

  var leading: NSLayoutConstraint {
    return horizontal.leading
  }

  var bottom: NSLayoutConstraint {
    return vertical.bottom
  }

  var trailing: NSLayoutConstraint {
    return horizontal.trailing
  }

}
