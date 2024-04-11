//
//  SharedViewModel.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation

class SharedViewModel: ObservableObject {
    
    struct assignedWindow {
        var keyLetter: String
        var windowID: Int
        var windowDesc: String
    }
    
    @Published var assignedWindowDict: [Int: assignedWindow] = [
        12: assignedWindow(keyLetter: "q", windowID: 0, windowDesc: "unassigned"),
        13: assignedWindow(keyLetter: "w", windowID: 0, windowDesc: "unassigned"),
        14: assignedWindow(keyLetter: "e", windowID: 0, windowDesc: "unassigned"),
        15: assignedWindow(keyLetter: "r", windowID: 0, windowDesc: "unassigned"),
        0: assignedWindow(keyLetter: "a", windowID: 0, windowDesc: "unassigned"),
        1: assignedWindow(keyLetter: "s", windowID: 0, windowDesc: "unassigned"),
        2: assignedWindow(keyLetter: "d", windowID: 0, windowDesc: "unassigned"),
        3: assignedWindow(keyLetter: "f", windowID: 0, windowDesc: "unassigned"),
    ]
}
