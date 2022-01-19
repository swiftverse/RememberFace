//
//  ContentView.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 15/01/22.
//

import SwiftUI


enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}


struct RememberFace: View {
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var activeSheet: ActiveSheet?
    @State var selectedFriend: Friend?
    var savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFriends")
    @State var image: UIImage?
  
    @State var friends = [Friend]()
    @State var showConfirmationData = false
    @State var showImagePicker = false
    @State var showAddView = false
    var imageData: Data?
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            _friends = try State(initialValue: JSONDecoder().decode([Friend].self, from: data))
           }
           
          catch {
           _friends = State(initialValue: [])
          }
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(friends) {  friend in
                    NavigationLink(destination: DetailView(friend: friend)) {
                        HStack {
                            Text(friend.picName)
                                .font(.title)
                            Spacer()
                            if let data = try? Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent(friend.picName)), let loaded = UIImage(data: data)  {
                                Image(uiImage: loaded)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            }
                               
                        }
                    }
                   
                   
                }
                
                
            }
            .navigationTitle("Friends List")
            .toolbar {
                Button("Add") {
                  //  activeSheet = .first
                    showConfirmationData = true
                }
            }
            
            
        }
        .onChange(of: image) { newValue in
            activeSheet = .second
        }
        
        .confirmationDialog("Select Image Source", isPresented: $showConfirmationData, actions: {
            Button("Camera") {
                self.sourceType = .camera
                activeSheet = .first
            }
            
            Button("Gallery") {
                self.sourceType = .photoLibrary
                activeSheet = .first
            }
            
            Button("Cancel", role: .cancel) {
                
            }
        })
        
        
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .first:
                ImagePicker(image: $image, sourceType: sourceType)
            case .second:
                AddView(imageData: $image) { friend in
                    friends.append(friend)
                    selectedFriend = friend
                    save()
                }
                
            }
            
        }
    }
    
 
    func save() {
        do {
            let data = try JSONEncoder().encode(friends)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    
}

struct RememberFace_Previews: PreviewProvider {
    static var previews: some View {
        RememberFace()
    }
}
