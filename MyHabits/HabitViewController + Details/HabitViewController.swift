//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Anton Kislov on 06.06.2023.
//

import UIKit

class HabitViewController: UIViewController, UITextFieldDelegate {
    
    var textNewHabit = ""
    var habit: Habit?
    weak var delegate: HabitsChangeProtocol?
    weak var delegateTitle: HabitDetailsChangeTitleProtocol?
    
    func createLable(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = const.footnoteFont
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }
    
    lazy var nameOfHabitLabel: UILabel = {
        createLable("НАЗВАНИЕ")
    }()
    lazy var colorOfHabitLabel: UILabel = {
        createLable("ЦВЕТ")
    }()
    lazy var timeOfHabitLabel: UILabel = {
        createLable("ВРЕМЯ")
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.textColor = .black
        textField.font = const.bodyFont
        textField.returnKeyType = .done
        textField.delegate = self
        textField.addTarget(self, action: #selector(didSetNameOfNewHabit), for: .allEditingEvents)
        return textField
    }()
    
    lazy var colorCircleButton: UIButton = {
        let button = UIButton()
        button.largeContentImage = UIImage(systemName: "circle")
        button.addTarget(self, action: #selector(touchTheColorCircleButton), for: .touchUpInside)
        button.backgroundColor = const.rgbOrange
        button.layer.cornerRadius = 30/2
        return button
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Каждый день в "
        label.font = const.bodyFont
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.tintColor = const.rgbPurple
        return datePicker
    }()
    
    lazy var deleteHabitButton: UIButton = {
        let button = UIButton()
        if let habit = habit {
            button.setTitle("Удалить привычку", for: .normal) }
        button.setTitleColor(.systemRed, for: .normal)
        button.addTarget(self, action: #selector(deleteHabitButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        if let habit = habit {
            configureHabitViewController(habit)
        }
    }
    
    private func setupViews() {
        [nameOfHabitLabel, textField, colorOfHabitLabel, colorCircleButton,  timeOfHabitLabel, timeLabel, datePicker, deleteHabitButton].forEach { $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            nameOfHabitLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: const.inset21),
            nameOfHabitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.inset16),
            nameOfHabitLabel.heightAnchor.constraint(equalToConstant: 18),
            nameOfHabitLabel.widthAnchor.constraint(equalToConstant: 74),
            
            textField.topAnchor.constraint(equalTo: nameOfHabitLabel.bottomAnchor, constant: 7),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textField.heightAnchor.constraint(equalToConstant: 22),
            textField.widthAnchor.constraint(equalToConstant: 295),
            
            colorOfHabitLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            colorOfHabitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.inset16),
            colorOfHabitLabel.heightAnchor.constraint(equalToConstant: 18),
            colorOfHabitLabel.widthAnchor.constraint(equalToConstant: 36),
            
            colorCircleButton.topAnchor.constraint(equalTo: colorOfHabitLabel.bottomAnchor, constant: 7),
            colorCircleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.inset16),
            colorCircleButton.heightAnchor.constraint(equalToConstant: 30),
            colorCircleButton.widthAnchor.constraint(equalToConstant: 30),
            
            timeOfHabitLabel.topAnchor.constraint(equalTo: colorCircleButton.bottomAnchor, constant: 15),
            timeOfHabitLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.inset16),
            timeOfHabitLabel.heightAnchor.constraint(equalToConstant: 18),
            timeOfHabitLabel.widthAnchor.constraint(equalToConstant: 47),
            
            timeLabel.topAnchor.constraint(equalTo: timeOfHabitLabel.bottomAnchor, constant: 7),
            timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const.inset16),
            timeLabel.heightAnchor.constraint(equalToConstant: 22),
            timeLabel.widthAnchor.constraint(equalToConstant: 150),
            
            datePicker.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            
            deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),
            deleteHabitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 114.5),
            deleteHabitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -113.5),
            deleteHabitButton.heightAnchor.constraint(equalToConstant: 22),
            deleteHabitButton.widthAnchor.constraint(equalToConstant: 147)
        ])
    }
    
    func configureHabitViewController(_ habit: Habit ) {
        textField.text = habit.name
        colorCircleButton.backgroundColor = habit.color
        datePicker.date = habit.date
    }
    
    func presentColorPicker() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.delegate = self
        colorPicker.selectedColor = .black
        colorPicker.title =  "Выбери цвет привычки"
        present(colorPicker, animated: true)
    }
    
    @objc  func didSetNameOfNewHabit() {
        if let text = textField.text {
            textNewHabit = text
        }
    }
    
    @objc func rightBarButtonItemTapped() {
        if let habit = habit {
            habit.name = textNewHabit
            habit.date = datePicker.date
            habit.color = self.colorCircleButton.backgroundColor ?? .systemBackground
            dismiss(animated: true, completion: nil)
        } else {
            let newHabit = Habit(name: textNewHabit,
                                 date: datePicker.date,
                                 color: self.colorCircleButton.backgroundColor ?? .systemBackground)
            let store = HabitsStore.shared
            store.habits.append(newHabit)
            dismiss(animated: true, completion: nil)
        }
        HabitsStore.shared.save()
        delegate?.habitsDidChange()
        delegateTitle?.habitsDidChangeTitle(habit?.name ?? "")
    }
    
    @objc func leftBarButtonItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func touchTheColorCircleButton() {
        presentColorPicker()
    }
    
    @objc func deleteHabitButtonTapped() {
        let actionButton = UIAlertController(title: title, message: "Вы хотите удалить привычку \(habit?.name ?? "") ?", preferredStyle: .alert)
        let cancellAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            let deletedHabit = self.habit
            let store = HabitsStore.shared
            for _ in store.habits.indices.reversed() {
                if let i = store.habits.firstIndex(where: {$0 == deletedHabit}) {
                    store.habits.remove(at: i)
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
        actionButton.addAction(cancellAction)
        actionButton.addAction(deleteAction)
        present(actionButton, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = const.rgbPurple
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(leftBarButtonItemTapped))
        navigationItem.leftBarButtonItem?.tintColor = const.rgbPurple
        navigationController?.modalPresentationStyle = .fullScreen
        view.backgroundColor = .systemBackground
        tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.title = textNewHabit
    }
}
extension HabitViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        // called when the selected color changes
        self.colorCircleButton.backgroundColor = viewController.selectedColor
    }
}
