//
//  CDataWithSwiftUI.swift
//  Fixing-Project11
//
//  Created by clarknt on 2019-11-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import SwiftUI

struct CDataWithSwiftUI: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>

    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "Umknown")
                }
            }
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: self.moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"

                try? self.moc.save()
            }
        }
    }
}

struct CDataWithSwiftUI_Previews: PreviewProvider {
    static var previews: some View {
        CDataWithSwiftUI()
    }
}
