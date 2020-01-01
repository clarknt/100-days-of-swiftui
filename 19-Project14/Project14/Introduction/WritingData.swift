//
//  WritingData.swift
//  Project14
//
//  Created by clarknt on 2019-12-06.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct WritingData: View {
    var body: some View {
        Text("Tap me")
            .onTapGesture {
                let str = "Test message"
                let url = self.getDocumentDirectory().appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print("Read the following message from disk: \(input)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
    }

    func getDocumentDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // send back the first one, which ought to be the only one
        return paths[0]
    }
}

struct WritingData_Previews: PreviewProvider {
    static var previews: some View {
        WritingData()
    }
}
