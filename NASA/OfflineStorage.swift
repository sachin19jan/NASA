//
//  Created by Sachin, Bhardwaj
//

import Foundation
import UIKit

final class OfflineStorage {
    static func saveImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        let encoded = try! PropertyListEncoder().encode(data)
        UserDefaults.standard.set(encoded, forKey: "NASAIMAGEKEY")
    }
    
    static func loadImage() -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: "NASAIMAGEKEY") else { return nil }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
        let image = UIImage(data: decoded)
        return image
    }
    
    static func saveData(data: NasaStorage) {
        if let encoded = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(encoded, forKey: "SavedData")
        }
    }
    
    static func retrieveData() -> NasaStorage? {
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode(NasaStorage.self, from: data) {
                return decoded
            }
        }
        return nil
    }
}
