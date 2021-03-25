//
//  CollectionViewCell.swift
//  Assesment Test
//
//  Created by Kalyan Thakur on 24/03/21.
//

import UIKit
import SwiftCake

class CollectionViewCell: UICollectionViewCell, SCReusableCell {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
