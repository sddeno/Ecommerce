//
//  ContentView.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    var products: [Product] = [
        Product(imageName: "1", name: "Sea Sweater", price: 99),
        Product(imageName: "2", name: "Sea Sweater", price: 99),
        Product(imageName: "3", name: "Sea Sweater", price: 99),
        Product(imageName: "4", name: "Sea Sweater", price: 99),
        Product(imageName: "5", name: "Sea Sweater", price: 99),
        Product(imageName: "6", name: "Sea Sweater", price: 99),
        Product(imageName: "7", name: "Sea Sweater", price: 99),
    ]
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(products, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                    }
                }
                .padding()
            }
            .navigationTitle("Citadel Mall")
            .toolbar {
                NavigationLink {
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numberOfProducts: cartManager.productList.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().preferredColorScheme(.dark)
        
    }
    
}
