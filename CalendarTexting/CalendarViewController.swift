//
//  ViewController.swift
//  CalendarTexting
//
//  Created by Jairo Millan on 8/20/19.
//  Copyright © 2019 Jairo Millan. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    // Add the variables for
    // Persistance container
    // ViewContainer
    var currentMonth = String()
    var touchedDate:Date?
    
    @IBAction func PreviewsButton(_ sender: UIButton) {
        date = date.datePreviousMonth()!
        updateCalendar()
    }
    @IBAction func NextButton(_ sender: UIButton) {
        date = date.dateNextMonth()!
        updateCalendar()
    }
    
    
    @IBOutlet weak var Test2: UILabel!
    @IBOutlet weak var Test1: UILabel!
    
    @IBOutlet weak var MonthLabel: UILabel! {
        didSet {
            self.MonthLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var CalendarCVC: UICollectionView!{
        didSet {
//            self.CalendarCVC.allowsSelection = true
            //self.CalendarCVC.allowsMultipleSelection = true
        }
    }
        
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentMonth = monthCaracter
        MonthLabel.text = "\(currentMonth) \(year)"
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return daysInMonth[month]
        return 42 // 6 weeks
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCV", for: indexPath) as! dateCollectionViewCell
        cell.date = date0.daysAdded(addDays: indexPath.row)
        //print("add -25 days to today get day \(myDate.daysAdded(addDays: -25).dayNumber())")

        cell.backgroundColor = UIColor.clear
        cell.dateLabel.text = "\(date0.daysAdded(addDays: indexPath.row).dayNumber())"
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self,action: #selector(self.touchCell(sender:))))

        return cell
    }

    func updateCalendar(){
        date0 = date.date_0()
        month = calendar.component(.month, from: date)
        year = calendar.component(.year, from: date)
        monthCaracter = calendar.monthSymbols[month-1]
        currentMonth = monthCaracter
        MonthLabel.text = "\(currentMonth) \(year)"
        CalendarCVC.reloadData()
    }
    @objc private func touchCell(sender: UIGestureRecognizer){
        //TODO: Use the right self.performSegue?
        switch sender.state {
        case .ended:
            if let myCell = sender.view as! dateCollectionViewCell? {
//              self.Test1.text = myCell.date!.description                //
                touchedDate = myCell.date
            }
        default:
            break
        }
        
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.Test1.text = date0.daysAdded(addDays: indexPath.row).description
//
//        print("Index Path = \(indexPath)")
//        print(self.CalendarCVC.indexPathsForSelectedItems!)
//    }
}

extension Date {
    // This Month Start
    func getThisMonthStart() -> Date{
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
    func firstDayOfWeekMonth() -> Int {
        return Calendar.current.component(.weekday, from: self.getThisMonthStart())
    }
    func date_0() -> Date {
        //MARK: date start for a calendar month with 6 weeks
        return Calendar.current.date(byAdding: .day, value: -self.firstDayOfWeekMonth() + 1, to: self.getThisMonthStart())!
    }
    func daysAdded(addDays:Int ) -> Date {
        return Calendar.current.date(byAdding: .day, value: addDays, to: self)!
    }
    func dayNumber() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    func datePreviousMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)
    }
    func dateNextMonth() -> Date? {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)
    }
    func getThisWeekStart() -> Date{
        // Today's date minus (Day of week today's date)
        // Get day of week of today's date
        let dayOfWeek = Calendar.current.component(.weekday, from: self)
        return Calendar.current.date(byAdding: .day, value: dayOfWeek, to: self)!
    }
}
