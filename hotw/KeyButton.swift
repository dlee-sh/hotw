//
//  KeyButton.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation
import SwiftUI

struct KeyButton: View {
    var key: String
    var assignedWindow: String
    
    var body: some View {
        VStack {
            Text("[ \(key) ]")
                .padding()
            Text(assignedWindow)
                .font(.caption)
        }
    }
}
