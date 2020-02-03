//
//  MainViewRollsList.swift
//  Milestone-Projects16-18
//
//  Created by clarknt on 2020-02-02.
//  Copyright © 2020 clarknt. All rights reserved.
//

import SwiftUI

struct RollsList<GenericRolls: Rolls>: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var rolls: GenericRolls
    @Binding var showingAction: Bool

    var body: some View {
        GeometryReader { listProxy in
            List {
                ForEach(self.rolls.all) { roll in
                    GeometryReader { itemProxy in
                        ZStack {
                            HStack {
                                Text("\(roll.dieSides)")
                                Text("⚁")
                                    .rotationEffect(.radians(.pi / 8))

                                Spacer()

                                HStack(alignment: .lastTextBaseline) {
                                    Text("Σ")
                                        .font(.caption)
                                    Text("\(roll.total)")
                                }
                            }
                            .padding(.horizontal)

                            HStack {
                                Spacer()

                                ForEach(roll.result, id: \.self) { side in
                                    Text("\(side)")
                                }

                                Spacer()
                            }
                        }
                        .frame(height: itemProxy.size.height)
                        .background(self.rollColor(for: roll))
                        .opacity(self.itemOpacity(listProxy: listProxy, itemProxy: itemProxy))
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .foregroundColor(.gray)
            .onAppear {
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().backgroundColor = UIColor.clear
            }
            .onDisappear {
                UITableView.appearance().separatorStyle = .singleLine
                UITableView.appearance().backgroundColor = UIColor.systemBackground
            }
            // without onTapGesture, onLongPressGesture will break scroll
            .onTapGesture {}
            .onLongPressGesture {
                if !self.rolls.all.isEmpty {
                    self.showingAction = true
                }
            }
        }
    }

    private func rollColor(for roll: Roll) -> Color {
        if colorScheme == .light {
            return index(for: roll) % 2 == 0 ?
                Color.green.opacity(0.05) :
                Color.green.opacity(0.15)
        }

        // dark scheme
        return index(for: roll) % 2 == 0 ?
            Color.white.opacity(0.125) :
            Color.white.opacity(0.075)
    }

    private func index(for roll: Roll) -> Int {
        rolls.all.firstIndex(where: { roll.id == $0.id }) ?? 0
    }

    private func itemOpacity(listProxy: GeometryProxy, itemProxy: GeometryProxy) -> Double {
        let itemMinY = itemProxy.frame(in: .global).minY
        let listMinY = listProxy.frame(in: .global).minY

        let positionInList = itemMinY - listMinY
        let ratio = positionInList / listProxy.size.height

        return 1 - Double(ratio * ratio)

        // other possible fading speeds
        //return 1 - Double(ratio)
        //return 0 - log(Double(ratio))
    }
}

struct RollsList_Previews: PreviewProvider {
    static let rolls = [
        Roll(dieSides: 20, result: [18, 15, 19, 17, 16, 19], total: 104),
        Roll(dieSides: 6, result: [1, 3, 4], total: 8),
        Roll(dieSides: 100, result: [95, 45, 21, 21, 32], total: 214),
        Roll(dieSides: 8, result: [4, 8, 3], total: 15),
        Roll(dieSides: 4, result: [1, 1, 3, 2, 4], total: 11),
        Roll(dieSides: 6, result: [4, 5, 2, 6, 3, 3], total: 23),
        Roll(dieSides: 6, result: [2, 1, 2, 6, 5, 4], total: 20),
        Roll(dieSides: 6, result: [5, 5, 5, 1, 4, 2], total: 22),
        Roll(dieSides: 6, result: [5, 3, 5, 4, 4], total: 21),
        Roll(dieSides: 20, result: [18, 15, 19, 17, 16, 19], total: 104),
        Roll(dieSides: 6, result: [1, 3, 4], total: 8),
        Roll(dieSides: 100, result: [95, 45, 21, 21, 32], total: 214),
        Roll(dieSides: 8, result: [4, 8, 3], total: 15),
        Roll(dieSides: 4, result: [1, 1, 3, 2, 4], total: 11),
        Roll(dieSides: 6, result: [4, 5, 2, 6, 3, 3], total: 23),
        Roll(dieSides: 6, result: [2, 1, 2, 6, 5, 4], total: 20),
        Roll(dieSides: 6, result: [5, 5, 5, 1, 4, 2], total: 22),
        Roll(dieSides: 6, result: [5, 3, 5, 4, 4], total: 21)
    ]

    class PreviewRolls: Rolls {
        @Published private(set) var all: [Roll]
        var allPublished: Published<[Roll]> { _all }
        var allPublisher: Published<[Roll]>.Publisher { $all }
        init(rolls: [Roll]) { self.all = rolls }
        func insert(roll: Roll) { }
        func removeAll() { }
    }

    static let previewRolls = PreviewRolls(rolls: rolls)

    static var previews: some View {
        Group {
            RollsList(rolls: previewRolls, showingAction: .constant(false))

            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                RollsList(rolls: previewRolls, showingAction: .constant(false)).environment(\.colorScheme, .dark)
            }
        }
    }
}
