//
//  RoutesListViewController.swift
//  Maps
//
//  Created by Alex on 25/11/17.
//  Copyright © 2017 Alex. All rights reserved.
//

import UIKit

class RoutesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Properties
    private var locationsDataArray = [LocationData]()
    private var isFirstLoad: Bool = true
    
    // MARK: - Life Cycle Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTableView()
        registerCell()
        getLocationsData()
        self.title = "Routes"
    }
    
    // MARK: - Private Functions
    private func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 234
        tableView.backgroundColor = #colorLiteral(red: 0.8964430094, green: 0.8964430094, blue: 0.8964430094, alpha: 1)
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 12, 0)
    }
    
    private func registerCell() {
        let nibCell = UINib(nibName: RoutesTableViewCell.getNibName(), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: RoutesTableViewCell.getNibName())
    }
    
    private func getLocationsData() {
        locationsDataArray = UserDefaultsHelper.getLocations().reversed()
        tableView.reloadData()
    }


    // MARK: - TableView Data Source & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsDataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RoutesTableViewCell.getNibName(), for: indexPath) as! RoutesTableViewCell
        cell.setCell(data: locationsDataArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailRouteViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailRouteViewController") as! DetailRouteViewController
        detailRouteViewController.setLocationData(data: locationsDataArray[indexPath.row])
        self.navigationController?.pushViewController(detailRouteViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
