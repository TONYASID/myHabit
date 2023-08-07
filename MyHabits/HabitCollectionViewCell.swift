//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Anton Kislov on 08.06.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    lazy var cellContentView: UIView = {
        let imageView = UIView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var nameOfHabit: UILabel = {
        let label = UILabel()
        label.font = const.headlineFont
        return label
    }()
    
    lazy var timeOfHabit: UILabel = {
        let label = UILabel()
        label.font = const.captionFont
        label.textColor = const.sistemGray2
        return label
    }()
    
    lazy var cellButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 38/2
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var countOfHabit: UILabel = {
        let label = UILabel()
        label.font = const.footnoteSmallFont
        label.textColor = const.sistemGray
        return label
    }()
    
    func configureCell(_ habit: Habit) {
        nameOfHabit.text = habit.name
        nameOfHabit.textColor = habit.color
        timeOfHabit.text = habit.dateString
        countOfHabit.text = "Счетчик: \(habit.trackDates.count)"
        cellButton.imageView?.contentMode = .scaleAspectFit
        if habit.isAlreadyTakenToday {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 38)
            let largeCircle = UIImage(systemName: "checkmark.circle.fill", withConfiguration: largeConfig)
            let tintCircle = largeCircle?.withTintColor(habit.color, renderingMode: .alwaysOriginal)
            cellButton.setImage(tintCircle, for: .normal)
        } else {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 38)
            let largeCircle = UIImage(systemName: "circle", withConfiguration: largeConfig)
            let tintCircle = largeCircle?.withTintColor(habit.color, renderingMode: .alwaysOriginal)
            cellButton.setImage(tintCircle, for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameOfHabit.text = nil
        timeOfHabit.text = nil
        countOfHabit.text = nil
        cellButton.removeTarget(nil, action: nil, for: .allEvents)
        cellButton.setImage(nil, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(cellContentView)
        setupViews()
    }
    
    func setupViews() {
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        [nameOfHabit, timeOfHabit, cellButton, countOfHabit].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            cellContentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            cellContentView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContentView.heightAnchor.constraint(equalToConstant: 130),
            
            nameOfHabit.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 20),
            nameOfHabit.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 20),
            nameOfHabit.heightAnchor.constraint(equalToConstant: 22),
            
            timeOfHabit.topAnchor.constraint(equalTo: nameOfHabit.bottomAnchor, constant: 4),
            timeOfHabit.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 20),
            timeOfHabit.heightAnchor.constraint(equalToConstant: 16),
            
            cellButton.centerYAnchor.constraint(equalTo: cellContentView.centerYAnchor),
            cellButton.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -25),
            cellButton.heightAnchor.constraint(equalToConstant: 38),
            cellButton.widthAnchor.constraint(equalToConstant: 38),
            
            countOfHabit.topAnchor.constraint(equalTo: timeOfHabit.bottomAnchor, constant: 30),
            countOfHabit.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 20),
            countOfHabit.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
