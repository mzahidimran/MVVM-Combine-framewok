//
//  FlightOfferDetailViewController.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit
import Combine


///
class FlightOfferDetailViewController: UIViewController {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var flyDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var bookNowButton: UIButton!
    
    private(set) var flightDetailViewModel:FlightOfferDetailViewModel!
    private(set) var index:Int = 0
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func set(flightDetail: FlightOfferDetailViewModel, index: Int) {
        self.flightDetailViewModel = flightDetail
        self.index = index
    }
    
    func bindUI() {
        flightDetailViewModel.$date.assign(to: \UILabel.text, on: self.flyDateLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$duration.assign(to: \UILabel.text, on: self.durationLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$destination.assign(to: \UILabel.text, on: self.destinationLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$price.assign(to: \UILabel.text, on: self.priceLabel).add(to:&disposeBag)
        
        flightDetailViewModel.$bannerURL.sink {[unowned self] (url) in
            guard let url = url else { self.bannerImageView.image = UIImage(named: "photos"); return }
            self.bannerImageView.loadImage(url: url)
        }.add(to: &disposeBag)
        
        flightDetailViewModel.$deeplink.sink {[unowned self] (url) in
            self.bookNowButton.isHidden = url == nil
        }.add(to: &disposeBag)
        
        bookNowButton.publisher(for: .touchUpInside).sink {[unowned self] (button) in
            if let url  = self.flightDetailViewModel.deeplink, UIApplication.shared.canOpenURL(url)  {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }.add(to: &disposeBag)
    
    }
    
}
