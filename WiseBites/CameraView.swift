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
    @State private var isShowingScanner = true
    @State private var recognizedItems: [RecognizedItem] = []
    @State private var isFlashOn = false
    @State private var isEducationalViewPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
                    // Barcode scanner view
                    DataScannerView(
                        recognizedItems: $recognizedItems,
                        recognizedDataType: .barcode(),
                        recognizesMultipleItems: true
                    )
                    .edgesIgnoringSafeArea(.all)

                    VStack {
                        Spacer()

                        // Recognized Text Display
                        ScrollView {
                            if !recognizedItems.isEmpty {
                                ForEach(recognizedItems, id: \.id) { item in
                                    if case let .barcode(barcode) = item {
                                        Text(barcode.payloadStringValue ?? "Unknown Barcode")
                                            .padding()
                                            .background(Color.white)
                                            .foregroundColor(.black)
                                            .cornerRadius(8)
                                            .padding(.horizontal)
                                    }
                                }
                            } else {
                                Text("Point the camera at a barcode to scan")
                                    .padding()
                                    .background(Color.white)
                                    .foregroundColor(.gray)
                                    .cornerRadius(8)
                                    .padding(.horizontal)
                            }
                        }
                        .frame(height: 120)

                        // Action Buttons: Flash, Educational, and Capture
                        HStack {
                            // Educational View Button
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

                            // Capture Button (Navigation to ClassificationView)
                            NavigationLink(destination: ClassificationView()) {
                                ZStack {
                                    Circle()
                                        .stroke(Color.green, lineWidth: 4)
                                        .frame(width: 80, height: 80)

                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 70, height: 70)
                                }
                                .shadow(radius: 4)
                            }

                            Spacer()

                            // Flash Toggle Button
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
            .navigationBarHidden(true)
            .tint(Color.black)
        }
        .edgesIgnoringSafeArea(.all)
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
