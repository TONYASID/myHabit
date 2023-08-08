//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Anton Kislov on 08.06.2023.
//

import UIKit

class ProgressHeaderView: UICollectionReusableView {
    
    lazy var cellContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var mottoLable: UILabel = {
        let label = UILabel()
        label.font = const.footnoteSmallFont
        label.textColor = const.sistemGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var percentLabel: UILabel = {
        let label = UILabel()
        label.font = const.footnoteSmallFont
        label.textColor = const.sistemGray
        label.textAlignment = .right
        return label
    }()
    
    lazy var spinnerView: UIProgressView = {
        let spinner = UIProgressView()
        spinner.tintColor = const.rgbPurple
        spinner.layer.cornerRadius = 5
        return spinner
    }()
    
    func configureProgressCell() {
        mottoLable.text = "Всё получится!"
        percentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        spinnerView.setProgress(HabitsStore.shared.todayProgress, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cellContentView)
        [mottoLable, percentLabel, spinnerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cellContentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            
            cellContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellContentView.heightAnchor.constraint(equalToConstant: 60),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            mottoLable.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            mottoLable.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 12),
            mottoLable.heightAnchor.constraint(equalToConstant: 18),
            
            percentLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            percentLabel.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -12),
            percentLabel.heightAnchor.constraint(equalToConstant: 18),
            
            spinnerView.topAnchor.constraint(equalTo: mottoLable.bottomAnchor, constant: 10),
            spinnerView.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 12),
            spinnerView.heightAnchor.constraint(equalToConstant: 7),
            spinnerView.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -12)
        ])
    }
}



