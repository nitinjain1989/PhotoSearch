//
//  PhotoViewModel.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation

class PhotoViewModel
{
    typealias Listener = () -> ()
    typealias ErrorListener = () -> ()
    var listener: Listener?
    var errorListener: ErrorListener?
    var isFetching = false
    var isMoreFetching = true
    var photos:[PhotoEntity] = [PhotoEntity]() {
        didSet {
            self.listener?()
        }
    }
    var pageCount = 1
    
    func getSearchData(_ text:String)
    {
        if let url = SearchUrlBuilder(searchText: text, pageCount: pageCount).getUrl()
        {
            self.isFetching = true
            let networkService = NetworkService()
            networkService.performRequest(requestUrl: url) { [weak self] (error, response) in
                
                guard let sself = self else { return }
                sself.isFetching = false
                if let reponseDict = response as? [String:Any]
                {
                    if let pages = reponseDict["pages"] as? Int
                    {
                        sself.isMoreFetching = pages > sself.pageCount
                    }
                    
                    if let status = reponseDict["stat"] as? String
                    {
                        switch status
                        {
                        case FlickrStatus.success:
                            sself.parseSearchData(reponseDict)
                            break
                        case FlickrStatus.error:
                            sself.errorListener?()
                            break
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
    
    func parseSearchData(_ reponse:[String:Any])
    {
        guard let photosContainer = reponse["photos"] as? [String:Any] else { return }
        
        
        if let photos = photosContainer["photo"] as? [[String:Any]],photos.count > 0
        {
            var photoEntities = [PhotoEntity]()
            
            for value in photos
            {
                let entity = PhotoEntity(value)
                photoEntities.append(entity)
            }
            self.photos.append(contentsOf: photoEntities)
        }
    }
}
