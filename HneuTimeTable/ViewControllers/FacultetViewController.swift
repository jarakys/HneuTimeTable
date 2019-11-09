//
//  FacultetViewController.swift
//  HneuTimeTable
//
//  Created by Kirill on 19.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class FacultetViewController: UIViewController {

    @IBOutlet weak var facultiesTableView: UITableView! {
        didSet {
            self.facultiesTableView.delegate = self
            self.facultiesTableView.dataSource = self
        }
    }
    
    var faculties:faculties?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIClient.getFaculteties(completion: {
            res in
            self.faculties = res
            self.facultiesTableView.reloadData()
        })
//        if #available(iOS 13.0, *) {
//            let appearance = UINavigationBarAppearance()
//            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//            navigationController?.navigationBar.prefersLargeTitles = true
//            navigationController?.navigationBar.backgroundColor = .white
//            appearance.backgroundColor = .white
//            appearance.shadowImage = UIImage()
//            navigationItem.title = "Факультеты"
//            navigationController?.navigationBar.isTranslucent = false
//            navigationController!.navigationBar.shadowImage = UIImage()
//            navigationItem.standardAppearance = appearance
//            navigationItem.compactAppearance = appearance
//            navigationItem.scrollEdgeAppearance = appearance
//        } else {
//            UINavigationBar.appearance().tintColor = .white
//            UINavigationBar.appearance().barTintColor = .purple
//            UINavigationBar.appearance().isTranslucent = false
//        }
        // Do any additional setup after loading the view.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SpecialtyViewController {
            
        }
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

extension FacultetViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "specialtyVC") as! SpecialtyViewController
        controller.data = faculties!.element[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension FacultetViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        faculties?.element.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "facultetCell", for: indexPath)
        if let nameFacultet = cell.viewWithTag(1) as? UILabel {
            nameFacultet.text = faculties!.element[indexPath.row].displayName
        }
        return cell
    }
    
    
}
