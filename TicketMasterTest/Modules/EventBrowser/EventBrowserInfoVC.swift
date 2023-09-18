//
//  EventBrowserInfoVC.swift
//  TicketMasterTest
//
//  Created by Paul Davis on 17/09/2023.
//

import UIKit
import SDWebImage

class EventBrowserInfoVC: UIViewController {
    
    var event: EventDataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        
        view.backgroundColor = .white
        
        let deviceSize = UIScreen.main.bounds
        
        /// add image view
        let imageView = UIImageView(frame: CGRect(x: 16, y: 112, width: deviceSize.width - 32, height: deviceSize.width - 32))
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        if let images = event?.images {
            if let url = imageView.getUrlFromEventImageDataModel(images: images) {
                imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage())
            }
        }
        imageView.backgroundColor = .black
        view.addSubview(imageView)
        
        let namelbl = UILabel(frame: CGRect(x: 16, y: 128 + (deviceSize.width - 32), width: deviceSize.width - 32, height: 32))
        namelbl.text = event?.name
        namelbl.numberOfLines = 0
        namelbl.textAlignment = .left
        namelbl.textColor = .black
        namelbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview( namelbl)
        namelbl.sizeToFit()
        
        let datelbl = UILabel(frame: namelbl.frame.offsetBy(dx: 0, dy: 52))
        datelbl.text = event?.startDate?.formateDateStringToMonthDay()
        datelbl.textAlignment = .left
        datelbl.textColor = .darkGray
        datelbl.font = UIFont(name: "HelveticaNeue", size: 16)
        view.addSubview( datelbl)
        datelbl.sizeToFit()
        
        let venuelbl = UILabel(frame: datelbl.frame.offsetBy(dx: 0, dy: 24))
        venuelbl.text = event?.venue
        venuelbl.textAlignment = .left
        venuelbl.textColor = .darkGray
        venuelbl.font = UIFont(name: "HelveticaNeue", size: 16)
        view.addSubview( venuelbl)
        venuelbl.sizeToFit()
        
        let locationlbl = UILabel(frame: venuelbl.frame.offsetBy(dx: 0, dy: 24))
        locationlbl.text = event?.location
        locationlbl.textAlignment = .left
        locationlbl.textColor = .darkGray
        locationlbl.font = UIFont(name: "HelveticaNeue", size: 16)
        view.addSubview( locationlbl)
        locationlbl.sizeToFit()
        
        let infoTV = UITextView(frame: CGRect(x: 16, y: locationlbl.frame.origin.y + 30, width: deviceSize.width - 32, height: deviceSize.height - (locationlbl.frame.origin.y + 30 + 16)))
        infoTV.text = event?.info
        infoTV.textAlignment = NSTextAlignment.justified
        infoTV.textColor = .black
        infoTV.font = UIFont(name: "HelveticaNeue", size: 16)
        infoTV.backgroundColor = .white
        view.addSubview(infoTV)
    }
}

