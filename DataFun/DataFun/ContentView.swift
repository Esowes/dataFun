//
//  ContentView.swift
//  DataFun
//
//  Created by Serge Ostrowsky on 10/11/2020.
//

import SwiftUI
import Combine


struct ContentView: View {
    
    @StateObject var appState: AppState
    
    @State var modalViewCaller = 0 // used to present correct modalView
    @State var modalIsPresented = false // to present the modal views
    
    var body: some View {
        
        let stringArray = generateString() // func to generate string according to user's pref
        let recapString = stringArray[0]
        
        return ZStack {
                NavigationView {
                    VStack {
  // MARK: -  texts :
                    VStack {
                    Text(recapString)
                        .bold()
                        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                    } // end of VStack
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(UIColor.systemBlue), lineWidth: 4))
                        .padding()
                            } // END of VStack
            .onAppear() {
                self.modalViewCaller = 0
                print("\n\n*********** Content View onAppear triggered ! ************\n")
            }
            .navigationBarTitle("DataFun", displayMode: .inline)
            .navigationBarItems(leading: (
                Button(action: {
                    self.modalViewCaller = 1 // SettingsView
                    self.modalIsPresented = true
                }
                    ) {
                        Image(systemName: "gear")
                            .imageScale(.large)
                     }
            ))
        } // END of NavigationView
                .onAppear() {
                    self.appState.updateValues()
                }
        } // End of ZStack
        .sheet(isPresented: $modalIsPresented) {
            sheetContent(modalViewCaller: $modalViewCaller, appState: AppState())
                }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    // MARK: - struct sheetContent() :
      
      struct sheetContent: View {
          @Binding var modalViewCaller: Int // Binding to the @State modalViewCaller variable from ContentView
          @StateObject var appState: AppState
          
          var body: some View {
            if modalViewCaller == 1 { // The settings view is called
                SettingsView(appState: AppState())
                      .navigationViewStyle(StackNavigationViewStyle())
                      .onDisappear { self.modalViewCaller = 0 }
              } else if modalViewCaller == 2 { // the "other view" is called
                      OtherView()
                      .navigationViewStyle(StackNavigationViewStyle())
                      .onDisappear { self.modalViewCaller = 0 }
              }
          }
      } // END of func sheetContent
    
    // MARK: - generateString()
  func generateString() -> [String] {
        
        var recapString = "" // The recap string
        var myArray = [""]
    
        // We create the recap string :
    if UserDefaults.standard.integer(forKey: "rules selection") == 0 { // ICAO
              recapString = "User chose LEFT"
    } else if UserDefaults.standard.integer(forKey: "rules selection") == 1 { // AF Rules
            recapString = "User chose RIGHT"
        }
    
    myArray = [recapString]
    
            return myArray
    } // End of func generateString()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(appState: AppState())
    }
}
