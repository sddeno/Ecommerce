//
//  Cache.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 07/12/23.
//

import Foundation
import SwiftUI


final class ImageCache {
    
    static let shared = ImageCache()
    
    private let cache = NSCache<AnyObject,AnyObject>()
    
    private init(){}
    
    func set(_ image: Image, forKey key: String) {
            cache.setObject(image as AnyObject, forKey: key as NSString)
        }

    func get(forKey key: String) -> Image? {
        return cache.object(forKey: key as NSString) as? Image
    }
}
