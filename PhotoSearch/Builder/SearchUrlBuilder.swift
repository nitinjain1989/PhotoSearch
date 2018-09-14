//
//  SearchUrlBuilder.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation

struct SearchUrlBuilder {
    
    var searchText:String = ""
    var pageCount:Int = 1
    
    
    func getUrl() -> URL?
    {
        return  URL(string: SearchURL.flickrBaseURL+"&text=\(self.searchText)&page=\(pageCount)&per_page=20")
    }
}
