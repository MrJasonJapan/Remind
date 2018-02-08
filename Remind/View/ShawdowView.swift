//
//  ShawdowView.swift
//  Remind
//
//  Created by SpaGettys on 2018/02/07.
//  Copyright © 2018 spagettys. All rights reserved.
//

import UIKit

class ShawdowView: UIView {

    override func awakeFromNib() {
        layer.shadowPath = CGPath(rect: layer.bounds, transform: nil)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.cornerRadius = 5
    }

}
