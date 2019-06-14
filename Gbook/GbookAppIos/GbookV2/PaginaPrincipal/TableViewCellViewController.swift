//
//  TableViewCellViewController.swift
//  GbookV2
//
//  Created by macOS12 on 17/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseFirestore
import PUGifLoading


class TableViewCellViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    @IBOutlet weak var editPerfil: UIImageView!
    @IBOutlet weak var logoutImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var email:String?
    var videogameTitle:String?
    var likeStatus = false
    public var checkVideogameData:String?
    public var userDocumentId: String?
    public var emailData: String?
    public var nameData: String?
    public var secondNameData: String?
    public var userNameData: String?
    public var imagen : String?
    public var imagen2 : String?
    public var idVideojuego : String?
    
    
    
    var arrData = [ChattModel]()
    var arrayPost = [PostModel]()
    private var userData : [String : Any] = [:]
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let editUser = UITapGestureRecognizer(target: self, action: #selector(modifyUser(editUser:)))
        editPerfil.isUserInteractionEnabled = true
        editPerfil.addGestureRecognizer(editUser)
        
        let logout = UITapGestureRecognizer(target: self, action: #selector(logout(logoutUser:)))
        logoutImage.isUserInteractionEnabled = true
        logoutImage.addGestureRecognizer(logout)
        
        
        getUser()
        getAllFIRData()
       
       
        
        
        
        
        
        
        
       
        
        
        
        
       
        
        
        

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        getUser()
       
        
       
    }
    
    //MARK : Functions
    
    @IBAction func Postear(_ sender: UIButton) {
        
        
        let storyboard = UIStoryboard(name: "AddVideojuego", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddVideojuegoController") as! AddVideojuegoController
        vc.email = self.userData["Email"] as? String
        
        
        present(vc, animated: true, completion: nil)
        
        
    }
    @objc func modifyUser(editUser: UITapGestureRecognizer)
    {
        
        
        
                let storyboard = UIStoryboard(name: "Modify", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ModifyController") as! ModifyController
                vc.email = self.userData["Email"] as? String
                vc.likeStatus = likeStatus
                self.present(vc, animated: true, completion: nil)
                
                
        
        
    }
    @objc func logout(logoutUser: UITapGestureRecognizer)
    {
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainController") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        
        
        
        
    }
    func getUser(){
        
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        
        let db = Firestore.firestore()
        
        db.collection("Usuarios").whereField("Email", isEqualTo: email!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        self.userDocumentId = document.documentID
                        self.userData = document.data()
                        print(self.userDocumentId!)
                        self.emailData = self.userData["Email"] as? String
                        self.nameData = self.userData["Nombre"] as? String
                        self.secondNameData = self.userData["Apellidos"] as? String
                        self.userNameData = self.userData["Nombre de usuario"] as? String
                        
                        
                        
                        print(self.emailData!)
                
                        
                        
                    }
                     myGroup.leave()
                }
        }
    }
    
    
    func getAllFIRData(){
       
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        let db = Firestore.firestore()
        print("Email:")
        print(email!)
        
        db.collection("Post").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                       
                        self.userDocumentId = document.documentID
                        self.userData = document.data()
                        print(self.userDocumentId!)
                        self.userNameData = self.userData["NombredeUsuario"] as? String ?? ""
                        self.nameData = self.userData["Nombre"] as? String ?? ""
                        self.imagen = self.userData["FotoVideojuego"] as? String
                        self.imagen2 = self.userData["ImagenAvatar"] as? String
                        self.checkVideogameData = self.userData["Check"] as? String
                        
                        
                        print(self.nameData!)
                         print(self.userNameData!)
                         print(self.imagen!)
                     
                        
                      
                        
                        self.arrData.append(ChattModel(userName: self.userNameData!,gameTitle: self.nameData! , profileURL : self.imagen! , gameImage : self.imagen2!,checkGame : self.checkVideogameData!))
                        self.tableView.reloadData()
                       
                        

                        
                       
                       
                        
                        
                    }
                    
                    myGroup.leave()
                    
                  
                }
          
            
            
        }
        
       
        
    }
        
        
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TableViewCellViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
        print("IMPRIME")
        print(arrData.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" , for : indexPath)
        as! TableViewCell
        cell.chatModel = arrData[indexPath.row]
        print("IMPRIME")
        return cell
        
        
    }
   /* func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Post", bundle:nil)
        let vc = storyboard.instantiateInitialViewController(withIdentifier: "PostController") as! PostController
        
        let postCell = tableView.dequeueReusableCell(withIdentifier: "PostViewCell", for: indexPath) as! TableViewCell
        postCell.chatModel = arrData[indexPath.item]
        
        
      
        
        present(vc, animated: true, completion:nil)
    }*/
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Post", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PostController") as! PostController
        
        
        
        let postCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        postCell.chatModel = arrData[indexPath.item]
        print("ARRAYDATA")
        print(arrData[indexPath.item])
        vc.image = postCell.videoGamePost.image!
        vc.checkVideogame = postCell.videogameTitle.text
        vc.email = email
        vc.userName = postCell.userName.text
        vc.urlFoto = postCell.imageURL
        vc.pulsado = likeStatus
      
        
        
        print("ITEMS")
        
        present(vc , animated:true , completion: nil)
        
    }
    
}
