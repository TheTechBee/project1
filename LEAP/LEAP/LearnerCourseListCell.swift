//
//  LearnerCourseListCell.swift
//  LEAP
//
//  Created by Magic on 17/07/15.
//  Copyright (c) 2015 Magic Software Private Limited. All rights reserved.
//

import UIKit

class LearnerCourseListCell: UITableViewCell {

    
    @IBOutlet weak var courseTitle:UILabel!
    @IBOutlet weak var scoreImage:UIImageView!
    @IBOutlet weak var courseDuration:UILabel!
    @IBOutlet weak var courseProgress:UIProgressView!
    @IBOutlet weak var coursePlayButton:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
