//
//  SettingView.swift
//  MyTests
//
//  Created by Timothy Hart on 2/7/23.
//

import SwiftUI

struct SettingsView: View {
    
    @State var serverAddress = ""
    @State var serverTestStatus = " "
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("campus") var campus: String = "Lancaster"
    
    @State var locations: [String] = ["Allendale", "Lancaster", "Sumter", "Walterboro", "Union"]
    
    @State private var peopleForLocation = [ReturnedPerson]()
    
    var body: some View {
        VStack {
            Text("Settings")
                .font(.largeTitle)
            Divider()
            Text("Enter the address of the server.")
            Text("Example: http://ipaddress or http://hostname")
                .font(.body)
            Text("HTTPS is not supported.")
                .padding()
            
            VStack {
                TextField("Server address", text: $serverAddress)
                    .textFieldStyle(.roundedBorder)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.never)
                    .onAppear() {
                        serverAddress = UserDefaults.standard.string(forKey: "baseServerAddress") ?? ""
                    }
                HStack {
                    Button("Test Connection") {
                        var urlString = serverAddress
                        urlString.append(":8181/test")
                        guard let url = URL(string: urlString) else {
                            serverTestStatus = "Bad URL"
                            return
                        }
                        let request = URLRequest(url: url)
                        Task {
                            do {
                                let (data, _) = try await URLSession.shared.data(for: request)
                                let status = String(data: data, encoding: .utf8)
                                if status == "ok" {
                                    serverTestStatus = "Connected"
                                } else {
                                    serverTestStatus = "Could not connect to the server"
                                }
                            } catch {
                                print(error)
                                serverTestStatus = "Could not connect to the server"
                            }
                        }
                    }
                    Text(serverTestStatus)
                }
                Divider()
                Text("Choose Location")
                Picker("Location", selection: $campus) {
                    ForEach(locations, id: \.self) { item in
                        Text(item)
                    }
                }
                
            }
            .padding()
            
            Divider()
                .padding()
            Button("GetUsers") {
                Task {
                    await getUsersForLocation()
                }
            }
            List {
                ForEach(peopleForLocation, id: \.self) { person in
                    Text("\(person.firstName) \(person.lastName) - \(person.email)")
                        .swipeActions {
                                    Button(role: .destructive) {
                                        guard let foundPerson = peopleForLocation.first(where: {$0.email == person.email}) else { return }
                                        
                                        Task {
                                            let person = try await DataService.shared.findPersonWith(email: foundPerson.email)
                                            if let foundPerson = person {
                                                if foundPerson.email == "" {
                                                    print("No user found")
                                                    //No person was found so create a new Person with only an email address
                                                    
                                                } else {
                                                    print("User Found")
                                                    //Person found so create a new person with the ReturnedPerson object
                                                    // CAM - added active bool 5/5/23
                                                    
                                                    let newPerson = Person(firstName: foundPerson.firstName, lastName: foundPerson.lastName, email: foundPerson.email, username: foundPerson.username, role: foundPerson.role, reasonForVisit: foundPerson.reasonForVisit, campus: campus, date: Date())
                                                    //, active:foundPerson.active)
                                                    
                                                    await DataService.shared.signOut(person: newPerson)
                                                    
                                                }
                                            }}
                                    } label: {
                                        Text("Sign out")
                                    }
                                }
                }
                
                //.onDelete(perform: onDelete)
            }
            Button("Save") {
                DataService.shared.setAddress(baseURL: serverAddress)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
    
    func getUsersForLocation() async {
        let url = URL(string: "\(serverAddress):8181/allSignedInForLocation/\(campus)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"

        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            var decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let string = String(data: data, encoding: .utf8)
            
            peopleForLocation = try decoder.decode([ReturnedPerson].self, from: data)
            
        } catch {
            if let decodingError = error as? DecodingError {
                    print("Decoding error: \(decodingError)")
                } else {
                    print("Error: \(error.localizedDescription)")
                }
        }
    }
    
    func signOutUser(person: Person) {
        guard let foundPerson = peopleForLocation.first(where: {$0.email == person.email}) else { return }
        
        Task {
            let person = try await DataService.shared.findPersonWith(email: foundPerson.email)
            if let foundPerson = person {
                if foundPerson.email == "" {
                    print("No user found")
                    //No person was found so create a new Person with only an email address
                    
                } else {
                    print("User Found")
                    //Person found so create a new person with the ReturnedPerson object
                    // CAM - added active bool 5/5/23
                    
                    let newPerson = Person(firstName: foundPerson.firstName, lastName: foundPerson.lastName, email: foundPerson.email, username: foundPerson.username, role: foundPerson.role, reasonForVisit: foundPerson.reasonForVisit, campus: campus, date: Date())
                    //, active:foundPerson.active)
                    
                    await DataService.shared.signOut(person: newPerson)
                    
                }
            }}
    }
    
    private func onDelete(offsets: IndexSet) {
        guard let place = offsets.first else { return }
        let person = peopleForLocation[place]
        
        Task {
            let person = try await DataService.shared.findPersonWith(email: person.email)
            if let foundPerson = person {
                if foundPerson.email == "" {
                    print("No user found")
                    //No person was found so create a new Person with only an email address
                    
                } else {
                    print("User Found")
                    //Person found so create a new person with the ReturnedPerson object
                    // CAM - added active bool 5/5/23
                    
                    let newPerson = Person(firstName: foundPerson.firstName, lastName: foundPerson.lastName, email: foundPerson.email, username: foundPerson.username, role: foundPerson.role, reasonForVisit: foundPerson.reasonForVisit, campus: campus, date: Date())
                    //, active:foundPerson.active)
                    
                    await DataService.shared.signOut(person: newPerson)
                    
                }
            }}
         
    }}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


