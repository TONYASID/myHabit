//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Anton Kislov on 05.06.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .systemBackground
        title = "Информация"
    }
    
    // MARK: Creating scrollView
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    func createLable(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = const.bodyFont
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Привычка за 21 день"
        label.font = const.title3Font
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var label0: UILabel = {
        createLable("Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:")
    }()
    lazy var label1: UILabel = {
        createLable("1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель загаданная в перспективу, находится на расстоянии шага.")
    }()
    lazy var label2: UILabel = {
        createLable("2. Выдержать 2 дня в прежнем состоянии самоконтроля.")
    }()
    lazy var label3: UILabel = {
        createLable("3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.")
    }()
    lazy var label4: UILabel = {
        createLable("4. Поздравить себя с прохождением первого серьезного порога в 21 день. За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.")
    }()
    lazy var label5: UILabel = {
        createLable("5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.")
    }()
    lazy var label6: UILabel = {
        createLable("6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.")
    }()
    
    private func setupViews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(containerView)
        [headerLabel, label0, label1, label2, label3, label4, label5, label6].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 22),
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerLabel.widthAnchor.constraint(equalToConstant: 218),
            headerLabel.heightAnchor.constraint(equalToConstant: 24),
            
            label0.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 22),
            label0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label1.topAnchor.constraint(equalTo: label0.bottomAnchor, constant: const.inset16),
            label1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label1.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: const.inset16),
            label2.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label3.topAnchor.constraint(equalTo: label2.bottomAnchor, constant: const.inset16),
            label3.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label3.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label4.topAnchor.constraint(equalTo: label3.bottomAnchor, constant: const.inset16),
            label4.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label4.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label5.topAnchor.constraint(equalTo: label4.bottomAnchor, constant: const.inset16),
            label5.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label5.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            
            label6.topAnchor.constraint(equalTo: label5.bottomAnchor, constant: const.inset16),
            label6.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: const.inset16),
            label6.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -const.inset16),
            label6.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -const.inset16)
        ])
    }
}
