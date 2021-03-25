//
//  TableViewCell.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 24/03/21.
//

import UIKit
import SwiftCake

class TableViewCell: UITableViewCell, SCReusableCell {
    
    // MARK: Outlets
    @IBOutlet weak var stepNameLabel: UILabel!
    @IBOutlet weak var activityNameLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var activities: ActivitiesParse! {
        didSet {
            self.stepNameLabel.text = activities.stepName
            self.activityNameLabel.text = activities.activityName
            self.progressLabel.text = "\(activities.progress ?? 0)%"
            self.progressView.progress = Float(activities.progress)/100
            switch (activities.progress ?? 0) {
            case let x where x < 30:
                self.progressView.tintColor = UIColor.red
            case let x where x == 60:
                self.progressView.tintColor = UIColor.systemYellow
            case let x where x > 0:
                self.progressView.tintColor = UIColor.systemGreen
            default:
                self.progressView.tintColor = UIColor.red
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
