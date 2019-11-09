//
//  ScheduleTableViewCell.swift
//  HneuTimeTable
//
//  Created by Kirill on 23.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    static let reusableIdentifier = "scheduleCell"
    
    public lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .fill
        stack.spacing = 5
        return stack
    }()
    
    public lazy var subjectName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 1
        label.textColor = .black
        label.text = "Программирование"
        return label
    }()
    
    public lazy var type: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Лукция"
        label.textAlignment = .right
        label.numberOfLines = 1
        label.textColor = .black
        return label
    }()
    
    public lazy var auditoryName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.text = "404"
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    public lazy var teacherName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = .black
        label.text = "Гринев Д."
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.backgroundColor = .green
        teacherName.text = " {Eq"
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(stackView)
        stackView.addArrangedSubview(subjectName)
        stackView.addArrangedSubview(type)
        stackView.addArrangedSubview(auditoryName)
        stackView.addArrangedSubview(teacherName)
        createConstaint()
    }
    
    func createConstaint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
