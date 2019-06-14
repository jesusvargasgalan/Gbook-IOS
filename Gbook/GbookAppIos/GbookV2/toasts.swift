//
//  toasts.swift
//  GbookV2
//
//  Created by macOS12 on 04/04/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit

var showToast = toasts()

//MARK: Show Toasts

class toasts : UIViewController{

func mostrarToast(controller:UIViewController, message:String, seconds:Double){
    
    let alert = UIAlertController (title: nil, message: message, preferredStyle: .alert)
    
    alert.view.backgroundColor = UIColor.green
    alert.view.alpha = 0.6
    alert.view.layer.cornerRadius = 15
    
    controller.present(alert, animated: true)
    
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
        alert.dismiss(animated: true)
    }
    
    
}
    func mostrarToastError(controller:UIViewController, message:String, seconds:Double){
        
        let alert = UIAlertController (title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = UIColor.red
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
        
        
    }
    func mostrarToastInfo(controller:UIViewController, message:String, seconds:Double){
        
        let alert = UIAlertController (title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = UIColor.yellow
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds){
            alert.dismiss(animated: true)
        }
        
        
    }
}
