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
    let appManager: AppManager?
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        VStack() {
            
            WebView(urlString: post?.media)
                .frame(height: 230)
                .padding(.all)
            Spacer()
            
            Divider()
            
            Text(post!.desciption)
                .font(.system(size:22))
                .foregroundColor(Color.black)
                .padding(.all)

            
            Divider()
           
            
            
            Button(action: {
                self.appManager!.addOrder(order: self.post!)
                self.mode.wrappedValue.dismiss()
            }) {
                VStack {
                    Text("Order")
                    .font(.system(size:44))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                    
                    Text(String(format: "$%.02f",  post!.price))
                    .font(.system(size:24))
                    .bold()
                    .foregroundColor(Color.black)
                }
            }
            
            Text(String(format: "Total Ordered: $%.02f", appManager!.total))
                .foregroundColor(.black)
                .padding(.all)
            
            Spacer()
            
        }
        
        .navigationBarTitle(post!.product)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(post: nil, appManager: nil)
    }
}
