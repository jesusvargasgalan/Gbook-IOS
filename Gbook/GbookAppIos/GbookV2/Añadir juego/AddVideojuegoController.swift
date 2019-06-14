//
//  AddVideojuegoController.swift
//  GbookV2
//
//  Created by macOS12 on 22/04/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import FirebaseFirestore
import DLRadioButton
import FirebaseStorage
import PUGifLoading

class AddVideojuegoController : UIViewController , UIPickerViewDelegate , UIPickerViewDataSource,UINavigationControllerDelegate{
    
    var gameSelected : String = ""
    
    //MARK: - Inicializo el PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titleVideogamesNoRepeated.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return titleVideogamesNoRepeated[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        
       textTitulo.text? = titleVideogamesNoRepeated[row]
       
        
    }
    
    
    
    @IBOutlet weak var SelectVideogame: UIPickerView!
    
    //MARK: - Booleanos que controlan que opcion ha sido marcada
     var buy = false
    var opinion = false
    
    //MARK: -Variables
    
  
    
    @IBOutlet weak var infoButton: UIImageView!
    @IBOutlet weak var textTitulo: UITextField!
    @IBOutlet weak var backButton: UIImageView!
    let loading = PUGIFLoading()

    //MARK: -Varibles entre controladores
    
    var email:String?
    var userName:String?
    var imagenVideojuego:String?
    var titleVideogames : [String] = []
    var titleVideogamesNoRepeated : [String] = []
    var pickerData : [String : Any] = [:]
    @IBOutlet weak var videogameImage: UIImageView!
    public var userDocumentId: String?
    private var userData : [String : Any] = [:]
    
    
    
    
    
    let imagePicker = UIImagePickerController()
    
    //MARK: Funciones
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.SelectVideogame.delegate = self
        self.SelectVideogame.dataSource = self
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        videogameImage.layer.borderWidth = 3
        videogameImage.layer.borderColor = UIColor.black.cgColor
        
        getUser()
        getTitles()
       
        
        //MARK: Inicio las imagenes como botones
        
        let tapBackIconFlecha = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped(tapBackIconFlecha:)))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tapBackIconFlecha)
        
        let tapInfoIcon = UITapGestureRecognizer(target: self, action: #selector(infoButtonTapped(tapInfoIcon:)))
        infoButton.isUserInteractionEnabled = true
        infoButton.addGestureRecognizer(tapInfoIcon)
        
        
        
     
        
    
        
        
        

    
    
}
    @IBAction func btnBuy(_ sender: DLRadioButton) {
        
         buy = true
        opinion = false
    }
    
    
    
    
    @IBAction func btnOpinion(_ sender: DLRadioButton) {
        opinion = true
        buy = false
    }
    
    @objc func backButtonTapped(tapBackIconFlecha: UITapGestureRecognizer)
    {
        
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewCellViewController") as! TableViewCellViewController
        vc.email = self.email
        present(vc, animated: true, completion: nil)
    }
    
    @objc func infoButtonTapped(tapInfoIcon : UITapGestureRecognizer)
    {
    showToast.mostrarToastInfo(controller: self, message: "Por favor introduce solo un título si ves que en la lista no aparece", seconds: 3)
    }
   /* func addVideogameTitle(){
        let db = Firestore.firestore()
        
        
        
            if opinion == true{
                db.collection("Videojuego").addDocument(data: ["Nombre" : textTitulo.text! , "Check" : "Opinion"])}
            else {
                db.collection("Videojuego").addDocument(data: ["Nombre" : textTitulo.text! , "Check" : "Compra"])}
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewCellViewController") as! TableViewCellViewController
        vc.email = self.emailData
        present(vc, animated: true, completion: nil)
        
        }
    */
    
        

    func getTitles(){
         let db = Firestore.firestore()
        
        db.collection("Videojuego").getDocuments()
            {
                (querySnapshot, err) in
                
                if let err = err
                {
                    print("Error getting documents: \(err)");
                }
                else
                {
                    for document in querySnapshot!.documents {
                        self.pickerData = document.data()
                        
                        self.titleVideogames.append(self.pickerData["Nombre"] as? String ?? "")
                        self.titleVideogamesNoRepeated = self.titleVideogames.removingDuplicates()
                        
                        
                       
                       
                       
                        
                      
                    }
                    DispatchQueue.main.async {
                        self.SelectVideogame.reloadAllComponents()
                    }
                   
                }
                
        }
        
    }
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if encountered.contains(value) {
                // Do not add a duplicate element.
            }
            else {
                // Add value to the set.
                encountered.insert(value)
                // ... Append the value.
                result.append(value)
            }
        }
        return result
    }
    
    
    
    @IBAction func Add(_ sender: UIButton) {
        
        
        self.saveFIRData()
        self.loading.show("Loading", gifimagename: "mario")
        
       
        
       
    
}
    @IBAction func addImageVideogame(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true , completion: nil)
    }
    func saveFIRData(){
       
        self.uploadImage(self.videogameImage.image!){url in
            
            self.saveImage(profileURL: url!){ sucess in
                if sucess != nil {
                    print("funciona")
                }
                
            }
            
        }
       
       
        
        
    }
    
    func getUser(){
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        let db = Firestore.firestore()
        print("Email:")
        print(email!)
        db.collection("Usuarios").whereField("Email", isEqualTo: email!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.userDocumentId = document.documentID
                        self.userData = document.data()
                        self.email = self.userData["Email"] as? String
                        self.userName = self.userData["Nombre de usuario"] as? String
                        self.imagenVideojuego = self.userData["profileURL"] as? String
                      
                       
    
                        }
                    myGroup.leave()
                }
        }
        
    }
}


extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}

extension AddVideojuegoController: UIImagePickerControllerDelegate{
    
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
        videogameImage?.image = image
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    
    
}

extension AddVideojuegoController {
    
    func uploadImage(_ image:UIImage , completion: @escaping (_ url: URL?) -> ()){
        let storageRef = Storage.storage().reference().child("Imagenes/Post/\(randomString(length: Int.random(in: 10 ... 35))).jpg")
        let imgData = videogameImage.image?.jpegData(compressionQuality: 0.2)
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
        let myGroup = DispatchGroup()
        myGroup.enter()
        let db = Firestore.firestore()
        
   
        
        if opinion == true{
            var idVideojuego = randomString(length: Int.random(in: 10 ... 35))
            db.collection("Videojuego").addDocument(data: ["Nombre" : textTitulo.text!,"idVideojuego" : idVideojuego, "Check" : "Opinion" , "FotoVideojuego": profileURL.absoluteString] as [String:Any])
            db.collection("Post").addDocument(data: ["Nombre" : textTitulo.text! , "Check" : "Opinion" ,"idVideojuego" : idVideojuego,"Email" : email,"ImagenAvatar" : imagenVideojuego , "NombredeUsuario" : userName,"Likes" : "0","Dislikes" : "0" , "CheckLike" : "false" , "CheckDislike" :"false ","FotoVideojuego": profileURL.absoluteString] as [String:Any])
            myGroup.leave()
        
    }else {
             var idVideojuego = randomString(length: Int.random(in: 10 ... 35))
            db.collection("Videojuego").addDocument(data: ["Nombre" : textTitulo.text! , "Check" : "Compra" , "idVideojuego" : idVideojuego ,"FotoVideojuego": profileURL.absoluteString] as [String:Any])
      db.collection("Post").addDocument(data: ["Nombre" : textTitulo.text! , "Check" : "Compra" ,"idVideojuego" : idVideojuego,"Email" : email,"ImagenAvatar" : imagenVideojuego , "NombredeUsuario" : userName,"Likes" : "0","Dislikes" : "0" , "CheckLike" : "false" , "CheckDislike" :"false ","FotoVideojuego": profileURL.absoluteString] as [String:Any])
       myGroup.leave()
    }
        myGroup.notify(queue: DispatchQueue.main, execute: {
            
            
            let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TableViewCellViewController") as! TableViewCellViewController
            vc.email = self.email
            
            self.present(vc, animated: true, completion: nil)
            
        })
        
}
    
    
}
    


    

