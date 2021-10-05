//
//  FeedTableViewController.swift
//  InfiniteScrollCodeChallenge
//
//

import UIKit
import Combine

class TableViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        tableview.accessibilityIdentifier = "MainTableView"
        return tableview
    }()
    private let feedViewModel = RedditViewModel()
    private var subscribers = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        setupBinding()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    // MARK: Binding setup
    private func setupBinding() {
        feedViewModel
            .feedsBinding
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &subscribers)
        
        
        
        handleErrorBinding()
        
        feedViewModel.loadFeeds()
        
        
        updateBinding()
        
       
    }
    
    private func handleErrorBinding()
    {
        feedViewModel
            .errorBinding
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink {
                errorMessage in
                print("Error occured ----->\(errorMessage)")
            }
            .store(in: &subscribers)
        
    }
    private func updateBinding()
    {
        feedViewModel
            .rowUpdateBinding
            .dropFirst()
            .receive(on: RunLoop.main)
            .sink { [weak self] row in
                self?.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
            .store(in: &subscribers)
    }
    
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            return UITableViewCell()
        }
        let title = feedViewModel.getTitle(at: indexPath.row)
        let numComments = feedViewModel.getNumComments(at: indexPath.row)
        let imageData = feedViewModel.getImageData(at: indexPath.row)
        let score = feedViewModel.getScore(at: indexPath.row)
        cell.configureCell(title: title, score: score, numComments: numComments, imageData: imageData)
        return cell
    }
    
}

extension TableViewController: UITableViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexes = tableView.indexPathsForVisibleRows ?? []
        let rows = indexes.map { $0.row }
        feedViewModel.visibleRows(rows)
    }
}
