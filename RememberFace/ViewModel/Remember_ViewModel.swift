//
//  Remember_ViewModel.swift
//  RememberFace
//
//  Created by Amit Shrivastava on 16/01/22.
//

import Foundation

extension RememberFace {
 @MainActor   class ViewModel: ObservableObject {
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFriends")
        
        @Published private(set) var friends: [Friend]
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                friends = try JSONDecoder().decode([Friend].self, from: data)
            }
            
            catch {
                friends = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(friends)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
            
            catch {
                print(error.localizedDescription)
            }
        }
    }
}
