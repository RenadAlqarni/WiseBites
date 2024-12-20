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
    @State private var cameraHandler: CameraHandler? = nil
    
    var body: some View {
        if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
            ZStack(alignment: .bottom) {
                DataScannerRepresentable(
                    shouldStartScanning: $isShowingScanner,
                    scannedText: $scannedText,
                    dataToScanFor: [.barcode(symbologies: [.qr])]
                )

                VStack {
                    Spacer()

                    // Scanned Text Display
                    Text(scannedText)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .cornerRadius(8)
                        .padding(.bottom, 50)

                    // Buttons: Flash, Lamp, and Take a Picture
                    HStack {
                        // Lamp Button
                        Button(action: {
                            isEducationalViewPresented = true
                        }) {
                            Image(systemName: "lightbulb.fill")
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
                        Button(action: {
                            capturePhoto()
                        }) {
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
                        }
                        .shadow(radius: 4)

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
            }
        } else if !DataScannerViewController.isSupported {
            Text("It looks like this device doesn't support the DataScannerViewController")
        } else {
            Text("It appears your camera may not be available")
        }
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

    private func capturePhoto() {
        if cameraHandler == nil {
            cameraHandler = CameraHandler()
        }
        cameraHandler?.capturePhoto()
    }
}

class CameraHandler: NSObject, AVCapturePhotoCaptureDelegate {
    private var captureSession: AVCaptureSession!
    private var photoOutput: AVCapturePhotoOutput!

    override init() {
        super.init()
        configureCamera()
    }

    private func configureCamera() {
        captureSession = AVCaptureSession()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            print("Failed to configure camera")
            return
        }
        photoOutput = AVCapturePhotoOutput()

        captureSession.beginConfiguration()
        if captureSession.canAddInput(input) {
            captureSession.addInput(input)
        }
        if captureSession.canAddOutput(photoOutput) {
            captureSession.addOutput(photoOutput)
        }
        captureSession.commitConfiguration()

        captureSession.startRunning()
    }

    func capturePhoto() {
        guard let photoOutput = photoOutput else { return }
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }

    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil, let photoData = photo.fileDataRepresentation() else {
            print("Error capturing photo: \(String(describing: error))")
            return
        }
        // Handle the captured photo
        savePhotoToLibrary(data: photoData)
    }

    private func savePhotoToLibrary(data: Data) {
        let image = UIImage(data: data)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        print("Photo saved to library!")
    }
}


#Preview {
    CameraView()
}
