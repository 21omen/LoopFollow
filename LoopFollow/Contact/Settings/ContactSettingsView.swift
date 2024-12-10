//
//  ContactSettingsView.swift
//  LoopFollow
//
//  Created by Jonas Björkert on 2024-12-10.
//  Copyright © 2024 Jon Fawcett. All rights reserved.
//

import SwiftUI
import Contacts

struct ContactSettingsView: View {
    @ObservedObject var viewModel: ContactSettingsViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Contact Integration")) {
                    Text("Add the contact named LoopFollowBG to your watch face to show the current BG value in real time.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 4)

                    Toggle("Enable Contact BG Updates", isOn: $viewModel.contactEnabled)
                        .toggleStyle(SwitchToggleStyle())
                        .onChange(of: viewModel.contactEnabled) { isEnabled in
                            if isEnabled {
                                requestContactAccess()
                            }
                        }
                }
            }
            .navigationBarTitle("Contact Settings", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func requestContactAccess() {
        let contactStore = CNContactStore()

        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            break
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { granted, error in
                DispatchQueue.main.async {
                    if !granted {
                        viewModel.contactEnabled = false
                        showAlert(title: "Access Denied", message: "Please allow access to Contacts in Settings to enable this feature.")
                    }
                }
            }
        case .denied:
            viewModel.contactEnabled = false
            showAlert(title: "Access Denied", message: "Access to Contacts is denied. Please go to Settings and enable Contacts access.")
        case .restricted:
            viewModel.contactEnabled = false
            showAlert(title: "Access Restricted", message: "Access to Contacts is restricted.")
        case .limited:
            viewModel.contactEnabled = false
            showAlert(title: "Access Limited", message: "Access to Contacts is limited.")
        @unknown default:
            viewModel.contactEnabled = false
            showAlert(title: "Error", message: "An unknown error occurred while checking Contacts access.")
        }
    }

    private func showAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert = true
    }
}
