//
//  Backend.swift
//  NOBEMedDeviceAK
//
//  Created by Anshul Kaushik on 7/29/22.
//

import UIKit
import Amplify
import AmplifyPlugins


class Backend {
    static let shared = Backend()
    static func initialize() -> Backend {
        return .shared
    }
    private init () {
      // initialize amplify
        do {
           try Amplify.add(plugin: AWSCognitoAuthPlugin())
           try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
           try Amplify.configure()
           print("Initialized Amplify")
        } catch {
           print("Could not initialize Amplify: \(error)")
        }
        _ = Amplify.Hub.listen(to: .auth) { (payload) in

            switch payload.eventName {

            case HubPayload.EventName.Auth.signedIn:
                print("==HUB== User signed In, update UI")
                self.updateUserData(withSignInStatus: true)

            case HubPayload.EventName.Auth.signedOut:
                print("==HUB== User signed Out, update UI")
                self.updateUserData(withSignInStatus: false)

            case HubPayload.EventName.Auth.sessionExpired:
                print("==HUB== Session expired, show sign in UI")
                self.updateUserData(withSignInStatus: false)

            default:
                //print("==HUB== \(payload)")
                break
            }
        }
         
        // let's check if user is signedIn or not
         _ = Amplify.Auth.fetchAuthSession { (result) in
             do {
                 let session = try result.get()
                        
        // let's update UserData and the UI
             self.updateUserData(withSignInStatus: session.isSignedIn)
                        
             } catch {
                  print("Fetch auth session failed with error - \(error)")
            }
        } 
    }
    public func signIn() {

        _ = Amplify.Auth.signInWithWebUI(presentationAnchor: UIApplication.shared.windows.first!) { result in
            switch result {
            case .success(_):
                print("Sign in succeeded")
            case .failure(let error):
                print("Sign in failed \(error)")
            }
        }
    }
    
    func queryDisps() {

            _ = Amplify.API.query(request: .list(ContainerData.self)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let dispsData):
                        print("Successfully retrieved list of thing")

                        // convert an array of NoteData to an array of Note class instances
                        for d in dispsData {
                            let disp = Dispenser.init(from: d)
                            DispatchQueue.main.async() {
                                UserData.shared.Disps.append(disp)
                            }
                        }

                    case .failure(let error):
                        print("Can not retrieve result : error  \(error.errorDescription)")
                    }
                case .failure(let error):
                    print("Can not retrieve Notes : error \(error)")
                }
            }
        }
    // signout
    public func signOut() {

        _ = Amplify.Auth.signOut() { (result) in
            switch result {
            case .success:
                print("Successfully signed out")
            case .failure(let error):
                print("Sign out failed with error \(error)")
            }
        }
    }
    
    func updateUserData(withSignInStatus status : Bool) {
        DispatchQueue.main.async() {
                let userData : UserData = .shared
                userData.isSignedIn = status

                // when user is signed in, query the database, otherwise empty our model
                if status {
                    self.queryDisps()
                } else {
                    userData.Disps = []
                }
            }
    }
    // change our internal state, this triggers an UI update on the main thread
    
    func createDispenser(disps: Dispenser) {

            // use note.data to access the NoteData instance
            _ = Amplify.API.mutate(request: .create(disps.data)) { event in
                switch event {
                case .success(let result):
                    switch result {
                    case .success(let data):
                        print("Successfully created note: \(data)")
                    case .failure(let error):
                        print("Got failed result with \(error.errorDescription)")
                    }
                case .failure(let error):
                    print("Got failed event with error \(error)")
                }
            }
        }
}
