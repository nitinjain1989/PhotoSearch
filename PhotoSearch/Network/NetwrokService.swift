//
//  NetwrokService.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import Foundation
class NetworkService
{
    typealias NetworkReponse = (Error?,Any?) ->()
    
    func performRequest(requestUrl:URL? ,completionBlock: @escaping NetworkReponse)
    {
        if let url = requestUrl
        {
            let dataTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, reponse, error) in
                
                if let err = error
                {
                    completionBlock(err, nil)
                    return
                }
                
                if let data = data
                {
                    do {
                        
                        let reponseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completionBlock(nil, reponseDict)
                        return
                    }
                    catch let error as NSError {
                        print("Error parsing JSON: \(error)")
                        completionBlock(error, nil)
                        return
                    }
                }
            })
            dataTask.resume()
        }
    }
}
