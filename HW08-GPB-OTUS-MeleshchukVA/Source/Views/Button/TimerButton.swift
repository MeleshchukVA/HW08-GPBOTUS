//
//  TimerButton.swift
//  HW08-GPB-OTUS-MeleshchukVA
//
//  Created by Владимир Мелещук on 06.10.2022.
//

import UIKit

final class TimerButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: CGColor, systemName: String) {
        self.init(frame: .zero)
        layer.backgroundColor = color
        setImage(
            UIImage(
                systemName: systemName,
                withConfiguration: UIImage.SymbolConfiguration(
                    pointSize: 40,
                    weight: .medium,
                    scale: .large
                )
            ),
            for: .normal
        )
    }
    
    // MARK: - Override methods
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        
        layer.cornerRadius = frame.size.width / 2
    }
    
    // MARK: - Private methods
    
    private func configure() {
        tintColor = .white
        layer.masksToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
