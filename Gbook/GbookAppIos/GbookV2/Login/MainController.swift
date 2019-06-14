//
//  ViewController.swift
//  Gbook
//
//  Created by macOS12 on 27/03/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import FirebaseUI
import 	IGDBWrapper
import PUGifLoading

class MainController: UIViewController {
    
    //MARK : variables
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    let loading = PUGIFLoading.init()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        assignbackground()
        borderColor()
        
        let currentUser = Auth.auth().currentUser
        
      
        
  
    }
     //MARK: - Functions
    @IBAction func btnLogin(_ sender: UIButton) {
         self.loading.show("Cargando", gifimagename: "login")
        Auth.auth().signIn(withEmail: textEmail.text!,password: textPassword.text!)
        { (user, error) in
            if error == nil{
             
                
               
                let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TableViewCellViewController") as! TableViewCellViewController
                vc.email = self.textEmail.text!
                self.loading.hide()
                self.present(vc, animated: true, completion: nil)
                
                
               
            }
            else{
                let alertController = UIAlertController(title: "Error", message: "El usuario o la contraseña introducida no es correcta", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }

    
    
    
    @IBAction func btnRegister(_ sender: UIButton) {
       /* let storyboard = UIStoryboard(name: "Registro", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "registroController") as UIViewController
        present(vc, animated: true, completion: nil)*/
        let storyboard = UIStoryboard(name: "Registro", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "registroController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    func assignbackground(){
        let background = UIImage(named: "pattern-3.png")
        
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func borderColor(){
        //MARK: Estilo bordes
        let myColor = UIColor.black
        textEmail.layer.borderColor = myColor.cgColor
        textPassword.layer.borderColor = myColor.cgColor
        textEmail.layer.backgroundColor = UIColor.white.cgColor
        textPassword.layer.backgroundColor = UIColor.white.cgColor
        
        textEmail.layer.borderWidth = 1.5
        textPassword.layer.borderWidth = 1.5
        textEmail.layer.cornerRadius = 12
        textPassword.layer.cornerRadius = 12
        
        //MARK: Estilo botones
        
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        loginButton.layer.shadowRadius = 5
        loginButton.layer.shadowOpacity = 1.0
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        registerButton.layer.shadowRadius = 5
        registerButton.layer.shadowOpacity = 1.0
        
        loginButton.layer.cornerRadius = 12
        registerButton.layer.cornerRadius = 12
    }
    
}
    
    



