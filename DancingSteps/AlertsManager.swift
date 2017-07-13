//
//  AlertsManager.swift
//  DancingSteps
//
//  Created by RLRG on 13/07/2017.
//  Copyright © 2017 RLRG. All rights reserved.
//

import Foundation
import UIKit

class AlertsManager {
    
    class func alert(caller: UIViewController, message: String, title: String = "", okActionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (alert: UIAlertAction!) in
            okActionHandler()
        }
        alertController.addAction(OKAction)
        caller.present(alertController, animated: true, completion: nil)
    }
    
}
