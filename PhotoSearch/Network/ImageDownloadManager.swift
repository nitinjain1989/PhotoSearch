//
//  ImageDownloadManager.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 14/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadManager
{
    typealias ImageDownloaderResponse = (_ image: UIImage?, _ error: Error? ,_ downloadinURL:URL ) ->()
    static let imageCache = NSCache<NSString,UIImage>()
    
    static func downloadImage(url: URL, completion: @escaping ImageDownloaderResponse)
    {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString)
        {
            completion(cachedImage, nil,url)
        }
        else
        {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil
                {
                    completion(nil,error,url)
                }
                
                if let data = data,let downloaedImage = UIImage(data: data)
                {
                    imageCache.setObject(downloaedImage, forKey: url.absoluteString as NSString)
                    completion(downloaedImage,nil,url)
                }
            }
            task.resume()
        }
    }
}
