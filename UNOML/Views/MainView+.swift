//
//  MainView+.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI
import PhotosUI

extension MainView {
    var background: some View {
        ZStack {
            LinearGradient(colors: [.blue, .red, .yellow, .green], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            Color.black
                .opacity(0.4)
                .ignoresSafeArea()
        }
    }
    var contentView: some View {
        VStack {
            if let safeCardImage = vm.cardImage {
                Image(uiImage: safeCardImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 48.0))
                    .frame(maxWidth: .infinity)
                    .onAppear {
                        vm.classifyImage(safeCardImage)
                    }
            } else {
                classifyButton
            }
        }
        .padding()
    }
    
    var classifyButton: some View {
        Button(action: { vm.showCamera.toggle() }) {
            VStack {
                Image(systemName: "camera.aperture")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .frame(width: 100, height: 100)
                Text("Classify your Card!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    .padding(.horizontal, 48)
            }
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 48))
        }
    }
    
    var cameraButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing){
            Button("Camera", systemImage: "camera.fill") {
                vm.showCamera.toggle()
                vm.reset()
            }
        }
    }
    
    var photoLibraryButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
                Button {
                    vm.imageSelection = nil
                    vm.showImagePicker = true
                } label: {
                    photoPicker
                }
            }
    }
    
    var infoButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                DocumentationView()
                    .navigationBarBackButtonHidden()
            } label: {
                Image(systemName: "info.circle.fill")
            }
        }
    }
    
    var deleteButton: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button("Delete Image", systemImage: "trash.fill", role: .destructive, action: vm.reset)

        }
    }
    
    @ViewBuilder
    func cameraView() -> some View {
        CameraViewRepresentable(image: $vm.cardImage, showScreen: $vm.showCamera)
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    var photoPicker: some View {
        PhotosPicker(selection: $vm.imageSelection, matching: .images) {
            Image(systemName: "photo.on.rectangle.angled")
        }
    }
}

#Preview {
    MainView()
}
