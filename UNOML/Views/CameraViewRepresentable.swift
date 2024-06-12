//
//  CameraViewRepresentable.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI

struct CameraViewRepresentable: UIViewControllerRepresentable {
    
    
    @Binding var image: UIImage?
    @Binding var showScreen: Bool
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.sourceType = .camera
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(image: $image, isShown: $showScreen)
    }
    
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var image: UIImage?
        @Binding var isShown: Bool
        
        init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
            self._image = image
            self._isShown = isShown
        }
        
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                image = uiImage
            }
            isShown = false
        }     
    }
}
