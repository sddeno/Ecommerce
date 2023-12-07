//
//  ProductsViewModel.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 06/12/23.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case badURL
}

class ProductsViewModel : ObservableObject {
    
    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) async {
        do{
            let (data,response) = try await URLSession.shared.data(from: URL(string: "https://fakestoreapi.com/products")!)
           
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(.failure(NetworkError.badURL))
                return
            }
            let allProducts = try JSONDecoder().decode([ProductEntity].self, from: data)
            var products: [Product] = []
            for product in allProducts {
                products.append(Product(imageName:  product.image ?? "", name: product.title ?? "", price: Int(product.price ?? 0)))
            }
            completion(.success(products))
        }catch {
            completion(.failure(NetworkError.badURL))
        }
    }
    
    
//    func getProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
//
//        URLSession.shared.dataTask(with: URL(string: "https://fakestoreapi.com/products")!) { data, response, error in
//
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
//                completion(.failure(error!))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(error!))
//                return
//            }
//
//            do {
//                let allProducts = try JSONDecoder().decode([ProductEntity].self, from: data)
//
//                var products: [Product] = []
//
//                for product in allProducts {
//                    products.append(Product(imageName: product.image ?? "", name: product.title ?? "", price: Int(product.price ?? 0)))
//                }
//                completion(.success(products))
//            } catch {
//                completion(.failure(error))
//            }
//
//        }.resume()
//    }
}
