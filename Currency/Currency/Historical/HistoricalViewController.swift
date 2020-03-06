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
    func displayTodayValue(today: (String, String))
    func displayHistorical(list: [(String, String)])
}

final class HistoricalViewController: UIViewController {
    // MARK: - Visual Components
    private lazy var listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = 100
        tableView.backgroundColor = UIColor.primary
        return tableView
    }()
    
    // MARK: - Variables
    private let interactor: HistoricalInteracting
    private var todayTimer: Timer?
    private var list: [(String, String)] = [] {
        didSet {
            listTableView.reloadData()
        }
    }
    
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
        configViewHierarchy()
        configView()
        configConstraints()
        interactor.updateCriptoCurrencyHistoricalList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todayTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: { [weak self] timer in
            self?.interactor.updateCurrentValue()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        todayTimer?.invalidate()
    }
    
    func configViewHierarchy() {
        view.addSubview(listTableView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.bottomAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.compatibleSafeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func configView() {
        navigationController?.navigationBar.backgroundColor = UIColor.primary
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.title = "Week"
        view.backgroundColor = UIColor.secondary
    }
}

// MARK: - HistoricalDisplay
extension HistoricalViewController: HistoricalDisplay {
    func displayTodayValue(today: (String, String)) {
        list[0] = today
        listTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    func displayHistorical(list: [(String, String)]) {
        self.list = list
    }
}

// MARK: - UITableViewDelegate
extension HistoricalViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Present Next Screen
    }
}

// MARK: - UITableViewDataSource
extension HistoricalViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard !list.isEmpty else { return 1 }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !list.isEmpty else {
            return nil
        }
        let day: (date: String, value: String) = list[section]
        let view = UIView()
        view.backgroundColor = UIColor.tertiary
        let label = UILabel()
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.quaternary
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.space01),
            label.bottomAnchor.constraint(equalTo: view.topAnchor, constant: Spacing.space01),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
        label.text = day.date
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !list.isEmpty else {
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor.primary
            cell.textLabel?.textColor = UIColor.quaternary
            cell.textLabel?.text = " No content"
            return cell
        }
        let day: (date: String, value: String) = list[indexPath.section]
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.primary
        cell.textLabel?.text = day.date + " - " + day.value
        cell.textLabel?.textColor = UIColor.quaternary
        cell.detailTextLabel?.textColor = UIColor.quaternary
        return cell
    }
}
