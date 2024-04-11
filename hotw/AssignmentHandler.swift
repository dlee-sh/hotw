//
//  AssignmentHandler.swift
//  KokTang
//
//  Created by Daniel Lee on 27/2/2024.
//

import Foundation
import SwiftUI

class AssignmentHandler {
    private var assign: Bool = false
    let viewModel: SharedViewModel
    init(viewModel: SharedViewModel) {
        self.viewModel = viewModel
    }
    
    func changeAssignState() {
        assign = true
        print(assign)
    }
    
    func entryPoint(keyCode: Int, selectedWindowID: Int, selectedWindowDesc: String) {
        if assign {
            allocateKey(keyCode: keyCode, selectedWindowID: selectedWindowID, selectedWindowDesc: selectedWindowDesc)
            assign = false
        } else if (viewModel.assignedWindowDict[keyCode]!.windowID == 0) {
            print("trying to call unallocated window")
            return
        } else {
            bringToFront(keyCode: keyCode)
        }
    }
    
    private func allocateKey(keyCode: Int, selectedWindowID: Int, selectedWindowDesc: String) {
        viewModel.assignedWindowDict[keyCode]!.windowID = selectedWindowID
        viewModel.assignedWindowDict[keyCode]!.windowDesc = selectedWindowDesc
    }
    
    private func bringToFront(keyCode: Int) {
        let windowID = viewModel.assignedWindowDict[keyCode]!.windowID
        WindowUtil.bringWindowToFront(windowID: CGWindowID(windowID))
    }
    
}
