//
//  PhotoEntity.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation

class PhotoEntity
{
    var photoId: String?
    var farm: Int?
    var secret: String?
    var server: String?
    var title: String?
    
    var photoUrl: String? {
        
        guard let photoId = self.photoId,let farm = self.farm, let secret = self.secret, let server = self.server else {
            return nil
        }
        return "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_m.jpg"
    }
    
    init(_ dict:[String:Any])
    {
        self.photoId = dict["id"] as? String
        self.farm = dict["farm"] as? Int
        self.secret = dict["secret"] as? String
        self.server = dict["server"] as? String
        self.title = dict["title"] as? String
    }
}
