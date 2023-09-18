//
//  EventImageDataModel.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 18/09/2023.
//

import UIKit
import RealmSwift

class EventImageDataModel: RealmSwift.Object {
    
    @Persisted var ratio: String?
    @Persisted var url: String?
    @Persisted var width: Int?
    @Persisted var height: Int?
    @Persisted var fallback: Bool?
}

extension EventImageDataModel {
    
    convenience init(dict: [String: Any]) {
        self.init()
        
        ratio = ((dict["ratio"] ?? "") as? String)
        url = ((dict["url"] ?? "") as? String)
        width = ((dict["width"] ?? 0) as? Int)
        height = ((dict["height"] ?? 0) as? Int)
        fallback = ((dict["fallback"] ?? false) as? Bool)
    }
    
    func getDeltaForImage(size: CGSize) -> Int {
        let vWidth = Int(size.width)
        guard let iWidth = width else { return 10000 }
        return vWidth - iWidth < 0 ? (vWidth - iWidth) * -1 : vWidth - iWidth
    }
}

/// We will use an extension on the UIImageView to allow us to use the views size against all images to check for smallest delta.  This allows us to pic the best selected image size
extension UIImageView {
    
    func getUrlFromEventImageDataModel(images: List<EventImageDataModel>) -> String? {
        var delta = 10000
        var url: String? = nil
        for image in images {
            let iDelta = image.getDeltaForImage(size: frame.size)
            if iDelta < delta {
                delta = iDelta
                url = image.url
            }
        }
        return url
    }
}
