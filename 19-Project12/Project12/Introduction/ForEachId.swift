//
//  ForEachID.swift
//  Project12
//
//  Created by clarknt on 2019-11-20.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct Student: Hashable {
    let name: String
}

struct ForEachId: View {
    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        List(students, id: \.self) { student in
            Text(student.name)
        }
    }
}

struct ForEachID_Previews: PreviewProvider {
    static var previews: some View {
        ForEachId()
    }
}
