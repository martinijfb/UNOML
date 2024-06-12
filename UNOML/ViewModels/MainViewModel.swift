//
//  MainViewModel.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI
import PhotosUI

@Observable
class MainViewModel {
    
    var cardImage: UIImage? //= UIImage(named: "1g")
    var showCamera: Bool = false
    var showImagePicker: Bool = false
    var numberString: String = "Number"
    var colorString: String = "Color"
    
    let imageClassifier = ImageClassifier()
    
    func classifyImage(_ image: UIImage) {
        Task {
            do {
                // Perform the image classification
                let (number, color) = try await imageClassifier.classify(image: image)
                // Update the UI on the main thread
                await MainActor.run {
                    numberString = number
                    colorString = color
                }
            } catch {
                // Handle errors and update the UI on the main thread
                await MainActor.run {
                    numberString = "Error"
                    colorString = "Error"
                }
                print("Error during classification: \(error)")
            }
        }
    }
    
    func reset() {
        numberString = "Number"
        colorString = "Color"
        cardImage = nil
        imageSelection = nil
    }
    
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
            guard let selection = selection else { return }
            Task {
                if let data = try? await selection.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        // Update the UI on the main thread
                        await MainActor.run {
                            cardImage = uiImage
                            classifyImage(uiImage)
                        }
                    }
                }
            }
        }
}
