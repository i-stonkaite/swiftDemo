//
//  ContentView.swift
//  demoApp
//
//  Created by Ieva Administrator on 5/11/23.

import SwiftUI
import Foundation
import OSLog

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

    struct BlueButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .foregroundColor(.white)
                .clipShape(Capsule())
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

    struct ContentView: View {
        @State private var showingAlert = false;
        
        @State private var isAuthenticating = false
        @State private var username = ""
        @State private var password = ""
        @State private var isImage2 = false;
                
        class PasswordGenerator {
            let word = "password"
            let randomInt = Int.random(in: 1...10)
            
            func createRandomPassword() -> String {
                return word + String(randomInt)
            }
        }

        let newPassword = PasswordGenerator().createRandomPassword()
        
        var body: some View {
            ZStack{
                Color(.black)
                    .ignoresSafeArea()
                VStack {

                    Section {
                        Text("The Demo App")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                    }

                    if isImage2 {
                        Image("appDown")
                            .resizable()
                            .aspectRatio(contentMode: .fit)

                    } else {
                        Image("devMyApp")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    HStack {
                        Button(action: {
                            debugPrint("Debug: 'Learn more' has been clicked");
                            os_log("Info log: 'Learn more' has been clicked")
                            
                            showingAlert = true;
                        })
                        {
                            Text("Learn more")
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Hey!"),
                                message: Text("You're about to leave this app!"),
                                primaryButton: .default(Text("Cancel")),
                                secondaryButton: .default(Text("Open"), action: {
                                    if let url = URL(string: "https://www.youtube.com/watch?v=jVy0JWX5XEY&ab_channel=AdultSwim") {
                                        UIApplication.shared.open(url)
                                    }
                                })
                            )
                        }
                        .buttonStyle(GrowingButton())
                        .font(.callout)
                        .fontWeight(.semibold)
                        // ------------------------------------------------------------
                        

                        Button(action: {
                            debugPrint("Debug: 'Get error log' has been clicked");
                            os_log("Error log: 'Get error log' has been clicked", type: .error)
                            })
                        {
                            Text("Get error log")
                        }
                        .buttonStyle(GrowingButton())
                        .font(.callout)
                        .fontWeight(.semibold)
            
                        }
                    
                        Section {
                            Button(action: {
                                debugPrint("Debug: 'I want to develop the app' has been clicked");
                                os_log("Info log: 'I want to develop the app' has been clicked")
                                os_log("Your password: %@", log: .default, type: .error, newPassword)
                            
                                isAuthenticating = true
                         })
                        {
                            Text("I want to develop the app")
                        }
                        .alert("Enter password", isPresented: $isAuthenticating) {
                            
                            SecureField("Password", text: $password)
                            Button("OK", action: {
                                if password == newPassword {
                                    self.isImage2.toggle()
                                }
                            })
                            Button("Cancel", role: .cancel) { }
                        } message: {
                            Text("You need a password to develop an app")
                        }
                        .buttonStyle(GrowingButton())
                        .font(.callout)
                        .fontWeight(.semibold)
                    }

                    Section {
                        Text("**Disclaimer!** *Do not develop my app*")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                    }
                }
            }
        }
    }

