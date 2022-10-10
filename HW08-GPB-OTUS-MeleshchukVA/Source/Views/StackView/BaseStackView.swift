//
//  BaseStackView.swift
//  HW08-GPB-OTUS-MeleshchukVA
//
//  Created by Владимир Мелещук on 06.10.2022.
//

import UIKit

final class BaseStackView: UIStackView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(stackAxis: NSLayoutConstraint.Axis, stackSpacing: CGFloat) {
        self.init(frame: .zero)
        axis = stackAxis
        spacing = stackSpacing
    }
    
    // MARK: - Private methods
    
    private func configure() {
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }
}
