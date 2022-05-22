//
//  ContentView.swift
//  SwiftUI_MVVM
//
//  Created by Emmanuel Solis on 3/27/22.
//

import SwiftUI

// -------------- MODEL -------------
class User: ObservableObject, Identifiable {
  var id = UUID()
  @Published var name: String
  
  init (my_name: String){
    self.name = my_name
  }
}

// ------------ VIEW MODEL ---------
class UserlListViewModel: ObservableObject {
  @Published var users: [User]
  
  init(){
    users = []
  }
  
  func append_user(my_name: String) {
    // Add new user.
    users.append(User(my_name: my_name))
  }
}

// -------------- VIEW --------------
struct UserDetailView: View {
  var user: User
  
  var body: some View {
    VStack{
      Image("user")
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.blue, lineWidth: 20))
      HStack {
        Text(user.name)
      }.padding(.top, 10)
      Spacer()
    }
  }
}

struct FormCell: View {
  var user: User
  
  var body: some View {
    HStack {
      Text(user.name)
    }
  }
}

struct FormUser: View {
  @State var username: String = ""
  @StateObject var user_list_viewmodel: UserlListViewModel
  
  var body: some View {
    VStack {
      HStack {
        Text("Enter your name").padding(.leading, 8)
        TextField("User Name", text: $username)
          .textFieldStyle(
            RoundedBorderTextFieldStyle()
          ).padding(.trailing, 8)
      }
      Button("Save") {
        user_list_viewmodel.append_user(my_name: self.username)
          // Clean the variable.
        self.username = ""
      }
    }
  }
}

struct ContentView: View {
    @ObservedObject var user_list_model = UserlListViewModel()
  
    var body: some View {
      NavigationView {
        VStack {
          FormUser(user_list_viewmodel: self.user_list_model)
          Spacer()
          List(self.user_list_model.users, id: \.id) { user in
            NavigationLink(destination: UserDetailView(user: user)) {
              FormCell(user: user)
            }
          }
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
