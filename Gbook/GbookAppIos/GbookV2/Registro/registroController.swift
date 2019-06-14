//
//  RegistroController.swift
//  Gbook
//
//  Created by macOS12 on 27/03/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseUI
import FirebaseStorage
import FirebaseAuth




class RegistroController:UIViewController{

    // MARK:Variables
    
    @IBOutlet weak var botonAtras: UIImageView!
    @IBOutlet weak var cambiarAvatar: UIButton!
    @IBOutlet weak var textNombre: UITextField!
    @IBOutlet weak var textApellidos: UITextField!
    @IBOutlet weak var textEmail: UITextField!
    @IBOutlet weak var textUsuario: UITextField!
    @IBOutlet weak var textPassword: UITextField!
    @IBOutlet weak var textRepeatPassword: UITextField!
    @IBOutlet weak var avatarImage: UIImageView!
    var counterFoto = 1
    let imagePicker = UIImagePickerController()
    
   
    
    //MARK: Storage Firebase
    
    let storage = Storage.storage()
    
    
    
  
    
    
    //MARK: Variables pasadas a otro controlador
    var email:String?
    public var userDocumentId: String?
    public var emailData: String?
    public var nameData: String?
    public var secondNameData: String?
    public var userNameData: String?
    private var userData : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignbackground()
        
       
        
        
        
        
        
        // Initialize BackIconFlecha imageview as a button
        let tapBackIconFlecha = UITapGestureRecognizer(target: self, action: #selector(botonAtrasTapped(tapBackIconFlecha:)))
        botonAtras.isUserInteractionEnabled = true
        botonAtras.addGestureRecognizer(tapBackIconFlecha)
        
        imagePicker.delegate = self
      
        
        //MARK: - Redondea el borde de la foto
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.borderColor = UIColor.black.cgColor
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width/2.05
        avatarImage.clipsToBounds = true
        
}
    
    
    // MARK: Funciones
    func comprobarPassword(){
            let db = Firestore.firestore()
       
        if(textNombre.text?.isEmpty == true || textApellidos.text?.isEmpty == true || textUsuario.text?.isEmpty == true){
            
             showToast.mostrarToastError(controller: self, message: "Falta algún campo por introducir", seconds: 3)
            
 
            
        } else {
            
        }
        
        if((textPassword.text?.elementsEqual(textRepeatPassword.text!)) == false){
            
            showToast.mostrarToastError(controller: self, message: "Las contraseñas no coinciden", seconds: 3)
            
    }
    }
    
    
    
   
    
    
    @IBAction func registrarse(_ sender: UIButton) {
        comprobarPassword()
        guard let email = textEmail.text , let password = textPassword.text , !email.isEmpty , !password.isEmpty else { return }
        Auth.auth().createUser(withEmail: textEmail.text!, password: textPassword.text!) { (user, error) in
            if error == nil{
                self.saveFIRData()
                showToast.mostrarToast(controller: self, message: "Te has registrado correctamente", seconds: 4)
              
            }else{
                showToast.mostrarToastError(controller: self, message: "El email ya existe o bien tiene un mal formato debería ser *****@****", seconds: 2)
            }
        
      
       
       
        
        
        
        
    }
        }
    

    @objc func botonAtrasTapped(tapBackIconFlecha: UITapGestureRecognizer)
    {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cambiarFoto(_ sender: UIButton) {
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true , completion: nil)
    }

    func assignbackground(){
        let background = UIImage(named: "pattern-4.png")
        
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func saveFIRData(){
        
        self.uploadImage(self.avatarImage.image!){url in
            
            self.saveImage(profileURL: url!){ sucess in
                if sucess != nil {
                    print("funciona")
                }
            }
            
        }
        
        
    }
    
    
}


extension RegistroController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func setupImagePicker(){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker , animated: true , completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        avatarImage?.image = image
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
}

extension RegistroController {
    
    func uploadImage(_ image:UIImage , completion: @escaping (_ url: URL?) -> ()){
        let storageRef = Storage.storage().reference().child("Imagenes/\(textEmail.text!)/myimage.jpg")
        let imgData = avatarImage.image?.jpegData(compressionQuality: 0.2)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(imgData!, metadata: metaData)
        { (metadata,error) in
            if error == nil{
                print("success")
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url!)
                })
                
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileURL:URL, completion: @escaping ((_ url: URL?) -> ())){
        let db = Firestore.firestore()
        let dict = ["Nombre" : textNombre.text!,"Apellidos" : textApellidos.text!,"Email" : textEmail.text!,"Nombre de usuario" : textUsuario.text! , "profileURL": profileURL.absoluteString] as! [String:Any];

        
       db.collection("Usuarios").document().setData(dict)
        
    }
    

}


extension String {
    var isValidEmail: Bool {
        let regularExpressionForEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let testEmail = NSPredicate(format:"SELF MATCHES %@", regularExpressionForEmail)
        return testEmail.evaluate(with: self)
    }
} 


