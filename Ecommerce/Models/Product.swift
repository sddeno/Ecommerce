//
//  Product.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import Foundation

class Product : Identifiable {
    var id = UUID()
    var imageName: String
    var name: String
    var price: Int
    var multipleSelectionCount: Int = 0
    
    init(imageName: String, name: String, price: Int) {
        self.imageName = imageName
        self.name = name
        self.price = price
    }
}
