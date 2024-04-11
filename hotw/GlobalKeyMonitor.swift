//
//  GlobalKeyMonitor.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation
import Cocoa

class GlobalKeyMonitor {
    private var eventMonitor: Any?
    let viewModel: SharedViewModel
    init(viewModel: SharedViewModel) {
        self.viewModel = viewModel
    }
    
    func startMonitoring() {
        let assignmentHandler = AssignmentHandler(viewModel: viewModel)
        let mask = NSEvent.EventTypeMask.keyDown // Monitor for key down events
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: mask) { event in
            self.handleGlobalEvent(event, assignmentHandler: assignmentHandler)
        }
    }

    func stopMonitoring() {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }
    }

    private func handleGlobalEvent(_ event: NSEvent, assignmentHandler: AssignmentHandler) {
        
        let hyperKeyFlags: NSEvent.ModifierFlags = [
            .control,
            .option,
            .command,
            .shift
        ]
        
        let pressedFlags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
        
        if pressedFlags == hyperKeyFlags {
            switch event.keyCode {
            case 12, 13, 14, 15, 0, 1, 2, 3:
                if let (focusedWindowID, focusedWindowDesc) = WindowUtil.getFocusedWindowInfo() {
                    assignmentHandler.entryPoint(keyCode: Int(event.keyCode), selectedWindowID: Int(focusedWindowID!), selectedWindowDesc: String(focusedWindowDesc!))
                } else {
                    print("no focused window found")
                }
            case 6:
                assignmentHandler.changeAssignState()
            default:
                break
            }
        }
    }
}

