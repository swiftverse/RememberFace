//
//  DetailView.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 17/01/22.
//

import SwiftUI
import MapKit
import simd

struct DetailView: View {
    var friend: Friend
    @State var friends = [Friend]()
    var savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFriends")
    @State var region: MKCoordinateRegion
    init(friend: Friend) {
        self.friend = friend
        do {
            let data = try Data(contentsOf: savePath)
            _friends = try State(initialValue: JSONDecoder().decode([Friend].self, from: data))
           }
           
          catch {
           _friends = State(initialValue: [])
          }
        
        _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: friend.latitude, longitude: friend.longitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)))
    }
    
    
    
    var body: some View {
        Form {
        VStack {
            
            if let data = try? Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent(friend.picName)), let loaded = UIImage(data: data)  {
                Image(uiImage: loaded)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height/2)
                //----
                Map(coordinateRegion: $region, annotationItems: friends) {
                    
                    item in
                    
                    MapPin(coordinate: friend.coordinates)
                    
                }
                    .frame(width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height/2)
                  
                
                //----
                
            }
        }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(friend: <#Friend#>)
//    }
//}
