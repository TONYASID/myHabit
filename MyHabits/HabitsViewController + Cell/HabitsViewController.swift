//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Anton Kislov on 05.06.2023.
//

import UIKit

protocol CreateNewHabitDelegate: AnyObject {
    func createLabelNewHabit(_ text: String)
}

protocol HabitsChangeProtocol: AnyObject {
    func habitsDidChange()
}

class HabitsViewController: UIViewController, UINavigationControllerDelegate  {
    
    var nameOfSelectedHabit = ""
    var colorOfSelectedHabit = UIColor()
    var timeOfSelectedHabit = ""
    let ItemInsets = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    let sizeForItem = CGSize(width: UIScreen.main.bounds.size.width - 32, height: 130)
    
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        navigationItem.title = "Сегодня"
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCell")
        collectionView.register(ProgressCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ProgressCollectionViewCell")
        collectionView.backgroundColor = const.rgbGray
        collectionView.dataSource = self
        collectionView.delegate = self
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.reloadData()
    }
    
    func setupNavBar() {
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            primaryAction: .init(handler: { _ in
                let vc = HabitViewController()
                vc.delegate = self
                vc.navigationItem.title = "Создать"
                let navigationController = UINavigationController(rootViewController: vc)
                self.present(navigationController, animated: true, completion: nil)
            }))
        rightBarButton.tintColor = const.rgbPurple
        navigationItem.setRightBarButton(rightBarButton, animated: false)
    }
    
    func setupViews() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HabitsViewController: CreateNewHabitDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func createLabelNewHabit(_ text: String) {
        print("")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width - 32, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "ProgressCollectionViewCell", for: indexPath) as? ProgressCollectionViewCell
            headerView?.configureProgressCell()
            
            // Customize the header view
            
            return headerView ?? UICollectionReusableView()
        }
        
        // Return a default UICollectionReusableView for other kinds of supplementary views (if any)
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        HabitsStore.shared.habits.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let habbit = HabitsStore.shared.habits[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCell", for: indexPath) as? HabitCollectionViewCell
        cell?.configureCell(habbit)
        cell?.cellButton.addAction(UIAction(handler: { _ in
            HabitsStore.shared.track(habbit)
            collectionView.reloadData()
        }) , for: .touchUpInside)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        ItemInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        sizeForItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let habit = HabitsStore.shared.habits[indexPath.item]
        let vc = HabitDetailsViewController(habit: habit)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HabitsViewController: HabitsChangeProtocol {
    func habitsDidChange() {
        collectionView.reloadData()
    }
}
