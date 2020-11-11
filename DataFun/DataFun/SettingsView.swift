//
//  SettingsView.swift
//  DataFun
//
//  Created by Serge Ostrowsky on 10/11/2020.
//

import SwiftUI
import Combine


struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode // in order to dismiss the Sheet

    @StateObject var appState: AppState
    @State private var rulesSelection = UserDefaults.standard.integer(forKey: "rules selection") // 0 is LEFT, 1 is RIGHT

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
        Text("Choose a setting below")
            .padding()
        Picker("", selection: $rulesSelection) {
                    Text("LEFT").tag(0)
                    Text("RIGHT").tag(1)
                }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
                Spacer()
            }
            .navigationBarItems(
                leading:
                Button("Done") {
                        self.saveDefaults() // We set the UserDefaults
                        self.presentationMode.wrappedValue.dismiss() // This dismisses the view
                 //   self.modalViewCaller = 0
                }
            ) // END of NavBarItems
        } // END of NavigationBiew
    } // END of body
    
    func saveDefaults() {
        
        UserDefaults.standard.set(rulesSelection, forKey: "rules selection")
        
        self.appState.updateValues() // This is a func from the AppState class that will align the appState's value to the UserDefaults
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(appState: AppState())
    }
}
