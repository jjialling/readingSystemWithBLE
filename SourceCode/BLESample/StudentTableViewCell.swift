//
//  StudentTableViewCell.swift
//  BLESample
//
//  Created by 蔡佳玲 on 2023/11/12.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardIDLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var studentIDLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var classroomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
