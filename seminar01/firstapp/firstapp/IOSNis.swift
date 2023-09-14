//
//  IOSNis.swift
//  firstapp
//
//  Created by Наталья Захарова on 14.09.2023.
//

final class Student {
    var grades: [Double] = []
    var fullName: String

    init(grades: [Double] = [], fullName: String) {
        self.grades = grades
        self.fullName = fullName
    }

    func getGrade() -> Double {
        var sum = 0.0

        for grade in grades {
            sum += grade
        }

        return sum / Double(grades.count)
    }
}

final class IOSNis {
    static var students: [Student] = []
}
