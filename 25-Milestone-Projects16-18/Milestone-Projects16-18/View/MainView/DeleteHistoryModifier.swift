//
//  MainViewDeleteHistory.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-02-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

/// Shows an ActionSheet on phones, an Alert on tablets
/// (ActionSheet is not working on ipad due to a SwiftUI bug)
struct DeleteHistoryModifier: ViewModifier {
    @Binding var showingAction: Bool
    var action: () -> Void

    private let title = Text("Delete history?")
    private let deleteButton = Text("Delete all")

    func body(content: Content) -> some View {
        return Group {
            if UIDevice.current.userInterfaceIdiom == .pad {
                content.alert(isPresented: $showingAction, content: {
                    Alert(title: title,
                          primaryButton: .destructive(deleteButton, action: action),
                          secondaryButton: .cancel())
                })
            }
            else {
                content.actionSheet(isPresented: $showingAction, content: {
                    ActionSheet(title: title, buttons: [
                        .destructive(deleteButton, action: action),
                        .cancel()]
                    )
                })
            }
        }
    }
}

