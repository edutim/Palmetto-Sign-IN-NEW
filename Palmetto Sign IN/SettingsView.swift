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
            Button("Save") {
                DataService.shared.setAddress(baseURL: serverAddress)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
