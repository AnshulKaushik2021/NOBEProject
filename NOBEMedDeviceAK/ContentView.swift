//
//  ContentView.swift
//  NOBEMedDeviceAK
//
//  Created by Anshul Kaushik on 7/29/22.
//

import SwiftUI

// singleton object to store user data
class UserData : ObservableObject {
    private init() {}
    static let shared = UserData()

    @Published var Disps : [Dispenser] = []
    @Published var isSignedIn : Bool = false
}

// the data class to represents Notes
class Dispenser : Identifiable, ObservableObject {
    var containernum: String
    var containerstatus: String
    var lastDispensedDate: Int
    var lastDispensedTime: Int

    init(containernum: String, containerstatus: String, lastDispensedDate: Int, lastDispensedTime: Int ) {
        self.containernum = containernum
        self.containerstatus = containerstatus
        self.lastDispensedDate = lastDispensedDate
        self.lastDispensedTime = lastDispensedTime
    }
    convenience init(from data: ContainerData) {
        self.init(containernum: data.containernum, containerstatus: data.containerstatus,
                  lastDispensedDate: data.lastDispensedDate, lastDispensedTime: data.lastDispensedTime)
     
        // store API object for easy retrieval later
        self._data = data
    }

    fileprivate var _data : ContainerData?

    // access the privately stored NoteData or build one if we don't have one.
    var data : ContainerData {

        if (_data == nil) {
            _data = ContainerData(containernum: self.containernum,
                                  containerstatus: self.containerstatus,
                                  lastDispensedDate: self.lastDispensedDate,
                                  lastDispensedTime: self.lastDispensedTime)
        }

        return _data!
    }
 
}
struct ContainerOne: View {
    var body: some View {
        Button(action: {editOne() }){
                Text("Disp 1")
                    .font(.largeTitle)
       
        }
        
    }
}
struct ContainerTwo: View {
    var body: some View {
        Button(action: { editTwo() }){
                Text("Disp 2")
                    .font(.largeTitle)
       
        }
        
    }
}
struct ContainerThree: View {
    var body: some View {
        Button(action: { editThree() }){
                Text("Disp 3")
                    .font(.largeTitle)
       
        }
        
    }
}
struct ContainerFour: View {
    var body: some View {
        Button(action: { editFour() }){
                Text("Disp 4")
                    .font(.largeTitle)
       
        }
        
    }
}

       // this is the main view of our app,
       // it is made of a Table with one line per Note
       struct ContentView: View {
           @ObservedObject private var userData: UserData = .shared
           @State var showCreateDisp = false

           @State var num : String        = "01"
           @State var status : String = "working"
           @State var date : Int       = 0
           @State var time : Int       = 1
               var body: some View {
                   ZStack {
                           if (userData.isSignedIn) {
                               NavigationView {
                                   List {
                                       ContainerOne()
                                       ContainerTwo()
                                       ContainerThree()
                                       ContainerFour()
                                   }
                                   .navigationBarTitle(Text("Top"))
                                   .navigationBarItems(leading: SignOutButton(),
                                                           trailing: Button(action: {
                                           self.showCreateDisp.toggle()
                                       }) {
                                           Image(systemName: "plus")
                                       })
                                   }.sheet(isPresented: $showCreateDisp) {
                                       AddDispView(isPresented: self.$showCreateDisp, userData: self.userData)
                               }
                           } else {
                               SignInButton()
                           }
                       }
                  
               }
               
               
           }
struct SignInButton: View {
    var body: some View {
        Button(action: { Backend.shared.signIn() }){
            HStack {
                Image(systemName: "person.fill")
                    .scaleEffect(1.5)
                    .padding()
                Text("Sign In")
                    .font(.largeTitle)
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(30)
        }
    }
}

struct SignOutButton : View {
    var body: some View {
        Button(action: { Backend.shared.signOut() }) {
                Text("Sign Out")
        }
    }
}
// this is use to preview the UI in Xcode
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let _ = prepareTestData()

        return ContentView()
    }
}
struct AddDispView: View {
    @Binding var isPresented: Bool
    var userData: UserData
    @State var num : String        = "01"
    @State var status : String = "working"
    @State var date : Int       = 0
    @State var time : Int       = 1
    var body: some View {
        Form {

            Section(header: Text("TEXT")) {
                TextField("Name", text: $num)
                TextField("Name", text: $status)
            }

            Section {
                Button(action: {
                    self.isPresented = false
                    let containerData = ContainerData(
                        containernum: "01", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1
                    )
                    let disp = Dispenser(from: containerData)

                    // asynchronously store the note (and assume it will succeed)
                    Backend.shared.createDispenser(disps: disp)

                    // add the new note in our userdata, this will refresh UI
                    self.userData.Disps.append(disp)
                    
                    // Dispenser 2
                    
                    self.isPresented = false
                    let containerData2 = ContainerData(
                        containernum: "02", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1
                    )
                    let disp2 = Dispenser(from: containerData2)

                    // asynchronously store the note (and assume it will succeed)
                    Backend.shared.createDispenser(disps: disp2)

                    // add the new note in our userdata, this will refresh UI
                    self.userData.Disps.append(disp2)
                    
                    // Dispenser 3
                    
                    self.isPresented = false
                    let containerData3 = ContainerData(
                        containernum: "03", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1
                    )
                    let disp3 = Dispenser(from: containerData3)

                    // asynchronously store the note (and assume it will succeed)
                    Backend.shared.createDispenser(disps: disp3)

                    // add the new note in our userdata, this will refresh UI
                    self.userData.Disps.append(disp3)
                    
                    // Dispenser 4
                    
                    self.isPresented = false
                    let containerData4 = ContainerData(
                        containernum: "04", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1
                    )
                    let disp4 = Dispenser(from: containerData4)

                    // asynchronously store the note (and assume it will succeed)
                    Backend.shared.createDispenser(disps: disp4)

                    // add the new note in our userdata, this will refresh UI
                    self.userData.Disps.append(disp4)
                }) {
                    Text("One and Done baby")
                }
            }
        }
    }
}

// this is a test data set to preview the UI in Xcode
func prepareTestData() -> UserData {
    let userData = UserData.shared

    let c1 = Dispenser(containernum: "01", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1)
    let c2 = Dispenser(containernum: "02", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1)
    let c3 = Dispenser(containernum: "03", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1)
    let c4 = Dispenser(containernum: "04", containerstatus: "Not dispensed", lastDispensedDate: 1, lastDispensedTime: 1)
    userData.Disps = [ c1,c2,c3,c4 ]
    return userData
}
func editOne(){
    let userData = UserData.shared
    let conData = ContainerData(
        containernum: "01", containerstatus: "Dispensed", lastDispensedDate: 1, lastDispensedTime: 1
    )
    let disp4 = Dispenser(from: conData)

    // asynchronously store the note (and assume it will succeed)
    Backend.shared.createDispenser(disps: disp4)

    // add the new note in our userdata, this will refresh UI
    userData.Disps.append(disp4)
}
func editTwo(){
    let userData = UserData.shared
    let conData = ContainerData(
        containernum: "02", containerstatus: "Dispensed", lastDispensedDate: 1, lastDispensedTime: 1
    )
    let disp4 = Dispenser(from: conData)

    // asynchronously store the note (and assume it will succeed)
    Backend.shared.createDispenser(disps: disp4)

    // add the new note in our userdata, this will refresh UI
    userData.Disps.append(disp4)
}
func editThree(){
    let userData = UserData.shared
    let conData = ContainerData(
        containernum: "03", containerstatus: "Dispensed", lastDispensedDate: 1, lastDispensedTime: 1
    )
    let disp4 = Dispenser(from: conData)

    // asynchronously store the note (and assume it will succeed)
    Backend.shared.createDispenser(disps: disp4)

    // add the new note in our userdata, this will refresh UI
    userData.Disps.append(disp4)
}
func editFour(){
    let userData = UserData.shared
    let conData = ContainerData(
        containernum: "04", containerstatus: "Dispensed", lastDispensedDate: 1, lastDispensedTime: 1
    )
    let disp4 = Dispenser(from: conData)

    // asynchronously store the note (and assume it will succeed)
    Backend.shared.createDispenser(disps: disp4)

    // add the new note in our userdata, this will refresh UI
    userData.Disps.append(disp4)
}
