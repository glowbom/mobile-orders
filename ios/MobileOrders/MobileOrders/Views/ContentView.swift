//
//  ContentView.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name: String = ""
    
    @State private var selection = 0
    
    @State private var leftPictureNumber = 1;
    @State private var rightPictureNumber = 3;
    
    @State private var showingNameAlert = false;
    @State private var showingOrdersAlert = false;
    
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var appManager = AppManager()
 
    var body: some View {
        ZStack {

            TabView(selection: $selection){
                ZStack {
                    NavigationView {
                        List(networkManager.posts) { post in
                            NavigationLink(destination: DetailView(post: post, appManager: self.appManager)) {
                                HStack {
                                    Text(post.product)
                                        .font(.system(size: 22))
                                        .frame(minWidth: 260, minHeight: 60, alignment: .leading)
                                    Text(String(format: "$%.02f",  post.price))
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                        }
                        .navigationBarTitle("Menu")
                    }
                }.tabItem {
                    VStack {
                        Image("first")
                        Text("Order")
                    }
                }.tag(0)
                
                
                ZStack {
                    NavigationView {
                        VStack {
                            TextField("Enter your name", text: $name)
                                .font(.system(size:34))
                                .frame(alignment: .center)
                                .padding(.all)
                            
                            List(appManager.orders) { post in
                                HStack {
                                    Text(post.product)
                                        .font(.system(size: 22))
                                        .frame(minWidth: 260, minHeight: 60, alignment: .leading)
                                    Text(String(format: "$%.02f",  post.price))
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                            }
                            
                            
                            Text(String(format: "Total Ordered: $%.02f", appManager.total))
                                .foregroundColor(.black)
                                .padding(.all)
                            
                            Button(action: {
                                if (self.name != "") {
                                    if (self.appManager.orders.count > 0) {
                                        self.appManager.orders.removeAll();
                                    } else {
                                        self.showingOrdersAlert = true;
                                    }
                                } else {
                                    self.showingNameAlert = true;
                                }
                                
                            }) {
                                Text("Order")
                                    .font(.system(size:44))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(.all)
                            }
                            .alert(isPresented: $showingOrdersAlert) {
                                Alert(title: Text("Order"), message: Text("You didn't order anything."), dismissButton: .default(Text("Ok")))
                            }
                            .alert(isPresented: $showingNameAlert) {
                                Alert(title: Text("Order"), message: Text("Please enter your name."), dismissButton: .default(Text("Ok")))
                            }
                        }
                        .navigationBarTitle("Checkout")
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
