//
//  Intro02AlertAndSheet.swift
//  Project19
//
//  Created by clarknt on 2020-01-29.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct Intro02AlertAndSheet: View {
    @State private var selectedUser: User? = nil

    var body: some View {
        Text("Hello, World!")
        .onTapGesture {
            self.selectedUser = User()
        }
        .alert(item: $selectedUser) { user in
            Alert(title: Text(user.id))
        }
    }

    // Alternative with Bool would have been
//    @State private var selectedUser: User? = nil
//    @State private var isShowingAlert = false
//
//    var body: some View {
//        Text("Hello, World!")
//            .onTapGesture {
//                self.selectedUser = User()
//                self.isShowingAlert = true
//            }
//            .alert(isPresented: $isShowingAlert) {
//                Alert(title: Text(selectedUser!.id))
//            }
//    }
}

struct Intro02AlertAndSheet_Previews: PreviewProvider {
    static var previews: some View {
        Intro02AlertAndSheet()
    }
}
