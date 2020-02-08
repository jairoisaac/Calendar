//
//  dateCollectionViewCell.swift
//  CalendarTexting
//
//  Created by Jairo Millan on 8/20/19.
//  Copyright © 2019 Jairo Millan. All rights reserved.
//

import UIKit

class dateCollectionViewCell: UICollectionViewCell {

    var date:Date?
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            self.dateLabel.textAlignment = .center
        }
    }
}
