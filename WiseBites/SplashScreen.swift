//
//  Untitled.swift
//  WiseBites
//
//  Created by Renad Alqarni on 20/12/2024.
//

import SwiftUI


struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            ClassificationView()
        } else {
            VStack {
                VStack {
                    Image("AppLogo")
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview{
    SplashScreenView()
}
