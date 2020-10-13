//
//  ViewController.swift
//  FlickrSearch
//
//  Created by Preema DSouza on 10/10/2020.
//  Copyright © 2020 Preema DSouza. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var photosCollectionView: UICollectionView!
    private let searchController = UISearchController(searchResultsController: nil)
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private let itemsPerRow: CGFloat = 2
    
    var viewModel: PhotosViewModel! {
        didSet {
            viewModel.photos.bind { [unowned self] _ in
                DispatchQueue.main.async {
                    self.photosCollectionView.reloadData()
                }
            }
            viewModel.errorMessage.bindAndFire { [unowned self] errorMessage in
                if let message = errorMessage, !message.isEmpty {
                    DispatchQueue.main.async {
                        self.showAlertView(with: message)
                    }
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        viewModel = PhotosViewModel()
    }
    
    /// Set up search bar
    fileprivate func setUpSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }

    @IBAction func historyButtonDidTouch(_ sender: Any) {
        performSegue(withIdentifier: "HistorySegue", sender: self)
    }
    
    /// Method that resets scroll to the top of the collection view
    fileprivate func scrollCollectionViewToTop() {
        if photosCollectionView.numberOfItems(inSection: 0) != 0 {
            photosCollectionView.scrollToItem(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "HistorySegue", let destination = segue.destination as? HistoryViewController else {
            return
        }
        destination.delegate = self
    }
    
}

// MARK: - CollectionView delegate and datasource

extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPhotos()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        cell.viewModel = viewModel.photoViewModel(for: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.photos.value.count - 1 {
            viewModel.fetchMorePhotos()
        }
    }
    
}

// MARK: - Search bar delegate

extension PhotosViewController: UISearchBarDelegate {
     func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        scrollCollectionViewToTop()
        viewModel.seachPhotos(searchTerm: searchBar.text)
    }
}

// MARK: - HistoryViewController delegate 

extension PhotosViewController: HistoryViewControllerDelegate {
    func selectedSearchTerm(text: String) {
        scrollCollectionViewToTop()
        viewModel.seachPhotos(searchTerm: text)
    }
}

// MARK: - AlertView for error
extension PhotosViewController {
    func showAlertView(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

