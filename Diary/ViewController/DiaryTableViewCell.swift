//
//  DiaryTableViewCell.swift
//  Diary
//
//  Created by yyss99, Jusbug on 2023/08/29.
//

import UIKit

final class DiaryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        createdDateLabel.text = nil
        bodyLabel.text = nil
    }
    
    func configureLabel(entity: Entity) {
        let date = entity.date
       // print("label: \(date)")
        let formattedSampleDate = CustomDateFormatter.formatSampleDate(sampleDate: date)

        createdDateLabel.text = formattedSampleDate
        titleLabel.text = entity.title
        bodyLabel.text = entity.body
    }
}
