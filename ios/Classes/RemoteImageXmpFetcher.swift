//
//  ImageFetcher.swift
//  Construct IN
//
//  Created by Queizy Sartori on 17/04/20.
//  Copyright © 2020 Queizy Sartori. All rights reserved.
//

import Foundation

class RemoteImageXmpFetcher {
    private static func handleData(data: Data?, completion: @escaping ([String: String]) -> ()) {
        let source = CGImageSourceCreateWithData(data! as CFData, nil)
        let meta = CGImageSourceCopyMetadataAtIndex(source!, 0, nil)
        var metadata: [String: String] = [:]

        CGImageMetadataEnumerateTagsUsingBlock(meta!, nil, nil, {
            (key, tag) -> Bool in
            let keyNS = key as NSString
            let keyString = keyNS as String
            metadata[keyString] = (CGImageMetadataTagCopyValue(tag) as? String)
            
            return true
        })
        
        completion(metadata)
    }
    
    private static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        URLSession.shared.dataTask(with: url, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                completion(data, response, error)
            }
            
            completion(nil, response, error)
        }).resume()
    }
    
    public static func fetch(url: String, completion: @escaping ([String:String]) -> ()) {
        getData(from: URL(string: url)!, completion: {
            (data: Data?, _, error) in
            if let data = data {
                self.handleData(data: data) {
                    metadata in completion(metadata)
                }
            }
            
            completion(["error": error.debugDescription])
        })
    }
}
