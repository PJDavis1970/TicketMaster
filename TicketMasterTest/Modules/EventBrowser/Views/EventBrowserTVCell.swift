//
//  EventBrowserTVCell.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import SDWebImage

class EventBrowserTVCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gigImage: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var venuelbl: UILabel!
    @IBOutlet weak var locationlbl: UILabel!
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupUI(event: EventDataModel) {
        
        backView.borderStyle(color: UIColor.darkGray, cornerRadius: 6, shadowRadius: 5, shadowOpacity: 0.6, shadowOffset: CGSize(width: 5, height: 5))
        
        if let url = gigImage.getUrlFromEventImageDataModel(images: event.images) {
            gigImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
        }
        namelbl.text = event.name
        datelbl.text = event.startDate?.formateDateStringToMonthDay()
        venuelbl.text = event.venue
        locationlbl.text = event.location

    }
}

