//
//  ViewController.swift
//  firstapp
//
//  Created by Наталья Захарова on 12.09.2023.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(normalizeGrades())
    }
    
    
    func normalizeGrades() -> [String: Double] {
        IOSNis.students = [
            Student(grades: [3.51, 10, 9], fullName: "Ушакова Ангелина"),
            Student(grades: [7, 8, 7.5], fullName: "Алибек Адхамов"),
            Student(grades: [6, 5, 9], fullName: "Котиков Александр"),
            Student(grades: [5, 6, 9], fullName: "Cобачкин  Михаил"),
            Student(grades: [3.8, 9, 6], fullName: "Капибарин  Алексей"),
        ]
        
        var normalizedGrades: [String: Double] = [:]
        
        
        var maxGrade = 0.0
        for student in IOSNis.students {
            if student.getGrade() > maxGrade
            {
                maxGrade = student.getGrade();
            }
        }
        
        // Normalize the ratings and add them to the dictionary.
        
        for student in IOSNis.students {
            var normalizedGrade = student.getGrade()
            if maxGrade != 10 {
                normalizedGrade = normalizedGrade * (10 / maxGrade)
            }
            normalizedGrades[student.fullName] = normalizedGrade
        }
        
        return normalizedGrades
    }
}

