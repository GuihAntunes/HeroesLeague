//
//  HeroesListViewController.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var listTableView: UITableView!
    
    // MARK: - Properties
    weak var viewModel: HeroesListViewModelProtocol?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    // MARK: - Setup Methods
    private func setupTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func loadData() {
        viewModel?.loadHeroes()
    }

}
