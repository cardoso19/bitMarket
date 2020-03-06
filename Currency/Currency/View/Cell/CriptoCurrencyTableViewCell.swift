//
//  CriptoCurrencyTableViewCell.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 06/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit
import Resources

final class CriptoCurrencyTableViewCell: UITableViewCell {
    // MARK: - Visual Components
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1 ฿"
        label.textColor = UIColor.quaternary
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private(set) lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.quaternary
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    }()
    
    // MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configViewHierarchy()
        configConstraints()
        configViews()
    }
    
    private func configViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rateLabel)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Spacing.space03),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Spacing.space02),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Spacing.space02)
        ])
        
        NSLayoutConstraint.activate([
            rateLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Spacing.space02),
            rateLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: Spacing.space01)
        ])
    }
    
    private func configViews() {
        backgroundColor = UIColor.primary
    }
}
