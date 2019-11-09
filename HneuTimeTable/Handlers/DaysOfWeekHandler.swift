//
//  DaysOfWeekHandler.swift
//  HneuTimeTable
//
//  Created by Kirill on 09.11.2019.
//  Copyright © 2019 Kirill. All rights reserved.
//

import UIKit

class DaysOfWeekHandler: NSObject {
    private let items:[String]
    
    init(items: [String]) {
        self.items = items
    }
}

extension DaysOfWeekHandler : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / CGFloat(exactly: items.count+2)!), height: collectionView.bounds.height)
    }
}

extension DaysOfWeekHandler : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(items.count)
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    
}
