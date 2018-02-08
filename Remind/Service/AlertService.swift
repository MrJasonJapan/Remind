//
//  AlertService.swift
//  Remind
//
//  Created by SpaGettys on 2018/02/08.
//  Copyright © 2018 spagettys. All rights reserved.
//

import UIKit

class AlertService {
    
    private init() {}
    
    static func actionSheet(in vc: UIViewController, title: String, completion: @escaping () ->
        Void) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: title, style: .default) {
            (_) in
            completion()
        }
        alert.addAction(action)
        vc.present(alert, animated: true)
    }
}
