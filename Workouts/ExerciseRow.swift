//
//  ExerciseRow.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/29/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit

enum ExerciseRow {
    case exercise(Exercise)
}

extension ExerciseRow {
    static func buildRows(with exercises: [Exercise]) -> [ExerciseRow] {
        var result: [ExerciseRow] = []
        for i in exercises {
            result.append(.exercise(i))
        }
        return result
    }
    
    static func configure(_ tableview: UITableView) {
        tableview.register(ExerciseTableViewCell.self, forCellReuseIdentifier: ExerciseTableViewCell.identifier)
    }
    
    func cell(for path: IndexPath, in tableView: UITableView) -> UITableViewCell {
        switch self {
        case .exercise(let exercise):
            let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableViewCell.identifier, for: path) as! ExerciseTableViewCell
            cell.configure(with: exercise)
            return cell
        }
    }
}
