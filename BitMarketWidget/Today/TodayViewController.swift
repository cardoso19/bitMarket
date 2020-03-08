//
//  TodayViewController.swift
//  BitMarketWidget
//
//  Created by Matheus Cardoso Kuhn on 08/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import NotificationCenter
import Service

protocol TodayDisplay: AnyObject {
    func display(title: String, value: String)
    func hideLoader()
    func displayError(message: String)
}

class TodayViewController: UIViewController, NCWidgetProviding {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    // MARK: - Variables
    private let interactor: TodayInteracting
    private var todayTimer: Timer?
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        let service = TodayService(requester: HttpRequest())
        let presenter = TodayPresenter()
        self.interactor = TodayInteractor(service: service, presenter: presenter)
        super.init(coder: coder)
        presenter.viewController = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let service = TodayService(requester: HttpRequest())
        let presenter = TodayPresenter()
        self.interactor = TodayInteractor(service: service, presenter: presenter)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter.viewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loader.startAnimating()
        todayTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { [weak self] _ in
            self?.interactor.getCurrentValue()
        })
        todayTimer?.fire()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        todayTimer?.invalidate()
    }
    
    private func configView() {
        titleLabel.text = ""
        valueLabel.text = ""
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
}

// MARK: - TodayDisplay
extension TodayViewController: TodayDisplay {
    func display(title: String, value: String) {
        titleLabel.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        titleLabel.text = title
        valueLabel.text = value
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
    
    func displayError(message: String) {
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.text = message
        valueLabel.text = ""
    }
}
