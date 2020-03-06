//
//  LoaderView.swift
//  Currency
//
//  Created by Matheus Cardoso Kuhn on 06/03/20.
//  Copyright © 2020 Matheus Cardoso Kuhn. All rights reserved.
//

import UIKit

final class LoaderView: UIView {
    // MARK: - Visual Components
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = UIColor.quaternary
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    // MARK: - Life Cycle
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        configViewHierarchy()
        configConstraints()
        configView()
    }
    
    private func configViewHierarchy() {
        addSubview(activityIndicator)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.heightAnchor.constraint(equalToConstant: 30),
            activityIndicator.widthAnchor.constraint(equalToConstant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func configView() {
        backgroundColor = UIColor.secondary
    }
    
    // MARK: - Presentation
    public static func show(on view: UIView, animated: Bool) {
        let loader = LoaderView(frame: view.frame)
        loader.tag = 999
        if animated {
            loader.alpha = 0.0
            loader.alphaAnimation(to: 1.0, completion: nil)
        }
        view.addSubview(loader)
    }
    
    public static func hide(on view: UIView, animated: Bool) {
        guard let loader = view.viewWithTag(999) as? LoaderView else { return }
        if animated {
            loader.alphaAnimation(to: 0.0) {
                loader.removeFromSuperview()
            }
        } else {
            loader.removeFromSuperview()
        }
    }
    
    private func alphaAnimation(to finalValue: CGFloat, completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.25) {
            self.alpha = finalValue
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = finalValue
        }) { _ in
            completion?()
        }
    }
}
