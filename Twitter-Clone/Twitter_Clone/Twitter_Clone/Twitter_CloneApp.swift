//
//  Twitter_CloneApp.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 19/01/23.
//

import SwiftUI
import Firebase
@main
struct Twitter_CloneApp: App {
    @StateObject var viewModel = AuthViewModel()
//    @State var launchScreenManager = LaunchScreenManager()
//    @State var animate = false
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                NavigationView{

                    ContentView()
                    
                }
                .environmentObject(viewModel)
                
//                if launchScreenManager.state != .completed{
//                    LaunchScreenView()
//                }
            }
//            .environmentObject(launchScreenManager)
        }
    }
}
