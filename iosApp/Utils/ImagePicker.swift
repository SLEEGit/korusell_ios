//
//  ImagePicker.swift
//  iosApp
//
//  Created by Sergey Lee on 2021/12/19.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
 
    @Binding var selectedImage: UIImage
    @Binding var currentUid: String
    @Binding var directory: String
    @Environment(\.presentationMode) var presentationMode
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
 
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
 
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}


final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    var parent: ImagePicker
 
    init(_ parent: ImagePicker) {
        self.parent = parent
    }
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
 
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DB().postImage(image: image, directory: parent.directory, uid: parent.currentUid, quality: 0.1)
            parent.selectedImage = image
        }
 
        parent.presentationMode.wrappedValue.dismiss()
    }
    
    
    
}

//struct ImagePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePicker(selectedImage: <#Binding<UIImage>#>)
//    }
//}


