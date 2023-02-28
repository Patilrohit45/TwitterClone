//
//  ChatLogView.swift
//  Twitter_Clone
//
//  Created by Rohit Patil on 25/01/23.
//

import SwiftUI
import Firebase

struct ChatLogView: View {
//    let user : User?
//    init(user:User?){
//        self.user = user
//        self.viewModel = .init(user: user)
//    }
    @ObservedObject var viewModel:ChatLogViewModel
    var body: some View {
        ZStack{
            messagesView
            Text(viewModel.errorMessage)
        }
        .navigationTitle(viewModel.user?.fullname ?? "")
            .navigationBarTitleDisplayMode(.inline)
            .onDisappear {
                viewModel.firestoreListner?.remove()
            }
//            .navigationBarItems(trailing: Button(action: {
//                viewModel.count += 1
//            }, label: {
//                Text("Count: \(viewModel.count)")
//            }))
    }
    static let emptyScrollToString = "Empty"
    private var messagesView:some View{
        VStack{
            ScrollView{
                ScrollViewReader{ ScrollViewProxy in
                    VStack{
                        ForEach(viewModel.chatMessages){ message in
                            MessageView(message:message)
                        }
                        HStack{Spacer()}
                        .id(Self.emptyScrollToString)
                    }
                    .onReceive(viewModel.$count) { _ in
                        withAnimation (.easeOut(duration: 0.5)){
                            ScrollViewProxy.scrollTo(Self.emptyScrollToString, anchor: .bottom)
                        }
                    }
                }
            }
            .background(Color(.init(white: 0.95, alpha: 1)))
            .safeAreaInset(edge: .bottom) {
                chatBottomBar
                    .background(Color(.systemBackground).ignoresSafeArea())
            }
        }
    }
    
    
    struct MessageView: View{
        let message:ChatMessage
        var body:some View{
            VStack{
                if message.fromId == Auth.auth().currentUser?.uid{
                    HStack{
                        Spacer()
                        HStack{
                            Text(message.text)
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                }else{
                    HStack{
                      
                        HStack{
                            Text(message.text)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                        Spacer()
                    }
                    
                }
            }.padding(.horizontal)
                .padding(.top,8)
        }
        
     
    }
    
    private var chatBottomBar:some View{
        HStack{
            Image(systemName: "photo.fill.on.rectangle.fill")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            ZStack{
                DescriptionPlaceholder()
                TextEditor(text: $viewModel.chatText)
                        .frame(height: max(40,20))
                        //.padding(.horizontal,20)
                        .opacity(viewModel.chatText.isEmpty ? 0.5 : 1)
            }
            Button {
                viewModel.handleSend()
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.vertical,8)
    }
    private struct DescriptionPlaceholder:View{
        var body: some View{
            HStack{
                Text("Description")
                    .foregroundColor(Color(.gray))
                    .font(.system(size: 17))
                    .padding(.leading,5)
                    .padding(.top,-4)
                Spacer()
            }
        }
    }
    
}

//struct ChatLogView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            ChatLogView(user: nil)
//        }
//    }
//}
