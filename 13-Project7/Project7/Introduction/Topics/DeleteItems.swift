//
//  DeleteItems.swift
//  Project7
//
//  Created by clarknt on 2019-10-30.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct DeleteItems: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    // onDelete is available on ForEach but not on the List
                    ForEach(numbers, id: \Int.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct DeleteItems_Previews: PreviewProvider {
    static var previews: some View {
        DeleteItems()
    }
}
