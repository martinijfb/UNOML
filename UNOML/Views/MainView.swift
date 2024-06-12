//
//  ContentView.swift
//  UNOML
//
//  Created by Martin on 12/06/2024.
//

import SwiftUI

struct MainView: View {
    
    @State var vm = MainViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                background
                contentView
            }
            .navigationTitle(vm.cardImage == nil ? "What's your Card?" : "\(vm.colorString) \(vm.numberString)")
            .toolbar {
                if vm.cardImage != nil {
                    deleteButton
                } else {
                    infoButton
                }
                photoLibraryButton
                cameraButton
            }
            .fullScreenCover(isPresented: $vm.showCamera, content: cameraView)
            .fullScreenCover(isPresented: $vm.showImagePicker, content: {
                photoPicker
            })
        }
    }
}

#Preview {
    MainView()
}
