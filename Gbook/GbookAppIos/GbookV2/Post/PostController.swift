//
//  PostController.swift
//  GbookV2
//
//  Created by macOS12 on 31/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import Foundation



import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import Kingfisher


class PostController: UIViewController {
    
    @IBOutlet weak var videogameImage: UIImageView!
    @IBOutlet weak var titleVideogame: UILabel!
    @IBOutlet weak var likes: UILabel!
    @IBOutlet weak var dislikes: UILabel!
    @IBOutlet weak var backButton: UIImageView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var dislikeImage: UIImageView!
    @IBOutlet weak var commentUser: UITextField!
    
    
    
    @IBOutlet weak var tableViewPost: UITableView!
    
    
    
    //MARK:- Variables a pasar
    var email:String?
    var videogameTitle:String?
    var checkVideogame:String?
    var userName:String?
    var userName2:String?
    var urlFoto : String?
    var numberLikes : String?
    var numberDislikes : String?
    var imagenAvatar : String?
    var imagenAvatar2 : String?
    var pulsado = false
    var pulsado2 = false
    
    public var userDocumentId: String?
    public var postDocumentId : String?
    public var nameData: String?
    public var titleData: String?
    public var likeData: String?
    public var dislikeData: String?
    public var commentData : String?
    public var videogameImageData: UIImageView?
    public var imagen : String?
    
    public var image = UIImage()

    
    var arrayData = [PostModel]()
    private var userData : [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        getUser()
        getComments()
        getPost()
        
        
    
       
       
        let tapBackIconFlecha = UITapGestureRecognizer(target: self, action: #selector(backButtonTapped(tapBackIconFlecha:)))
        backButton.isUserInteractionEnabled = true
        backButton.addGestureRecognizer(tapBackIconFlecha)
        
      
        
       if(pulsado == false && pulsado2 == false ){
        let buttonLike = UITapGestureRecognizer(target: self, action: #selector(likeButtonTapped(tapLike:)))
        likeImage.isUserInteractionEnabled = true
        likeImage.addGestureRecognizer(buttonLike)
       }
        
        if(pulsado == false && pulsado2 == false){
        let buttonDislike = UITapGestureRecognizer(target: self, action: #selector(dislikeButtonTapped(tapDislike:)))
        dislikeImage.isUserInteractionEnabled = true
        dislikeImage.addGestureRecognizer(buttonDislike)
        }

    }
   
    //MARK : Functions
    

    
    func getPost(){
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        
        let db = Firestore.firestore()
        
        db.collection("Post").whereField("FotoVideojuego", isEqualTo: urlFoto!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.postDocumentId = document.documentID
                        self.userData = document.data()
                      //  self.checkVideogame = self.userData["Check"] as? String
                        self.videogameTitle = self.userData["Nombre"] as? String
                        self.videogameImageData = self.userData["FotoVideojuego"] as? UIImageView
                        self.numberLikes = self.userData["Likes"] as? String
                        self.numberDislikes = self.userData["Dislikes"] as? String
                        self.imagenAvatar = self.userData["ImagenAvatar"] as? String
                        self.nameData = self.userName
                        
                        
                       // self.selection.text = self.checkVideogame
                       self.titleVideogame.text = self.videogameTitle
                       self.likes.text = self.numberLikes
                        self.dislikes.text = self.numberDislikes
                        
                        
                        let url = URL(string : ((self.userData["FotoVideojuego"])! as! String))
                        if let url = url as? URL{
                            KingfisherManager.shared.retrieveImage(with: url as! Resource , options: nil, progressBlock: nil){ (image, error , cache , imageURL) in
                                
                                self.videogameImage.image = image
                                self.videogameImage.kf.indicatorType = .activity
                                
                                
                            }
                        }
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
                        self.userName2 = self.userData["Nombre de usuario"] as? String
                        self.imagenAvatar2 = self.userData["profileURL"] as? String
                        
                      
                        
                    }
                     myGroup.leave()
                }
        }
        
    }

    
   func getComments(){
    self.arrayData.removeAll()
    let myGroup = DispatchGroup()
    myGroup.enter()
    let db = Firestore.firestore()
    print("Email:")
    print(email!)

    
    db.collection("Comentario").whereField("Videojuego", isEqualTo: urlFoto!)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    self.userDocumentId = document.documentID
                    self.userData = document.data()
                    self.commentData = self.userData["Comentario"] as? String
                    self.imagenAvatar = self.userData["ImagenAvatar"] as? String
                    self.userName = self.userData["NombreUsuario"] as? String
    
                    self.arrayData.append(PostModel(userName: self.userName! ,avatarImage: self.imagenAvatar!, comment : self.commentData!))
                    self.tableViewPost.reloadData()
    
    
    }
    myGroup.leave()
    }
           
    }
    }
    
    func addComment(){
        let myGroup = DispatchGroup()
        myGroup.enter()
        let db = Firestore.firestore()
        
        
        
        db.collection("Comentario").addDocument(data: ["Comentario" : commentUser.text! , "Videojuego" : urlFoto! ,"Email" : email!, "ImagenAvatar" : imagenAvatar2! , "NombreUsuario" : userName2!])
        myGroup.leave()
        
        myGroup.notify(queue: DispatchQueue.main, execute: {
            
            self.getComments()
        })
        
    }
    @IBAction func addComent(_ sender: UIButton) {
        addComment()
    }
    @objc func backButtonTapped(tapBackIconFlecha: UITapGestureRecognizer)
    {
        
        
        let storyboard = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableViewCellViewController") as! TableViewCellViewController
        vc.email = self.email
        vc.likeStatus = self.pulsado
        present(vc, animated: true, completion: nil)
    }
    @objc func likeButtonTapped(tapLike: UITapGestureRecognizer){
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        let actualsLikes = Int(numberLikes!)
        let suma = actualsLikes! + 1
        let totalLikes = String(suma)
        
        pulsado = true

        let db = Firestore.firestore()
        
        db.collection("Post").document(postDocumentId!).updateData([
            "Likes" : totalLikes
            
            
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
        myGroup.leave()
        
        
    
    }
    
    
}
   

extension PostController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPost.dequeueReusableCell(withIdentifier: "PostViewCell" , for : indexPath)
            as! PostViewCell
        cell.PostModel = arrayData[indexPath.row]
        return cell
    }

}
