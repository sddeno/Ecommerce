//
//  ContentView.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    @StateObject var productViewModel = ProductsViewModel()
    
    var columns: [GridItem] = [GridItem(.adaptive(minimum: 160),spacing: 20)]
    @State var products: [Product] = []
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
        .task{
            await productViewModel.getProducts { result in
                switch result {
                case .success(let allProducts):
                    DispatchQueue.main.async {
                        self.products = allProducts
                    }
                case .failure(let error):
                    print("Error while fetching data \(error)")
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().preferredColorScheme(.light)
        ContentView().preferredColorScheme(.dark)
        
    }
    
}
