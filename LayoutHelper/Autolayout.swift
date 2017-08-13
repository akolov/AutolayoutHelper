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
