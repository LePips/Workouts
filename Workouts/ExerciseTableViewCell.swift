//
//  ExerciseTableViewCell.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/29/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips

class ExerciseTableViewCell: BasicTableViewCell {
    static var neededHeight: CGFloat {
        return 70
    }
    
    func configure(with exercise: Exercise) {
        title.text = exercise.title
        muscleLabel.text = exercise.muscle.substring(from: 16)
        
        _ = title
        _ = muscleLabel
    }
    
    private lazy var title: UILabel = self.makeTitle()
    private func makeTitle() -> UILabel {
        let title = UILabel.forAutoLayout()
        
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor ⩵ contentView.centerYAnchor - 5,
            title.leftAnchor ⩵ contentView.leftAnchor + 15
            ])
        
        return title
    }
    
    private lazy var muscleLabel: UILabel = self.makeMuscleLabel()
    private func makeMuscleLabel() -> UILabel {
        let muscleLabel = UILabel.forAutoLayout()
        
        contentView.addSubview(muscleLabel)
        NSLayoutConstraint.activate([
            muscleLabel.topAnchor ⩵ title.bottomAnchor + 5,
            muscleLabel.leftAnchor ⩵ contentView.leftAnchor + 15
            ])
        
        muscleLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        muscleLabel.textColor = UIColor.gray
        
        return muscleLabel
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }
}
