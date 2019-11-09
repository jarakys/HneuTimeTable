//
//  DayCollectionViewCell.swift
//  HneuTimeTable
//
//  Created by Kirill on 23.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    static let reusableIdentifier = "dayCell"
    
    private lazy var scheduleTableView: UITableView = { [weak self] in
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: ScheduleTableViewCell.reusableIdentifier)
        return tableView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.addSubview(scheduleTableView)
        createConstraint()
    }
    
    private func createConstraint() {
        scheduleTableView.translatesAutoresizingMaskIntoConstraints = false
        scheduleTableView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 60).isActive = true
        scheduleTableView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        scheduleTableView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        scheduleTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
}

extension DayCollectionViewCell : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension DayCollectionViewCell : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTableViewCell.reusableIdentifier, for: indexPath) as! ScheduleTableViewCell
        cell.auditoryName.text = "404"
        return cell
    }
    
    
}
