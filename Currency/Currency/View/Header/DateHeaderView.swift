//
//  DateHeaderView.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 06/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Resources

final class DateHeaderView: UIView {
    // MARK: - Visual Components
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.quaternary
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewHierarchy()
        configConstraints()
        configView()
    }
    
    private func configViewHierarchy() {
        addSubview(titleLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.space01),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.space01),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configView() {
        backgroundColor = UIColor.secondary
    }
}
