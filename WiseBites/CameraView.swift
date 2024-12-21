//
//  Untitled.swift
//  WiseBites
//
//  Created by Renad Alqarni on 21/12/2024.
//

import SwiftUI
import VisionKit
import AVFoundation

struct CameraView: View {
    @State var isShowingScanner = true
    @State private var scannedText = ""
    @State private var isFlashOn = false
    @State private var isEducationalViewPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    // Full-screen camera preview
                    DataScannerRepresentable(
                        shouldStartScanning: $isShowingScanner,
                        scannedText: $scannedText,
                        dataToScanFor: [.barcode(symbologies: [.qr])]
                    )
                    .edgesIgnoringSafeArea(.all) // Ensures the camera takes up the full screen

                    VStack {
                        Spacer()

                        // Scanned Text Display
//                        Text(scannedText)
//                            .padding()
//                            .background(Color.white)
//                            .foregroundColor(.black)
//                            .cornerRadius(8)
//                            .padding(.bottom, 50)

                        // Buttons: Flash, Lamp, and Take a Picture
                        HStack {
                            // Lamp Button
                            Button(action: {
                                isEducationalViewPresented = true
                            }) {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.yellow)
                                    .padding()
                                    .background(Color.black.opacity(0.6))
                                    .clipShape(Circle())
                            }
                            .sheet(isPresented: $isEducationalViewPresented) {
                                EducationalView()
                            }

                            Spacer()

                            // Take a Picture Button
                            NavigationLink(destination: ClassificationView()) {
                                ZStack {
                                    // Outer green circle
                                    Circle()
                                        .stroke(Color.green, lineWidth: 4) // Adjust thickness if needed
                                        .frame(width: 80, height: 80) // Slightly larger for the outline

                                    // Inner white circle
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 70, height: 70) // Size of the main button
                                }
                                .shadow(radius: 4)
                            }

                            Spacer()

                            // Flash Button
                            Button(action: {
                                toggleFlashlight()
                            }) {
                                Image(systemName: isFlashOn ? "bolt.fill" : "bolt.slash.fill")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(isFlashOn ? Color.yellow : Color.black.opacity(0.6))
                                    .clipShape(Circle())
                            }
                        }
                        .padding([.horizontal, .bottom], 20)
                    }
                } else if !DataScannerViewController.isSupported {
                    Text("It looks like this device doesn't support the DataScannerViewController")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text("It appears your camera may not be available")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationBarHidden(true) // Hide navigation bar to avoid overlaps
            .tint(Color.black) // Set custom tint color
        }
        .edgesIgnoringSafeArea(.all) // Ignore safe areas to ensure full-screen
    }

    private func toggleFlashlight() {
        guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
        do {
            try device.lockForConfiguration()
            if device.torchMode == .on {
                device.torchMode = .off
                isFlashOn = false
            } else {
                try device.setTorchModeOn(level: 1.0)
                isFlashOn = true
            }
            device.unlockForConfiguration()
        } catch {
            print("Flashlight could not be used: \(error.localizedDescription)")
        }
    }
}


#Preview {
    CameraView()
}
