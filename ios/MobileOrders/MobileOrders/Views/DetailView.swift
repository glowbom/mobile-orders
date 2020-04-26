//
//  DetailView.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let post: Post?
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack() {
            
            
            WebView(urlString: post?.media)
                .frame(height: 300)
            
            Spacer()
            Divider()
            
            Text(post!.product)
                .bold()
                .foregroundColor(Color.black)
                .padding(.all)
            
            Text(post!.desciption)
                .foregroundColor(Color.black)
                .padding(.all)
           
            Text("$" + post!.price.description)
                .bold()
                .foregroundColor(Color.black)
                .padding(.all)
            
            Divider()
            Spacer()
            
            
            Button(action: {
                AppManager.instance.orders.append(self.post!)
                self.mode.wrappedValue.dismiss()
            }) {
                VStack {
                    Text("Order")
                        .font(.system(size:50))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Total Ordered: " + String(AppManager.instance.orders.count))
                        .foregroundColor(.black)
                        .padding()
                }
            }
            
            Spacer()
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(post: nil)
    }
}
