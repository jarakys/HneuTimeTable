//
//  ScheduleViewController.swift
//  HneuTimeTable
//
//  Created by Kirill on 23.10.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var currentDayStackView: UIStackView!
    @IBOutlet weak var daysOfWeekCollectionView: UICollectionView!
    @IBOutlet weak var dayCollectionView: UICollectionView! {
        didSet {
            self.dayCollectionView.delegate = self
            self.dayCollectionView.dataSource = self
            self.dayCollectionView.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: DayCollectionViewCell.reusableIdentifier)
        }
    }
    @IBOutlet weak var qwe: UICollectionView! {
        didSet {
            self.dayCollectionView.delegate = self
            self.dayCollectionView.dataSource = self
        }
    }
    private var handler:DaysOfWeekHandler!
    private var progressBarTimer: Timer!
    private var progress: Progress!
    private lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.progressViewStyle = .default
        progress.progress = 0.0
        progress.tintColor = .red
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handler =  DaysOfWeekHandler(items: ["Пн","Вт","Ср","Чт","Пт","Сб"])
        daysOfWeekCollectionView.delegate = handler
        daysOfWeekCollectionView.dataSource = handler
        progress = Progress(totalUnitCount: 30)
        progressView.progress = 0
        //progressView.progressImage = UIImage(named: "refresh")
        //attachProgressView()
        // Do any additional setup after loading the view.
    }
    
    private func attachProgressView() {
        self.view.addSubview(progressView)
        self.progressBarTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(ScheduleViewController.updateProgressView), userInfo: nil, repeats: true)
        createConstraint()
    }
    
    private func createConstraint() {
        progressView.topAnchor.constraint(equalTo: currentDayStackView.bottomAnchor, constant: 20).isActive = true
        progressView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        progressView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
        progressView.transform = CGAffineTransform(rotationAngle: .pi * -0.5)
    }
    
    @objc func updateProgressView(){
        progress.completedUnitCount += 1
        progressView.progress += 1
        progressView.setProgress(progressView.progress, animated: true)
        if(progressView.progress == 30.0)
        {
            progressBarTimer.invalidate()
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

extension ScheduleViewController : UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
      }
}

extension ScheduleViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCollectionViewCell.reusableIdentifier, for: indexPath)
        return cell
    }
    
    
}
