//
//  Untitled.swift
//  WiseBites
//
//  Created by Renad Alqarni on 20/12/2024.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    InstructionCard(iconName: "smiley", iconColor: .green, title: "Age group", subtitle: "All ages")
                    InstructionCard(iconName: "thermometer", iconColor: .red, title: "Temperature", subtitle: "25°C")
                    InstructionCard(iconName: "tray.fill", iconColor:  Color("LightBlue"), title: "Shelf Time", subtitle: "18 Months")
                    InstructionCard(iconName: "exclamationmark.triangle", iconColor: .orange, title: "Warnings", subtitle: "")
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 20)
            .navigationTitle("Instructions")
        }
    }
}

// Reusable Card View
struct InstructionCard: View {
    let iconName: String
    let iconColor: Color
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 10) {
            // Icon
            Image(systemName: iconName)
                .font(.system(size: 40))
                .foregroundColor(iconColor)
                .padding()
                .background(Circle().fill(iconColor.opacity(0.1)))

            // Title and Subtitle
            Text(title)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.black)

            Text(subtitle)
                .font(.system(size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.orange.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    InstructionsView()
}
