//
//  ContentView.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    @State private var leftPictureNumber = 1;
    @State private var rightPictureNumber = 3;
    
    @ObservedObject var networkManager = NetworkManager()
 
    var body: some View {
        ZStack {
            Color(red: 0.09, green: 0.63, blue: 0.52)
                .edgesIgnoringSafeArea(.all)
            TabView(selection: $selection){
                ZStack {
                    NavigationView {
                        List(networkManager.posts) { post in
                            NavigationLink(destination: DetailView(url: post.media)) {
                                HStack {
                                    Text(String(post.price))
                                    Text(post.product)
                                }
                            }
                        }
                        .navigationBarTitle("Please order...")
                    }
                }.tabItem {
                    VStack {
                        Image("first")
                        Text("Order")
                    }
                }.tag(0)
                
                
                ZStack {
                    Color(red: 0.09, green: 0.63, blue: 0.52)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("glowbom_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150, alignment: .center)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .overlay(Circle().stroke(Color.black, lineWidth: 2))
                        Text("Glowbom Notes")
                            .font(Font.custom("Pacifico-Regular", size: 40))
                            .bold()
                            .foregroundColor(Color.white)
                            
                        Text("Universal App Engine")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                        Divider()
                        InfoView(text: "support@glowbom.com", imageName: "envelope.fill")
                        InfoView(text: "+1 (415) 777-7777", imageName: "phone.fill")
                    }
                }.tabItem {
                    VStack {
                        Image("second")
                        Text("Checkout")
                    }
                }
                .tag(1)
            }
        }
        .onAppear {
            self.networkManager.fetchData();
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        //.previewDevice(PreviewDevice(rawValue: "iPhone Xʀ"))
    }
}



struct PictureView: View {
    
    let n: Int
    
    var body: some View {
        Image("image-\(n)")
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding()
    }
}
