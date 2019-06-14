//
//  TableViewCell.swift
//  GbookV2
//
//  Created by macOS12 on 17/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell{
    
    
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var videogameTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var videoGamePost: UIImageView!
    @IBOutlet weak var checkGame: UILabel!
    
    public var imageURL = ""
    
    var chatModel : ChattModel?{
        
        
        didSet{
            self.userName.text = chatModel?.userName
            videogameTitle.text = chatModel?.gameTitle
            self.checkGame?.text = chatModel?.checkGame 
            let url = URL(string : ((chatModel?.profileURL)!))
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as! Resource , options: nil, progressBlock: nil){ (image, error , cache , imageURL) in
                    
                    self.videoGamePost.image = image
                    self.videoGamePost.kf.indicatorType = .activity
                    self.imageURL = imageURL?.absoluteString ?? ""
                }
            }
            
            
            
            let url2 = URL(string : ((self.chatModel?.gameImage)!))
            if let url2 = url2 as? URL{
                KingfisherManager.shared.retrieveImage(with: url2 as! Resource , options: nil, progressBlock: nil){ (image, error , cache , imageURL) in
                    
                    self.avatarImage.image = image
                    self.avatarImage.kf.indicatorType = .activity
                    
             
                    
                    self.avatarImage.layer.borderColor = UIColor.black.cgColor
                    self.avatarImage.layer.cornerRadius =  self.avatarImage.frame.size.width/2
                    self.avatarImage.clipsToBounds = true
                    
                    
                }
            }
        }
        
        
        
        
    }
    
    
    
    
}


