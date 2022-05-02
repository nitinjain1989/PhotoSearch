//
//  Constants.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation
import UIKit
  
struct Keys
{
    static let flickrKey = "3e7cc266ae2b0e0d78e279ce8e361736"
}

struct SearchURL
{
    static let flickrBaseURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(Keys.flickrKey)&format=json&nojsoncallback=1&safe_search=1"
}

struct FlickrStatus
{
    static let success = "ok"
    static let error = "fail"
}

struct Constants {
    static let kScreenWidth = UIScreen.main.bounds.size.width
}

