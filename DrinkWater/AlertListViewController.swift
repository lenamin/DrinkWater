//
//  AlertListViewController.swift
//  DrinkWater
//
//  Created by Lena on 2022/07/10.
//

import UIKit
 
class AlertListViewController: UITableViewController {
    
    var alerts: [Alert] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "AlertListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "AlertListCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        alerts = alertList()
    }
    
    @IBAction func addAlertButtonAction(_ sender: UIBarButtonItem) {
        guard let addAlertViewController = storyboard?.instantiateViewController(withIdentifier: "AddAlertViewController") as? AddAlertViewController else { return }
        
        addAlertViewController.pickedDate = {[weak self] date in
            guard let self = self else { return }
            
            var alertList = self.alertList() // userDefaults에서 가져온 list이다
            
            let newAlert = Alert(date: date, isOn: true)
            
            alertList.append(newAlert)
            alertList.sort { $0.date < $1.date } // 시간 순서대로 보이도록 정렬해준다
            
            self.alerts = alertList
            
            self.tableView.reloadData()
        }
        
        self.present(addAlertViewController, animated: true, completion: nil)
        
        // 생성된 알람을 리스트에 표현되도록 클로저를 구현하기
    }
    
    func alertList() -> [Alert] {
        // key가 alerts인 값을 내뱉어줄 것
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              // 우리가 원하는 값으로 디코딩해주기 위한 코드
                let alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return [] }
        // 내부 저장소인 userdefaults는 임의로 만든 구조체를 이해하지 못하기 때문에 이해할 수 있게 디코딩 해주는 과정임
        return alerts
    }
    
}

extension AlertListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alerts.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "🫙 물 마실 시간"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlertListCell", for: indexPath) as? AlertListCell else { return UITableViewCell() }
        
        cell.alertSwitch.isOn = alerts[indexPath.row].isOn
        cell.timeLabel.text = alerts[indexPath.row].time
        cell.meridiemLabel.text = alerts[indexPath.row].meridiem
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    /// tableViewCell 삭제가 가능하다
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            // MARK: notification 삭제 구현할 것
            return
            
        default:
            break
        }
    }
}
