//
//  CalendarViewController.swift
//  ReminderAppProject
//
//  Created by Madeline on 2/19/24.
//

import FSCalendar
import RealmSwift
import SnapKit
import UIKit

class CalendarViewController: BaseViewController {

    let tableView = UITableView()
    let calendar = FSCalendar()
    let repository = RealmRepository()
    let dateFormat = DateFormatter()
    let realm = try! Realm()
    var list: Results<ReminderTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormat.dateFormat = "yyyy년 MM월 dd일 hh시"
        list = repository.fetchItem("deadline")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()

    }
    
    override func configureHeirarchy() {
        view.addSubview(tableView)
        view.addSubview(calendar)
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(500)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(calendar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView() // BaseViewController의 내용도 실행해
        
        // MARK: FSCalendar
        calendar.delegate = self
        calendar.dataSource = self
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "mainCell")
        tableView.backgroundColor = .buttonGray
        
        navigationItem.title = "캘린더"
        navigationItem.titleView?.tintColor = .white
        
        let rightitem = UIBarButtonItem(title: "TODAY", style: .plain, target: self, action: #selector(todayBarButtonItemTapped))
        navigationItem.rightBarButtonItem = rightitem
        
        let leftitem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = leftitem
        
        // MARK: 데이터베이스 필터 기능 추가
        
        
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func todayBarButtonItemTapped() {
        
        let start = Calendar.current.startOfDay(for: Date())
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
    
        list = realm.objects(ReminderTable.self).filter(predicate)
        
        tableView.reloadData()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell")!
        let row = list[indexPath.row]
        
        cell.backgroundColor = .buttonGray
        cell.textLabel?.text = "✅ \(row.title) \(row.memo)"
        cell.textLabel?.textColor = .white
        
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let start = Calendar.current.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
    
        list = realm.objects(ReminderTable.self).filter(predicate)
        tableView.reloadData()
        let events = min(list.count, 3)
        return events
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let start = Calendar.current.startOfDay(for: date)
        let end: Date = Calendar.current.date(byAdding: .day, value: 1, to: start) ?? Date()
        let predicate = NSPredicate(format: "deadline >= %@ && deadline < %@", start as NSDate, end as NSDate)
    
        list = realm.objects(ReminderTable.self).filter(predicate)
        tableView.reloadData()
    }
}

