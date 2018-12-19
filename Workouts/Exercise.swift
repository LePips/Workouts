//
//  Exercise.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/29/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import Foundation

private let muscles = ["chest", "forearms", "lats",
                       "middle-back", "lower-back", "neck",
                       "quadriceps", "hamstrings", "calves",
                       "triceps", "traps", "shoulders",
                       "abdominals", "glutes", "biceps",
                       "adductors", "abductors"]

struct Exercise {
    let title: String
    let muscle: String
    let equipment: String
    let link: String
    let imageLinks: [String]
    
    func filter(_ text: String) -> Bool {
        return title.lowercased().contains(text.lowercased()) ||
                muscle.lowercased().contains(text.lowercased()) ||
                equipment.lowercased().contains(text.lowercased())
    }
    
    static func parseExercises() -> [Exercise] {
        var result: [Exercise] = []
        var contentsArray: [String] = []
        for muscle in muscles {
            let path = Bundle.main.path(forResource: muscle, ofType: "txt", inDirectory: "Exercises")
            let contents = try? String(contentsOfFile: path!)
            
            contents?.enumerateLines(invoking: { (line, stop) in
                contentsArray.append(line)
            })
        }
        var aExercise: [String] = []
        var a = 0
        for i in contentsArray {
            if i == "" {
                let imageLinkAmount = a - 4
                var imageLinks: [String] = []
                for x in 1...imageLinkAmount {
                    imageLinks.append(aExercise[x + 3])
                }
                let exercise = Exercise(title: aExercise[0], muscle: aExercise[1], equipment: aExercise[2], link: aExercise[3], imageLinks: imageLinks)
                result.append(exercise)
                aExercise = []
                a = 0
            } else {
                aExercise.append(i)
                a += 1
            }
        }
        return result
    }
}
