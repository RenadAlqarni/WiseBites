//
//  WiseBitesApp.swift
//  WiseBites
//
//  Created by Renad Alqarni on 20/12/2024.
//

import SwiftUI

@main
struct WiseBitesApp: App {
    @StateObject private var vm = AppViewModel()
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(vm)
                .task {
                    await vm.requestDataScannerAccessStatus()
                }
        }
    }
}
