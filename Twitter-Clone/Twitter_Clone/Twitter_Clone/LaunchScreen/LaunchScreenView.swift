//
//  LaunchScreenView.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 27/01/23.
//

import SwiftUI

struct LaunchScreenView: View {
    @EnvironmentObject var launchScreenManager : LaunchScreenManager
    @State private var firstPhaseIsAnimating:Bool = false
    @State private var secondPhaseIsAnimating:Bool = false
    private var timer = Timer.publish(every: 0.65,
                                      on: .main,
                                      in: .common).autoconnect()
    
    var body: some View {
        ZStack{
            background
            logo
        }.onReceive(timer) { input in
            switch launchScreenManager.state{
            //first phase with coninuos scaling
            case .first:
                withAnimation(.spring()){
                firstPhaseIsAnimating.toggle()
                }
            case .second:
            withAnimation(.easeInOut){
                secondPhaseIsAnimating.toggle()
            }
            default: break
        }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
            .environmentObject(LaunchScreenManager())
    }
}
private extension LaunchScreenView{
    var background:some View{
        Color("bg")
            .edgesIgnoringSafeArea(.all)
    }
    
    var logo:some View{
        Image("logo")
            .scaleEffect(firstPhaseIsAnimating ? 0.6 : 1)
            .scaleEffect(secondPhaseIsAnimating ? UIScreen.main.bounds.size.height / 4 : 1)
    }
}
