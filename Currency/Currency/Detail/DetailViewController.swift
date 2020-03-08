//
//  DetailViewController.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 07/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Resources

protocol DetailDisplay: AnyObject {
    func display(day: String)
    func displayList(currencies: [(String, String)])
}

final class DetailViewController: UIViewController {
    // MARK: - Visual Components
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        label.textColor = UIColor.quaternary
        label.textAlignment = .center
        label.text = "1 Btc"
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.secondary
        return view
    }()
    
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.primary
        tableView.separatorStyle = .none
        tableView.register(
            CriptoCurrencyTableViewCell.self,
            forCellReuseIdentifier: String(describing: CriptoCurrencyTableViewCell.self)
        )
        return tableView
    }()
    
    // MARK: - Variables
    private let interactor: DetailInteracting
    private var currencies: [(String, String)] = [] {
        didSet {
            listTableView.reloadData()
        }
    }
    
    // MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(interactor: DetailInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewHierarchy()
        configConstraints()
        configView()
        interactor.showData()
    }
    
    func configViewHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(lineView)
        view.addSubview(listTableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor, constant: Spacing.space03),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Spacing.space03),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configView() {
        navigationItem.largeTitleDisplayMode = .never
        view.backgroundColor = UIColor.primary
    }
}

// MARK: - DetailDisplay
extension DetailViewController: DetailDisplay {
    func display(day: String) {
        navigationItem.title = day
    }
    
    func displayList(currencies: [(String, String)]) {
        self.currencies = currencies
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CriptoCurrencyTableViewCell.self)) as? CriptoCurrencyTableViewCell {
            let currency: (key: String, value: String) = currencies[indexPath.row]
            cell.selectionStyle = .none
            cell.titleLabel.text = currency.key
            cell.rateLabel.text = currency.value
            return cell
        }
        return UITableViewCell()
    }
}
