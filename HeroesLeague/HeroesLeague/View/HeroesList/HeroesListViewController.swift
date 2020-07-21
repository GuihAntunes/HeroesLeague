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
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Properties
    weak var viewModel: HeroesListViewModelProtocol?
    var searchIsActive = false
    var selectedIndexPath: IndexPath?
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteIfNeeded()
    }
    
    // MARK: - Setup Methods
    private func setupTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func setupView() {
        title = viewModel?.getTitle()
        searchBar.delegate = self
    }
    
    private func loadData() {
        viewModel?.loadHeroes()
    }
    
    private func updateFavoriteIfNeeded() {
        guard let indexPath = selectedIndexPath else { return }
        listTableView.reloadRows(at: [indexPath], with: .none)
    }

}
