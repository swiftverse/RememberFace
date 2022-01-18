//
//  DetailView.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 17/01/22.
//

import SwiftUI

struct DetailView: View {
    var friend: Friend
    var body: some View {
        Form {
        VStack {
            
            if let data = try? Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent(friend.picName)), let loaded = UIImage(data: data)  {
                Image(uiImage: loaded)
                    .resizable()
                    .scaledToFit()
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
