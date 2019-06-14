//
//  PostViewCell.swift
//  GbookV2
//
//  Created by macOS12 on 31/05/2019.
//  Copyright © 2019 macOS12. All rights reserved.
//

import UIKit
import Kingfisher
class PostViewCell: UITableViewCell {
    
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var comments: UITextView!
    @IBOutlet weak var userName: UILabel!
    
    var PostModel : PostModel?{
        
        
        didSet{
            self.userName.text = PostModel?.userName
            self.comments.text = PostModel?.comment
            let url = URL(string : ((PostModel?.avatarImage)!))
            if let url = url as? URL{
                KingfisherManager.shared.retrieveImage(with: url as! Resource , options: nil, progressBlock: nil){ (image, error , cache , imageURL) in
                    
                    self.imageAvatar.image = image
                    self.imageAvatar.kf.indicatorType = .activity
                    
                    
                    self.imageAvatar.layer.borderColor = UIColor.black.cgColor
                    self.imageAvatar.layer.cornerRadius =  self.imageAvatar.frame.size.width/2
                    self.imageAvatar.clipsToBounds = true
                    
                    
                }
                
            }
            
        }
    }
}


   
   
