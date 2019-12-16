//
//  DetailView.swift
//  Fixing-Project11
//
//  Created by clarknt on 2019-11-18.
//  Copyright © 2019 clarknt. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode

    @State private var showingDeleteAlert = false

    let book: Book

    // challenge 1
    var genreName: String {
        guard let genre = book.genre else { return "Unknown" }
        guard !genre.isEmpty else { return "Unknown" }

        return genre
    }

    // challenge 3
    var formattedDate: String {
        guard let date = book.date else { return "" }
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return "Reviewed on \(formatter.string(from: date))"
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    // challenge 1
                    Image(self.genreName)
                        .frame(maxWidth: geometry.size.width)

                    // challenge 1
                    Text(self.genreName.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()

                // challenge 3
                Text(self.formattedDate)
                    .padding()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"),
                  message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")) { self.deleteBook() },
                  secondaryButton: .cancel()
            )
        }
    }

    func deleteBook() {
        moc.delete(book)

        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."

        return NavigationView {
            DetailView(book: book)
        }
        .colorScheme(.dark)
    }
}
