//
//  Untitled.swift
//  WiseBites
//
//  Created by Renad Alqarni on 20/12/2024.
//

import SwiftUI

struct EducationalView: View {
    let educationalLinks: [(icon: String, color: Color, title: String, url: String)] = [
        ("leaf", .green, "ChooseMyPlate for Kids", "https://www.choosemyplate.gov/"),
        ("drop.fill", .blue, "The Nutrition Source: Activity Standards", "https://www.hsph.harvard.edu/nutritionsource/"),
        ("flame.fill", .red, "Food Smart Colorado: Nutrient Guide", "https://foodsmartcolorado.colostate.edu/"),
        ("fork.knife", .brown, "28 Healthy Snacks Your Kids Will Love", "https://www.healthysnacksforkids.com/"),
        ("figure.walk", .brown, "Tips to Support Healthy Routines for Children", "https://www.cdc.gov/healthyweight/"),
        ("book.fill", .blue, "How To Teach Kids Healthy Eating Habits", "https://www.healthychildren.org/"),
        ("hand.thumbsup.fill", .green, "Nutritional Guidelines for Kids of Every Age", "https://www.nutrition.gov/"),
        ("drop", .blue, "Why is Hydration Important in Children", "https://www.healthyhydration.com/"),
        ("cup.and.saucer.fill", .pink, "7-Day Meal Plan for Busy Parents", "https://www.mealplanner.com/"),
        ("cart.fill", .orange, "Food allergies in babies and children", "https://www.foodallergy.org/"),
        ("hand.thumbsup.fill", .brown, "Advice on picky eating in children", "https://www.pickyeatingadvice.com/")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(educationalLinks, id: \.title) { item in
                    HStack(spacing: 16) {
                        Image(systemName: item.icon)
                            .foregroundColor(item.color)
                            .font(.system(size: 24))
                            .frame(width: 40, height: 40)
                            .background(item.color.opacity(0.1))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Link(item.title, destination: URL(string: item.url)!)
                                .foregroundColor(.blue)
                                .font(.system(size: 18, weight: .medium))
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Educational Material")
        }
    }
}

#Preview {
    EducationalView()
}
