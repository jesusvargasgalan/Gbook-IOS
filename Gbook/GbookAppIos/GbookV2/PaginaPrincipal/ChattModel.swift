//
//  ChattModel.swift
//  GbookV2
//
//  Created by macOS12 on 14/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import Foundation
import UIKit


class ChattModel{
    var userName: String?
    var gameTitle: String?
    var profileURL : String?
    var gameImage : String?
    var checkGame : String?
    var like : String?
    var dislike : String?
    
    
    
    init(userName : String, gameTitle : String , profileURL : String, gameImage : String , checkGame : String){
        
        self.userName = userName
        self.gameTitle = gameTitle
        self.profileURL = profileURL
        self.gameImage = gameImage
        self.checkGame = checkGame

        /*self.gameImage = gameImage
        self.like = like
        self.dislike = dislike*/
        
    }
    
    
    
    
    
    
}
