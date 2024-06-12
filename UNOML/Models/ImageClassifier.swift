//
//  ImageClassifier.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI
import CoreML
import Vision

class ImageClassifier {
    
    func classify(image: UIImage) async throws -> (String, String) {
        // Convert UIImage to CIImage
        guard let ciimage = CIImage(image: image) else {
            throw NSError(domain: "ImageClassifierError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Unable to create CIImage from UIImage."])
        }
        
        // Load the models for color and number classification
        guard let colorsModel = try? VNCoreMLModel(for: UnoColorsModel().model),
              let numbersModel = try? VNCoreMLModel(for: UnoNumbersModel().model) else {
            throw NSError(domain: "ImageClassifierError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unable to load CoreML models."])
        }
        
        // Create VNCoreMLRequests for both models
        var colorClassification: String?
        var numberClassification: String?
        
        let colorsRequest = VNCoreMLRequest(model: colorsModel) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                colorClassification = topResult.identifier
            }
        }
        
        let numbersRequest = VNCoreMLRequest(model: numbersModel) { request, error in
            if let results = request.results as? [VNClassificationObservation],
               let topResult = results.first {
                numberClassification = topResult.identifier
            }
        }
        
        // Handle the image with both requests
        let handler = VNImageRequestHandler(ciImage: ciimage)
        try handler.perform([colorsRequest, numbersRequest])
        
        // Ensure both classifications are available
        guard let colorResult = colorClassification, let numberResult = numberClassification else {
            throw NSError(domain: "ImageClassifierError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to classify image."])
        }
        
        return (numberResult, colorResult)
    }
}
