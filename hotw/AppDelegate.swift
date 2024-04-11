//
//  AppDelegate.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation
import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBar: NSStatusBar!
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    var popoverTransiencyMonitor: Any?
    var globalKeyMonitor: GlobalKeyMonitor?
    
    let viewModel = SharedViewModel()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create a popover
        let popover = NSPopover()
        popover.contentSize = NSSize(width: 360, height: 360)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: ContentView(viewModel: viewModel))
        self.popover = popover

        // Create the status bar item
        statusBar = NSStatusBar.system
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusBarItem.button {
            button.image = NSImage(systemSymbolName: "keyboard", accessibilityDescription: "Open Key Assigner")
            button.action = #selector(togglePopover(_:))
        }

        // Initialize and start the global key monitor
        globalKeyMonitor = GlobalKeyMonitor(viewModel: viewModel)
        globalKeyMonitor?.startMonitoring()
    }

    @objc func togglePopover(_ sender: AnyObject?) {
        if statusBarItem.button != nil {
            if popover.isShown {
                closePopover(sender)
            } else {
                openPopover(sender)
            }
        }
    }

    func openPopover(_ sender: AnyObject?) {
        if let button = statusBarItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            if popoverTransiencyMonitor == nil {
                popoverTransiencyMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) { [weak self] event in
                    self?.closePopover(sender)
                }
            }
        }
    }

    func closePopover(_ sender: AnyObject?) {
        if popoverTransiencyMonitor != nil {
            if let monitor = popoverTransiencyMonitor {
                NSEvent.removeMonitor(monitor)
            }
            popoverTransiencyMonitor = nil
        }
        popover.performClose(sender)
    }


    func applicationWillTerminate(_ aNotification: Notification) {
        // Stop the global key monitor when the application terminates
        globalKeyMonitor?.stopMonitoring()
    }
}

