//
//  BaseViewController.swift
//  Workouts
//
//  Created by Ethan Pippin on 10/29/18.
//  Copyright © 2018 Ethan Pippin. All rights reserved.
//

import UIKit
import SharedPips
import JTAppleCalendar

class BaseViewController: UIViewController {
    
    private lazy var calendar: JTAppleCalendarView = self.makeCalendar()
    private func makeCalendar() -> JTAppleCalendarView {
        let calendar = JTAppleCalendarView.forAutoLayout()
        
        view.addSubview(calendar)
        NSLayoutConstraint.activate([
            calendar.leftAnchor ⩵ view.leftAnchor,
            calendar.rightAnchor ⩵ view.rightAnchor,
            calendar.topAnchor ⩵ view.topAnchor,
            calendar.bottomAnchor ⩵ view.bottomAnchor
            ])
        
        calendar.register(JTAppleCell.self, forCellWithReuseIdentifier: "cell")
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        
        return calendar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.Material.grey100
        
        _ = calendar
    }
}

extension BaseViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as JTAppleCell
        
        return cell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let config = ConfigurationParameters(startDate: Date.distantPast, endDate: Date())
        return config
    }
    
    
}
