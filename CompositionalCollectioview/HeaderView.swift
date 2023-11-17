//
//  HeaderView.swift
//  CompositionalCollectioview
//
//  Created by 신진우 on 11/17/23.
//

import UIKit

class HeaderView: UICollectionReusableView {
    public var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        textLabelConstraints()
    }
    
    private func textLabelConstraints() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
}

