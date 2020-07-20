//
//  HeroDetailViewController.swift
//  HeroesLeague
//
//  Created by Guilherme Antunes Ferreira on 20/07/2020.
//  Copyright © 2020 Guihsoft. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var detailsListTableView: UITableView!
    
    // MARK: - Properties
    weak var viewModel: HeroDetailViewModelProtocol?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Setup Methods
    private func setupTableView() {
        detailsListTableView.dataSource = self
        detailsListTableView.delegate = self
    }
    
    private func setupView() {
        title = viewModel?.getTitle()
        detailsListTableView.reloadData()
    }

}
