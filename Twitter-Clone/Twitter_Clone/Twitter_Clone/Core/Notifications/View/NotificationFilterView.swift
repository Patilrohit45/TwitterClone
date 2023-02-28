 //
//  SwiftUIView.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 31/01/23.
//

import SwiftUI

struct SwiftUIView: View {
    @State private var selectedFilter:TweetFilterViewModel = .tweets
    @Namespace var animation
    var body: some View {
        HStack(alignment:.top){
            ForEach(TweetFilterViewModel.allCases,id:\.rawValue){ item in
                VStack{
                    Text(item.title)
                        .font(.subheadline)
                        .fontWeight(selectedFilter == item ? .semibold : .regular)
                        .foregroundColor(selectedFilter == item ? .black : .gray)
                    
                    if selectedFilter == item {
                        Capsule()
                            .foregroundColor(Color(.systemBlue))
                            .frame(height:3)
                            .matchedGeometryEffect(id: "filter", in: animation)
                    }else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(height:3)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeOut){
                        self.selectedFilter = item
                    }
                }
            }
        }
        .overlay(Divider().offset(x:0,y:16))
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
