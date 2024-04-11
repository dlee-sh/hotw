//
//  WindowUtil.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation
import Cocoa
import ApplicationServices

class WindowUtil {
    
    static func getFocusedWindowInfo() -> (windowID: CGWindowID?, description: String?)? {
        // Define the options for the window list
        let options = CGWindowListOption(arrayLiteral: .excludeDesktopElements, .optionOnScreenOnly)
        let windowListInfo = CGWindowListCopyWindowInfo(options, CGWindowID(0)) as NSArray? as? [[String: AnyObject]]
        
        // Find the focused window
        let focusedWindowInfo = windowListInfo?.first { windowInfo in
            // Check if the window is on the normal window layer and is not minimized
            let windowLayer = windowInfo[kCGWindowLayer as String] as? Int ?? Int.max
            let isOnscreen = windowInfo[kCGWindowIsOnscreen as String] as? Bool ?? false
            return windowLayer == 0 && isOnscreen
        }
        
        // Extract the window ID and description
        if let focusedWindowInfo = focusedWindowInfo {
            let windowID = CGWindowID(focusedWindowInfo[kCGWindowNumber as String] as? UInt32 ?? 0)
            let windowDescription = focusedWindowInfo[kCGWindowOwnerName as String] as? String ?? "Unknown"
            return (windowID, windowDescription)
        }
        
        return (nil, nil)
    }

    static func bringWindowToFront(windowID: CGWindowID) {
        print("attempting to bring window to the front")
        
        // Get a list of all windows
        let windowListInfo = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID) as NSArray? as? [[String: AnyObject]]
        
        // Find the application PID for the given window ID
        let appPID = windowListInfo?.first(where: { ($0[kCGWindowNumber as String] as? NSNumber)?.uint32Value == windowID })?[kCGWindowOwnerPID as String] as? pid_t
        print("app PID successfully found as \(appPID)")

        if let pid = appPID {
            // Create an AXUIElement representing the application with the given PID
            let appRef = AXUIElementCreateApplication(pid)
            print(appRef)
            
            // Get all windows for the application
            var value: AnyObject?
            let result = AXUIElementCopyAttributeValue(appRef, kAXWindowsAttribute as CFString, &value)

            if result == .success, let windows = value as? [AXUIElement] {
                for window in windows {
                    // Get the window ID of the current window
                    var windowIDValue: AnyObject?
                    let windowResult = AXUIElementCopyAttributeValue(window, kCGWindowNumber as CFString, &windowIDValue)
                    print(windowResult)
                    print(windowIDValue)
                    if windowResult != .success {
                        print("Unable to get window ID for a window")
                    } else {
                        print("Window ID retrieved: \(windowIDValue!)")
                    }
                    
                    if let windowIDNumber = windowIDValue as? NSNumber {
                        print("Window ID as NSNumber: \(windowIDNumber.uint32Value)")
                    } else {
                        print("Window ID value is not a number")
                    }
                    
                    if let windowIDNumber = windowIDValue as? NSNumber, windowIDNumber.uint32Value == windowID {
                        print("performing the action now.")
                        // Bring the window to the front
                        AXUIElementPerformAction(window, kAXRaiseAction as CFString)
                        break
                    } else {
                        print("Window ID does not match the given windowID")
                    }

                }
            }
        }
    }
}
