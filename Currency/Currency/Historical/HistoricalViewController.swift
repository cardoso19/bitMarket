//
//  HistoricalViewController.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 03/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Resources

protocol HistoricalDisplay: AnyObject {
//    func 
}

final class HistoricalViewController: UIViewController {
    // MARK: - Visual Components
    
    // MARK: - Variables
    private let interactor: HistoricalInteracting
    
    // MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: HistoricalInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        interactor.updateCriptoCurrencyHistoricalList()
    }
    
    private func configView() {
        view.backgroundColor = .red
    }
}

// MARK: - HistoricalDisplay
extension HistoricalViewController: HistoricalDisplay {
    
}
