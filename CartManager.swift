//
//  ProductManger.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import Foundation


class CartManager: ObservableObject {
    @Published var total: Int = 0
    @Published var itemCount: Int = 0
    @Published var productList: [Product] = []
    
    func addToCart(product: Product) {
        if product.multipleSelectionCount > 0 {
            productList = productList.map{ item in
                if (item.id == product.id) {
                    item.multipleSelectionCount += 1
                }
                return item
            }
            
        }else{
            productList.append(product)
            product.multipleSelectionCount += 1
        }
        itemCount += 1
        total += product.price
    }
    
    func removeFromCart(product: Product) {
        if product.multipleSelectionCount == 0 { return }
        
        if product.multipleSelectionCount > 1 {
            productList = productList.map{ item in
                if (item.id == product.id) {
                    item.multipleSelectionCount -= 1
                }
                return item
            }
        }else{
            productList = productList.filter({
                product.id != $0.id
            })
            product.multipleSelectionCount -= 1
        }
        
        itemCount -= 1
        total -= product.price
    }
    
    func deleteFromCart(product: Product){
        productList = productList.filter({
            product.id != $0.id
        })
    }
}
