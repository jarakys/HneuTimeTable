//
//  SpecialtyViewController.swift
//  HneuTimeTable
//
//  Created by Kirill on 20.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class SpecialtyViewController: UIViewController {

    @IBOutlet weak var specialtyTableView: UITableView! {
        didSet {
            self.specialtyTableView.delegate = self
            self.specialtyTableView.dataSource = self
        }
    }
    public var data:element!
    private var specialties:specialities?
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getSpecialties(facultId: data.id, completion: { specialities in
            self.specialties = specialities
            self.specialtyTableView.reloadData()
        })
        // Do any additional setup after loading the view.
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

extension SpecialtyViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "addGroupVC") as! AddGroupViewController
        controller.data = (specialtyId:specialties!.element[indexPath.row].id, facultId:data.id )
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension SpecialtyViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specialties?.element.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "specialtyCell", for: indexPath)
        if let specialtyName = cell.viewWithTag(1) as? UILabel {
            specialtyName.text = specialties!.element[indexPath.row].displayName
        }
        return cell
    }
    
    
}
