//
//  ProductRow.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 04/12/23.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    
    var product: Product
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: product.imageName), content: { image in
                image
                    .resizable()
                    .scaledToFit()
            }, placeholder: {
                ProgressView()
            })
            .scaledToFit()
            .frame(width: 150, height: 100)
            .cornerRadius(10)
            
            namePriceQuantity()
            
            Spacer()
            
            binButton()
            
        }
        .padding()
        .background {
            Color.gray
        }
        .cornerRadius(10)
        .padding()
    }
    
    func namePriceQuantity() -> some View {
        VStack(alignment: .leading,spacing: 10){
            Text("\(product.name)")
            Text("$\(product.price)")
            HStack{
                Text(" Qnt: \(product.multipleSelectionCount)")
                //                    quantityPlusMinus(product: product)
                Stepper("") {
                    cartManager.addToCart(product: product)
                } onDecrement: {
                    cartManager.removeFromCart(product: product)
                }
            }
            .border(.white)
        }
    }
    
    func binButton() -> some View {
        Button {
            cartManager.deleteFromCart(product: product)
        } label: {
            Image("bin")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.red)
                .cornerRadius(10)
        }
    }
    
    //    func quantityPlusMinus(product: Product) -> some View {
    //        HStack{
    //            Button {
    //                cartManager.removeFromCart(product: product)
    //            } label: {
    //                Image(systemName: "minus.square.fill")
    //                    .resizable()
    //                    .frame(width: 25, height: 25)
    //            }
    //            .foregroundColor(.black)
    //
    //            Spacer()
    //
    //            Button {
    //                cartManager.addToCart(product: product)
    //            } label: {
    //                Image(systemName: "plus.square.fill")
    //                    .resizable()
    //                    .frame(width: 25, height: 25)
    //            }
    //            .foregroundColor(.black)
    //
    //        }
    //        .padding(6)
    //        .background(content: {Color.white})
    //        .cornerRadius(5)
    //    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product(imageName: "1", name: "sea sweater", price: 33))
            .environmentObject(CartManager())
    }
}
