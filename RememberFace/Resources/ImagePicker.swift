//
//  ImagePicker.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 15/01/22.
//

import Foundation
import UIKit
import PhotosUI
import SwiftUI
//
//struct ImagePicker: UIViewControllerRepresentable {
//    typealias UIViewControllerType = PHPickerViewController
//    @Binding var image: UIImage?
//    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
//
//    }
//
//    func makeUIViewController(context: Context) -> PHPickerViewController {
//        var config = PHPickerConfiguration()
//        config.filter = .images
//        let picker = PHPickerViewController(configuration: config)
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    class Coordinator: NSObject, PHPickerViewControllerDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
//
//            picker.dismiss(animated: true)
//            guard let provider = results.first?.itemProvider else {
//                return
//            }
//
//            if provider.canLoadObject(ofClass: UIImage.self) {
//                provider.loadObject(ofClass: UIImage.self) { image, _ in
//                    self.parent.image = image as? UIImage
//                }
//            }
//
//        }
//
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//
//}




struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = self.sourceType
        picker.delegate = context.coordinator
        return picker
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {


            if let image = info[.originalImage] as? UIImage {
                self.parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


}
