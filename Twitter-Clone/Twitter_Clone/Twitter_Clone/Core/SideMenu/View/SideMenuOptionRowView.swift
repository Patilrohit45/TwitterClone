//
//  SideMenuOptionRowView.swift
//  TwitterClone
//
//  Created by Rohit Patil on 16/01/23.
//

import SwiftUI

struct SideMenuOptionRowView: View {
    let viewModel:SideMenuViewModel
    var body: some View {
        HStack(spacing:4){
            Image(systemName: viewModel.imageName)
                .font(.headline)
                .foregroundColor(.gray)
            
            Text(viewModel.titile)
                .foregroundColor(.black)
                .font(.subheadline)
            Spacer()
        }
        .frame(height:40)
        .padding(.horizontal)
    }
}

struct SideMenuOptionRowView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionRowView(viewModel: .profile)
    }
}
