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

  public enum Guides {
    case bounds, margins, boundsOf(UIView), marginsOf(UIView)
  }

  weak var view: UIView!

}
