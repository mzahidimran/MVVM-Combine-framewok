//
//  FlightOfferViewController.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/20/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit
import Combine

class FlightOfferViewController: UIViewController {
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var flyDateLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    
    private(set) var flightDetailViewModel:FlightOfferDetailViewModel!
    private(set) var index:Int = 0
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func set(flightDetail: FlightOfferDetailViewModel, index: Int) {
        self.flightDetailViewModel = flightDetail
        self.index = index
    }
    
    func updateUI() {
        flightDetailViewModel.$date.assign(to: \UILabel.text, on: self.flyDateLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$duration.assign(to: \UILabel.text, on: self.durationLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$destination.assign(to: \UILabel.text, on: self.destinationLabel).add(to: &disposeBag)
        
        flightDetailViewModel.$price.assign(to: \UILabel.text, on: self.priceLabel).add(to:&disposeBag)
        
        flightDetailViewModel.$bannerURL.sink { (url) in
            guard let url = url else { self.bannerImageView.image = UIImage(named: "photos"); return }
            self.bannerImageView.loadImage(url: url)
        }.add(to: &disposeBag)
        
        
    }
    
}
