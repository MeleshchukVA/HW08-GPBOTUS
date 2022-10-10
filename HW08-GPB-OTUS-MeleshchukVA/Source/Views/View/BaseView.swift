//
//  BaseView.swift
//  HW08-GPB-OTUS-MeleshchukVA
//
//  Created by Владимир Мелещук on 06.10.2022.
//

import UIKit

final class BaseView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    
    private func configure() {
       backgroundColor = .clear
       translatesAutoresizingMaskIntoConstraints = false
    }
}
