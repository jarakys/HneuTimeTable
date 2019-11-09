//
//  AddGroupViewController.swift
//  HneuTimeTable
//
//  Created by Kirill on 20.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController {

    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var groupsTableView: UITableView! {
        didSet {
            self.groupsTableView.delegate = self
            self.groupsTableView.dataSource = self
        }
    }
    private lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.isHidden = true
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    public var data:(specialtyId:Int,facultId:Int)!
    private var course: Int = 1
    private var groups:groups?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        view.addSubview(picker)
        picker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        picker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        getData()
    }
    
    private func getData() {
        APIClient.getGroups(facultId: data.facultId, specialtyId: data.specialtyId, course: course, completion: {res in
            if let _groups = try? res.get() {
                self.groups = _groups
            }
            else {
                self.groups?.element = []
            }
            self.groupsTableView.reloadData()
        })
        
    }
    
    @IBAction func changeCourseAction(_ sender: Any) {
        picker.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AddGroupViewController : UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedElement = groups!.element.remove(at: indexPath.row)
        let group = Groups()
        group.displayName = selectedElement.displayName
        group.id = Int64(selectedElement.id)
        CoreDataManager.instance.saveContext()
        groupsTableView.beginUpdates()
        groupsTableView.deleteRows(at: [indexPath], with: .right)
        groupsTableView.endUpdates()
//        UIView.animate(withDuration: 0.3, animations: {
//            cell?.alpha = 0
//        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension AddGroupViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.element.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupsCell", for: indexPath)
        if let groupName = cell.viewWithTag(1) as? UILabel {
            groupName.text = groups!.element[indexPath.row].displayName
        }
        return cell
    }
}

extension AddGroupViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (row+1).description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        course = (row+1)
        courseLabel.text = course.description
        getData()
    }
}

extension AddGroupViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
}
