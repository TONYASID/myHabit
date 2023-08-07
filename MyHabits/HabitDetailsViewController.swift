//
//  HabitDetailsView.swift
//  MyHabits
//
//  Created by Anton Kislov on 24.06.2023.
//

import UIKit

protocol HabitDetailsChangeTitleProtocol: AnyObject {
    func habitsDidChangeTitle(_ title: String)
}

class HabitDetailsViewController: UIViewController, UINavigationControllerDelegate {
    
    let myCell = "myCell"
    
    private var habit: Habit
    
    init(habit: Habit) {
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.tableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor =
        const.rgbPurple
        navigationItem.title = habit.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem?.tintColor = const.rgbPurple
        navigationController?.modalPresentationStyle = .fullScreen
        tabBarController?.tabBar.isHidden = false
    }
    
    @objc func rightBarButtonItemTapped() {
        let vc = HabitViewController()
        vc.delegateTitle = self
        vc.habit = habit
        vc.navigationItem.title = "Править"
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
        
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: myCell)
        cell.tintColor = const.rgbPurple
        let habitDateReversed = HabitsStore.shared.dates.reversed()[indexPath.row]
        if HabitsStore.shared.habit(habit, isTrackedIn: habitDateReversed) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = HabitsStore.shared.reversetrackDateString(forIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
}

extension HabitDetailsViewController: HabitDetailsChangeTitleProtocol {
    func habitsDidChangeTitle(_ title: String) {
        navigationItem.title = title
    }
}
