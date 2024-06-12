//
//  DocumentationView.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI

struct DocumentationView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Welcome to the Uno Card Classifier!")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("How to Use:")
                    .font(.headline)
                
                Text("""
                    1. Tap the camera button to open the camera.
                    2. Capture the image of an Uno card.
                    3. The app will automatically classify the color and number of the card.
                    4. Results will be displayed at the top of the screen.
                    5. If you want to classify another card, tap the camera icon again to reset and start over.
                    """)
                    .padding()
                
                Text("Supported Cards:")
                    .font(.headline)
                
                Text("""
                    - The app currently supports classification of Uno cards with numbers from 0 to 9.
                    - Special cards such as 'Change Color', 'Skip', '+2', or '+4' are not supported at this time.
                    """)
                    .padding()
                
                Text("Features:")
                    .font(.headline)
                
                Text("""
                    - Real-time classification of Uno cards.
                    - Uses machine learning to accurately detect colors and numbers.
                    - Simple and intuitive interface.
                    """)
                    .padding()
            }
            .padding()
        }
        .navigationTitle("App Documentation")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Back", systemImage: "chevron.left", action: { dismiss() })
            }
        }
    }
}

#Preview {
    NavigationStack {
        DocumentationView()
    }
}
