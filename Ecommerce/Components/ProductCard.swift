//
//  ProductCard.swift
//  Ecommerce
//
//  Created by Shubham Deshmukh on 02/12/23.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    var imageName: String
    var name: String
    var price: Int
    var imageWidth: CGFloat = UIScreen.main.bounds.width / 2.1
    @State var step = 0
    
    init(product: Product) {
        self.imageName = product.imageName
        self.name = product.name
        self.price = product.price
        self.product = product
    }
    
    var body: some View {
        VStack{
            // Image
            let cacheImage = ImageCache.shared.get(forKey: product.imageName)
            
            if let image = cacheImage {
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                        .background(content: {
                            Color.pink
                        })
                        .overlay(alignment: .topTrailing, content: {
                            addToCartButton()
                        })
                        .cornerRadius(10)
                    
                    foundInCache()
               }
            }else{
                AsyncImage(url: URL(string: product.imageName), content: { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(5)
                    
                    storeInCache(image: image)
                }, placeholder: {
                    ProgressView()
                })
                .frame(minWidth: imageWidth)
                .frame(height: 250)
                .scaledToFit()
                .background(.gray)
                .cornerRadius(10)
                .overlay(alignment: .topTrailing, content: {
                    addToCartButton()
                })
                .cornerRadius(10)
            }
        }
        .overlay(alignment: .bottom) {
            namePriceBelt()
        }
    }
    
    
    func foundInCache() -> some View{
        print("found in cache")
        return EmptyView()
    }
    func storeInCache(image: Image) -> some View {
        ImageCache.shared.set(image, forKey: product.imageName)
        print("image added to cache")
        return EmptyView()
    }
    
    func addToCartButton() -> some View {
        Button {
            cartManager.addToCart(product: product)
        } label: {
            Image("AddToCart")
                .resizable()
                .frame(width: 40, height: 40)
                .cornerRadius(90)
                .padding()
        }
    }
    
    func namePriceBelt() -> some View {
        Rectangle()
            .frame(minWidth: imageWidth, maxHeight: 66)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading){
                    Text("\(name)")
                        .fontWeight(.medium)
                        .font(.headline)
                    Text("$\(price)")
                        .fontWeight(.light)
                        .font(.caption)
                }
                .padding(.all)
            }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product(imageName: "1", name: "Sea Sweater", price: 990))
            .environmentObject(CartManager())
    }
}
