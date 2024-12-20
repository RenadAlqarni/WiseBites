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
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                    InstructionCard(iconName: "smiley", iconColor: .green, title: "Age group", subtitle: "All ages")
                    InstructionCard(iconName: "thermometer", iconColor: .red, title: "Temperature", subtitle: "25°C")
                    InstructionCard(iconName: "tray.fill", iconColor:  Color("LightBlue"), title: "Shelf Time", subtitle: "18 Months")
                    InstructionCard(iconName: "exclamationmark.triangle", iconColor: .orange, title: "Warnings", subtitle: "Be cautious when handling chocolate after heating.")
                }
                .padding(.horizontal)
            }
            .padding(.vertical, 20)
            .navigationTitle("Instructions")
            .tint(Color.black)
        }
    }
}

// Reusable Card View
struct InstructionCard: View {
    let iconName: String
    let iconColor: Color
    let title: String
    let subtitle: String

    @State private var isExpanded = false  // Track if subtitle is expanded

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
                .lineLimit(isExpanded ? nil : 1)  // Show only one line or expand
                .truncationMode(.tail)  // Ensure text is truncated when it's too long
                .padding(.horizontal)
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()  // Toggle the expansion when clicked
                    }
                }
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity, minHeight: 180) // Fixed height (adjust as needed)
        .background(Color.orange.opacity(0.2))
        .cornerRadius(15)
    }
}

#Preview {
    InstructionsView()
}
