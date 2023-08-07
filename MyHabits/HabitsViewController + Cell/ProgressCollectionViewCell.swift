//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Anton Kislov on 08.06.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionReusableView {
    
    lazy var cellContentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    lazy var motoLable: UILabel = {
        let label = UILabel()
        label.font = const.footnoteSmallFont
        label.textColor = const.sistemGray
        label.textAlignment = .left
        return label
    }()
    
    lazy var persentLabel: UILabel = {
        let label = UILabel()
        label.font = const.footnoteSmallFont
        label.textColor = const.sistemGray
        label.textAlignment = .right
        return label
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.tintColor = const.rgbPurple
        slider.layer.cornerRadius = 5
        slider.thumbTintColor = .clear
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    func configureProgressCell() {
        motoLable.text = "Всё получится!"
        persentLabel.text = "\(Int(HabitsStore.shared.todayProgress * 100))%"
        slider.value = HabitsStore.shared.todayProgress * 100
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
        [motoLable, persentLabel, slider].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            cellContentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            
            cellContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            cellContentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cellContentView.heightAnchor.constraint(equalToConstant: 60),
            cellContentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            motoLable.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            motoLable.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 12),
            motoLable.heightAnchor.constraint(equalToConstant: 18),
            
            persentLabel.topAnchor.constraint(equalTo: cellContentView.topAnchor, constant: 10),
            persentLabel.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -12),
            persentLabel.heightAnchor.constraint(equalToConstant: 18),
            
            slider.topAnchor.constraint(equalTo: motoLable.bottomAnchor, constant: 10),
            slider.leadingAnchor.constraint(equalTo: cellContentView.leadingAnchor, constant: 12),
            slider.heightAnchor.constraint(equalToConstant: 7),
            slider.trailingAnchor.constraint(equalTo: cellContentView.trailingAnchor, constant: -12)
        ])
    }
}



