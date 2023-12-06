//
//  CartView.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        ScrollView{
            if cartManager.productList.count > 0 {
                ForEach(cartManager.productList) { product in
                    cartProduct(product: product)
                }
                HStack{
                    Text("Your cart total : ")
                    Text("$\(cartManager.total)")
                        .bold()
                }
            }else{
                Text("your cart is empty")
            }
        }
        .navigationTitle(Text("My Cart"))
        .padding(.top)

    }
    
    func cartProduct(product: Product) -> some View {
        ProductRow(product: product)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
