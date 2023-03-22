//
//  OptionCell.swift
//  quizzy
//
//  Created by DONIYORBEK IBROKHIMOV on 15/03/23.
//

import UIKit

class OptionCell: UITableViewCell {
    
    @IBOutlet weak var optionCellLabel: UILabel!
    
    func setOption(_ option: String) {
        optionCellLabel.text = option
    }
}
