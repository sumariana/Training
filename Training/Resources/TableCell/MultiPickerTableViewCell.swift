//
//  MultiPickerTableViewCell.swift
//  Training
//
//  Created by TimedoorMSI on 03/12/21.
//

import UIKit

class MultiPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var tvLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // update UI
        accessoryType = selected ? .checkmark : .none
    }

}
