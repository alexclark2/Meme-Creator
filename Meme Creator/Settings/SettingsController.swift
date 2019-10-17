//
//  SetingsController.swift
//  Meme Creator
//
//  Created by MACBOOK on 10/17/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


private let reuseIdentifier = "SettingsCell"

class SettingsController: UIViewController {
    
    // MARK: - Properties
    var tableView: UITableView!
    var userInfoHeader: UserInfoHeader!
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Helper Functions
    func configureTableView() {
        self.showIndicator(withTitle: "Loading Settings", and: "")
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = userInfoHeader
        tableView.tableFooterView = UIView()
    }
    
    func configureUI() {
        configureTableView()
        navigationController?.navigationBar.isTranslucent = true
        self.hideIndicator() 
    }
    
}
extension SettingsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .Authentication: return AuthOptions.allCases.count
        case .Store: return StoreOptions.allCases.count
        case .Social: return SocialOptions.allCases.count
        case .General: return GeneralOptions.allCases.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0/255, green: 87/255, blue: 127/255, alpha: 1)
        
        print("Section is \(section)")
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text = SettingsSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .Authentication:
            let Authentication = AuthOptions(rawValue: indexPath.row)
            cell.sectionType = Authentication
        case .Store:
            let Store = StoreOptions(rawValue: indexPath.row)
            cell.sectionType = Store
        case .Social:
            let Social = SocialOptions(rawValue: indexPath.row)
            cell.sectionType = Social
        case .General:
            let General = GeneralOptions(rawValue: indexPath.row)
            cell.sectionType = General
            
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .Authentication:
            let auth = (AuthOptions(rawValue: indexPath.row)?.description as Any)
            self.performSegue(withIdentifier: auth as! String, sender: self)
            print(AuthOptions(rawValue: indexPath.row)?.description as Any)
        case .Store:
            let store = (StoreOptions(rawValue: indexPath.row)?.description as Any)
            self.performSegue(withIdentifier: store as! String, sender: self)
            print(StoreOptions(rawValue: indexPath.row)?.description as Any)
        case .Social:
            let social = (SocialOptions(rawValue: indexPath.row)?.description as Any)
            self.performSegue(withIdentifier: social as! String, sender: self)
            print(SocialOptions(rawValue: indexPath.row)?.description as Any)
        case .General:
            let general = (GeneralOptions(rawValue: indexPath.row)?.description as Any)
            self.performSegue(withIdentifier: general as! String, sender: self)
            print(GeneralOptions(rawValue: indexPath.row)?.description as Any)
        }
    }
}

