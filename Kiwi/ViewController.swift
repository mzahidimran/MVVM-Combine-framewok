//
//  ViewController.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/18/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet weak var viewOfferButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    let model = FlighOfferViewModel()
    
    private var disposeBag: DisposeBag = DisposeBag()
    private weak var pageController: UIPageViewController!
    
    enum Segues: String {
        case showOffers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupObservers()
    }
    
    private func setupObservers() {
        model.$error.sink {[unowned self] (errorString) in
            guard let error = errorString else { return }
            self.showErrorAlert(error: error)
        }.add(to: &disposeBag)
        
        model.$flightOfferCount.sink {[unowned self] (_) in
            self.performSegue(withIdentifier: Segues.showOffers.rawValue, sender: nil)
        }.add(to: &disposeBag)
        
        viewOfferButton.publisher(for: .touchUpInside).sink {[unowned self]  (button) in
            self.model.loadFlights(date: self.datePicker.date)
        }.add(to: &disposeBag)
        
        model.$isLoading.sink {[unowned self] (loading) in
            self.viewOfferButton.isEnabled = !loading
            self.activityIndicator.isHidden = !loading
        }.add(to: &disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let destination = segue.destination as? FlightOffersViewController else { return }
        destination.model = model
    }
    
    private func showErrorAlert(error: String) -> Void {
        let alert = UIAlertController(title: "🙁", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

}

