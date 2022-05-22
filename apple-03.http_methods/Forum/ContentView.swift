//
//  ContentView.swift
//  Forum
//
//  Created by Emmanuel Solis on 3/3/22.
//

import SwiftUI

struct ContentView: View {
  private var my_view: ModelView = ModelView()
  
    var body: some View {
      VStack{
        Text("Mi primer llamado URL, que emocion!")
          .padding()
        Button("Call Server") {
          my_view.get_server_info()
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
