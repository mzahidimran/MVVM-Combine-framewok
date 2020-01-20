//
//  FlightOffersPagedViewController.swift
//  Kiwi
//
//  Created by Muhammad Zahid Imran on 1/19/20.
//  Copyright © 2020 Zahid Imran. All rights reserved.
//

import Foundation
import UIKit

class FlightOffersPagedViewController: UIViewController {
    
    @IBOutlet weak var pageNumberLabel: UILabel!
    
    var model:FlighOfferViewModel!
    
    private var disposeBag: DisposeBag = DisposeBag()
    private weak var pageController: UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    private func bindUI() {
        
        if let firstOfferViewController = viewController(at: 0)  {
            pageController.setViewControllers([firstOfferViewController], direction: .forward, animated: true, completion: nil)
        }
        
        model.$flightOfferCount.sink {[unowned self] (count) in
            if let pageContentViewController = self.pageController.viewControllers?.first as? FlightOfferViewController {
                let index = pageContentViewController.index
                self.updatePage(index+1, total: count)
            }
        }.add(to: &disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UIPageViewController {
            pageController = destination
            pageController.delegate = self
            pageController.dataSource = self
        }
    }
    
    private func updatePage(_ current:Int, total: Int) {
        self.pageNumberLabel.text = "\(current) of \(total)"
    }
    
    private func viewController(at index:Int) -> FlightOfferViewController? {
        guard let flight = model.flight(at: index) else { return nil }
        guard let offerViewController: FlightOfferViewController = Storyboard.main.instantiateViewController() else { return nil }
        offerViewController.set(flightDetail: flight, index: index)
        return offerViewController
    }
}

extension FlightOffersPagedViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let flightOfferViewController = viewController as? FlightOfferViewController else { return nil }
        guard let beforeViewController = self.viewController(at: flightOfferViewController.index-1) else { return nil }
        
        return beforeViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let flightOfferViewController = viewController as? FlightOfferViewController else { return nil }
        guard let beforeViewController = self.viewController(at: flightOfferViewController.index+1) else { return nil }
        
        return beforeViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        if let pageContentViewController = self.pageController.viewControllers?.first as? FlightOfferViewController {
            let index = pageContentViewController.index
            self.updatePage(index+1, total: model.flightOfferCount)
        }
    }
    
}
