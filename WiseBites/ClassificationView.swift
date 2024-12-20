//
//  ContentView.swift
//  WiseBites
//
//  Created by Renad Alqarni on 20/12/2024.
//

import SwiftUI

struct ClassificationView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("Happy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                VStack(spacing: 5) {
                    Text("The food is ")
                        .font(.system(size: 34, weight: .semibold)) +
                    Text("healthy")
                        .foregroundColor(.green)
                        .font(.system(size: 34, weight: .semibold)) +
                    Text("!")
                        .font(.system(size: 34, weight: .semibold))
                    
                    Text("Would you like to see the consumption instruction?")
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: InstructionsView()) {
                    Text("Show The Consumption Instructions")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
            }
            .padding(.vertical, 40)
            
        }
        .tint(Color.black)
    }
}


#Preview {
    ClassificationView()
}
