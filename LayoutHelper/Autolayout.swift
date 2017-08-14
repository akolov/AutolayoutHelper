//
//  Autolayout.swift
//  LayoutHelper
//
//  Created by Alexander Kolov on 8.8.2017.
//  Copyright © 2017 Alexander Kolov. All rights reserved.
//

import UIKit

public struct Autolayout {

  internal init(view: UIView) {
    self.view = view
    view.translatesAutoresizingMaskIntoConstraints = false
  }

  public struct Edge: OptionSet {

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }

    public var rawValue: Int

    public static let leading = Edge(rawValue: 1 << 0)
    public static let trailing = Edge(rawValue: 1 << 1)
    public static let top = Edge(rawValue: 1 << 2)
    public static let bottom = Edge(rawValue: 1 << 3)

    static let all: [Edge] = [.leading, .trailing, .top, .bottom]

  }

  public enum SuperviewGuides {
    case bounds, margins
  }

  public enum Guides {

    case bounds, margins, boundsOf(UIView), marginsOf(UIView)

    init(superviewGuides: SuperviewGuides) {
      switch superviewGuides {
      case .bounds:
        self = .bounds
      case .margins:
        self = .margins
      }
    }

  }

  weak var view: UIView!

}
