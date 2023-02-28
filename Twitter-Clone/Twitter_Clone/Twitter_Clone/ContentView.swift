//
//  ContentView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 13/01/23.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    @EnvironmentObject var launchScreenManager : LaunchScreenManager
    @State private var showMenu = false
 
    @EnvironmentObject var viewModel:AuthViewModel
    var body: some View {
       
            Group{
                //No  user logged in
                    if viewModel.userSession == nil{
                        LoginView()
                    }else{
                        //Have a logged in user
                        mainInterfaceView
                    }
                
            }
//            .onAppear {
//                DispatchQueue.main
//            .asyncAfter(deadline:.now() + 5){
//                launchScreenManager.dismiss()
//            }
        }
       
    }
   


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LaunchScreenManager())
    }
}

extension ContentView{
    
    var mainInterfaceView:some View{
        ZStack(alignment:.topLeading){
            MainTabView()
                .navigationBarHidden(showMenu)
            
            if showMenu{
                ZStack
                {
                    Color(.black)
                        .opacity(showMenu ? 0.25:0.0)
                }
                .onTapGesture {
                    withAnimation (.easeInOut){
                        showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width:300)
                .offset(x: showMenu ? 0:-300,y: 0)
                .background(showMenu ? Color.white:Color.clear)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if let user = viewModel.currentUser{
                    Button {
                        withAnimation(.easeInOut) {
                            showMenu.toggle()
                        }
                    } label: {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(width:32,height:32)
                            .clipShape(Circle())
                        
                       
                    }
                }
            }
        }
        .onAppear {
            showMenu = false
        }
    }
}
