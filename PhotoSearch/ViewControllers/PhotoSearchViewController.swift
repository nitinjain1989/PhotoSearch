//
//  ViewController.swift
//  PhotoSearch
//
//  Created by NItin Jain  on 13/09/18.
//  Copyright © 2018 NItin Jain . All rights reserved.
//

import UIKit

class PhotoSearchViewController: UIViewController
{
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var searchBar: UISearchBar!
    var viewModel:PhotoViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addSerachBarOnNavigationBar()
        self.setUpViewModel()
        self.setUpCollectionView()
    }
    
    //MARK: Add Search Bar
    //This function is used to add Search Bar on Navigation Bar
    private func addSerachBarOnNavigationBar()
    {
        searchBar = UISearchBar(frame: CGRect.zero)
        searchBar.placeholder = "Search Images"
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    //MARK: Set Up CollectionView
    
    private func setUpCollectionView()
    {
        let nibName = UINib(nibName: "PhotoCollectionViewCell", bundle:nil)
        searchCollectionView.register(nibName, forCellWithReuseIdentifier: "photoCell")
        
        if let layout = self.searchCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
        }
    }
    
    //MARK: Set Up View Model
    
    private func setUpViewModel()
    {
        self.viewModel = PhotoViewModel()
        self.viewModel.listener = { [weak self] in
            guard let sself = self else {
                return
            }
            DispatchQueue.main.async {
                if sself.viewModel.photos.count > 0
                {
                    sself.activityIndicator.stopAnimating()
                }
                sself.searchCollectionView.reloadData()
            }
        }
    }
}

//MARK: CollectionView  DataSource Functions
extension PhotoSearchViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = self.viewModel.photos[indexPath.row]
        cell.setDataOnCell(photo)
        return cell
    }
}

extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellSpace:CGFloat = 10
        let itemPerRow:CGFloat = 3
        let width = (Constants.kScreenWidth - (cellSpace * itemPerRow - 1) )/itemPerRow
        return CGSize(width: width, height: width)
    }
}
//MARK: ScrollView Deleagte Functions
extension PhotoSearchViewController : UIScrollViewDelegate
{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height
        {
            if !self.viewModel.isFetching && self.viewModel.isMoreFetching
            {
                if let text = self.searchBar.text
                {
                    let trimText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !trimText.isEmpty
                    {
                        self.viewModel.pageCount = self.viewModel.pageCount + 1
                        self.viewModel.getSearchData(trimText)
                    }
                }
            }
        }
    }
}

//MARK: Search Bar Deleagte Functions
extension PhotoSearchViewController : UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        self.viewModel.photos.removeAll()
        self.viewModel.pageCount = 1
        if let text = self.searchBar.text
        {
            let trimText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimText.isEmpty
            {
                self.activityIndicator.startAnimating()
                self.viewModel.getSearchData(trimText)
            }
        }
    }
}

