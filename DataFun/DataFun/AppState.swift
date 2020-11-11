//
//  AppState.swift
//  DataFun
//
//  Created by Serge Ostrowsky on 10/11/2020.
//

import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {

    @Published var rulesSelection: Int = UserDefaults.standard.integer(forKey: "rules selection")
    
    func updateValues() { // When the user changes a setting, the UserDefault is updated. Here, we align the AppState's value with what is now in the UserDefaults
        self.rulesSelection = UserDefaults.standard.integer(forKey: "rules selection")
        print("\nappState value (ruleSelection) updated from Appstate class func \"updateValues")
    }
}
