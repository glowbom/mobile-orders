//
//  ContentView.swift
//  MobileOrders
//
//  Created by Jacob Ilin on 4/25/20.
//  Copyright © 2020 Glowbom. All rights reserved.
//

import SwiftUI

enum ActiveAlert {
    case success, noname, noorders
}

struct ContentView: View {
    
    @State private var name: String = ""
    
    @State private var selection = 0
    
    @State private var leftPictureNumber = 1;
    @State private var rightPictureNumber = 3;
    
    @State private var showingAlert = false;
    @State private var activeAlert: ActiveAlert = .success
    
    @ObservedObject var networkManager = NetworkManager()
    @ObservedObject var appManager = AppManager()
 
    var body: some View {
        ZStack {

            TabView(selection: $selection){
                ZStack {
                    NavigationView {
                        VStack {
                           
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
                                        var data = self.name + "," + String(self.appManager.total) + ","
                                        
                                        for item in self.appManager.orders {
                                            data += (item.id + ",");
                                        }
                                        
                                        self.networkManager.placeOrder(data: data)
                                        
                                        self.appManager.total = 0.0;
                                        self.appManager.orders.removeAll();
                                        self.showingAlert = true;
                                        self.activeAlert = .success
                                    } else {
                                        self.showingAlert = true;
                                        self.activeAlert = .noorders
                                    }
                                } else {
                                    self.showingAlert = true;
                                    self.activeAlert = .noname
                                }
                                
                            }) {
                                Text("Place Order")
                                    .font(.system(size:34))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.black)
                                    .padding(.all)
                                
                                Button(action: {
                                    self.appManager.total = 0.0;
                                    self.appManager.orders.removeAll();
                                }) {
                                    Text("Cancel")
                                }
                            }
                            .alert(isPresented: $showingAlert) {
                                switch activeAlert {
                                case .success:
                                    return Alert(title: Text("Thank you, " + name + "!"), message: Text("Your order has been placed. See you soon!"), dismissButton: .default(Text("Great!")))
                                case .noname:
                                    return Alert(title: Text("Order"), message: Text("Please enter your name."), dismissButton: .default(Text("Ok")))
                                case .noorders:
                                    return Alert(title: Text("Order"), message: Text("You didn't order anything."), dismissButton: .default(Text("Ok")))
                                }
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
