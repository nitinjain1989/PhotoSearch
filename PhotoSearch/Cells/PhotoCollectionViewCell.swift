//
//  PhotoCollectionViewCell.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setDataOnCell(_ photo:PhotoEntity)
    {
        if let urlStr =  photo.photoUrl,let url = URL(string: urlStr)
        {
            self.photoImageView.image = nil
            ImageDownloadManager.downloadImage(url: url) { [weak self] (image, error,url) in
                DispatchQueue.main.async {
                    if urlStr == url.absoluteString
                    {
                         self?.photoImageView.image = image
                    }
                }
            }
        }
    }
}
