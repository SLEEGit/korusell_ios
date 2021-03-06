//
//  MultipleImagePicker.swift
//  iosApp
//
//  Created by Sergey Lee on 2022/01/04.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return PhotoPicker.Coordinator(phot1: self)
    }
    
    @Binding var photos: [UIImage]
    @Binding var showPicker: Bool
    @State var directory: String
    @State var uid: String
//    var any = PHPickerConfiguration(photoLibrary: .shared())
    
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var config = PHPickerConfiguration()
//        config.filter = any.filter
        config.filter = .images
        config.selectionLimit = 4
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
    
    class Coordinator : NSObject, PHPickerViewControllerDelegate {
        var phot: PhotoPicker
        init(phot1 : PhotoPicker) {
            phot =  phot1
        }
        
        
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.phot.showPicker.toggle()
            self.phot.photos = []
            for photo in results {
                if photo.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    photo.itemProvider.loadObject(ofClass: UIImage.self) { image, err in
                        guard let photo1 = image else {
                            print("\(String(describing: err?.localizedDescription))")
                            return
                        }
                        self.phot.photos.append(photo1 as! UIImage)
                    }
                } else {
                    print("No photos or videos was loaded")
                }
            }
        }
    }
    
}
