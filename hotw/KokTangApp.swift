//
//  KokTangApp.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import SwiftUI

// swift uses this decorator to denote the starting point of the app
// here we set up app structure, incl window and its content
@main
struct KokTangApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            Text("Placeholder")
        }
    }
}

