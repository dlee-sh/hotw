//
//  ContentView.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel: SharedViewModel
    
    var body: some View {
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    KeyButton(key: "q", assignedWindow: viewModel.assignedWindowDict[12]?.windowDesc ?? "unassigned")
                    KeyButton(key: "w", assignedWindow: viewModel.assignedWindowDict[13]?.windowDesc ?? "unassigned")
                    KeyButton(key: "e", assignedWindow: viewModel.assignedWindowDict[14]?.windowDesc ?? "unassigned")
                    KeyButton(key: "r", assignedWindow: viewModel.assignedWindowDict[15]?.windowDesc ?? "unassigned")
                }
                HStack(spacing: 20) {
                    KeyButton(key: "a", assignedWindow: viewModel.assignedWindowDict[0]?.windowDesc ?? "unassigned")
                    KeyButton(key: "s", assignedWindow: viewModel.assignedWindowDict[1]?.windowDesc ?? "unassigned")
                    KeyButton(key: "d", assignedWindow: viewModel.assignedWindowDict[2]?.windowDesc ?? "unassigned")
                    KeyButton(key: "f", assignedWindow: viewModel.assignedWindowDict[3]?.windowDesc ?? "unassigned")
                }
                .padding(.bottom)
                HStack(spacing: 20) {
                    VStack(spacing: 20){
                        Text("[ z ]")
                        Text("assign").font(.caption)
                    }
                    VStack(spacing: 20){
                        Text("[ hyper ]")
                        Text("activate").font(.caption)
                    }
                }
                Text("Koktang v0.1 | © https://dlee.sh").font(.footnote)
            }.padding()
        }
}
