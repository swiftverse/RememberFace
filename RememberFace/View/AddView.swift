//
//  AddView.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 16/01/22.
//

import SwiftUI
import MapKit

struct AddView: View {
    @Binding var imageData: UIImage?
    @Environment(\.dismiss) var dismiss
    @State var friendName: String = ""
   
    
    var save: (Friend) -> Void
   
    init(imageData: Binding<UIImage?>, save: @escaping  (Friend) -> Void) {
       
        self.save = save
        _friendName = State(initialValue: "")
        _imageData = imageData
    }
    
    var body: some View {
        NavigationView {
            Form {
            VStack {
                TextField("your friends name", text: $friendName)
                Image(uiImage: imageData!)
                    .resizable()
                    .scaledToFit()
                //-----
              
                    //------
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let newFriend = Friend(picName: friendName, id: UUID(), longitude: 0.0, latitude: 0.0)
                            save(newFriend)
                        
                        if let jpegData = imageData?.jpegData(compressionQuality: 0.8) {
                            try? jpegData.write(to: FileManager.documentsDirectory.appendingPathComponent(newFriend.picName), options: [.atomic, .completeFileProtection])
                        }
                        
                        
                        
                        
                            dismiss()
                    }
                    .padding()
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .padding()
                    }
                }
            }
        }
    }
}

