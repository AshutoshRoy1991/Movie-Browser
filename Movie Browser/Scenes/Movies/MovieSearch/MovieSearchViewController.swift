//
//  MovieSearchViewController.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 19/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var placeHolderView: UIView!
    @IBOutlet weak var searchPlaceHolderLabel: UILabel!
    
    @IBOutlet weak var searchedResultCollectionView: UICollectionView!
    
    var estimatedWidth = 150
    var cellMargin = 16
    
    var viewModel = MovieSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        searchedResultCollectionView.register(UINib(nibName: "moviewListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviewListCollectionViewCell")
    }
    
    func setUpGridView() {
        let grid = searchedResultCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        grid.minimumInteritemSpacing = CGFloat(self.cellMargin)
        grid.minimumLineSpacing = CGFloat(self.cellMargin)
    }
    
    override func viewDidLayoutSubviews() {
        setUpGridView()
        DispatchQueue.main.async {
            self.searchedResultCollectionView.reloadData()
        }
    }
    
}

extension MovieSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "" {
            self.placeHolderView.isHidden = false
            self.searchedResultCollectionView.isHidden = true
            searchBar.resignFirstResponder()
        }
//        if searchText != "" {
//            viewModel.searchMovies(searchText: searchText) {
//                if(self.viewModel.moviesData.count>0)
//                {
//                    DispatchQueue.main.async {
//                        self.placeHolderView.isHidden = true
//                        self.searchedResultCollectionView.isHidden = false
//                        self.searchedResultCollectionView.reloadData()
//                    }
//                }
//                else {
//                    DispatchQueue.main.async {
//                        self.placeHolderView.isHidden = false
//                        self.searchedResultCollectionView.isHidden = true
//                    }
//                }
//            }
//            print(searchText)
//        }
//        else {
//            self.placeHolderView.isHidden = false
//            self.searchedResultCollectionView.isHidden = true
//            searchBar.resignFirstResponder()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText != "" {
            viewModel.searchMovies(searchText: searchText) {
                if(self.viewModel.moviesData.count>0)
                {
                    DispatchQueue.main.async {
                        self.placeHolderView.isHidden = true
                        self.searchedResultCollectionView.isHidden = false
                        self.searchedResultCollectionView.reloadData()
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.placeHolderView.isHidden = false
                        self.searchedResultCollectionView.isHidden = true
                    }
                }
            }
            print(searchText)
        }
        else {
            self.placeHolderView.isHidden = false
            self.searchedResultCollectionView.isHidden = true
            searchBar.resignFirstResponder()
        }
        searchBar.resignFirstResponder()
    }
    
    
}


extension MovieSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.moviesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviewListCollectionViewCell", for: indexPath) as! moviewListCollectionViewCell
        let movie = viewModel.moviesData[indexPath.row]
        cell.title.text = movie.title
        cell.rating.text = "Rating \(movie.voteAverage)"
        
        var posterURL: URL?
        let posterpath = movie.posterPath
        posterURL = URL(string: URLConfiguration.mediaPath + (posterpath ?? ""))
        
        cell.posterImage.image = UIImage(named: "example")
        cell.posterImage.kf.setImage(with: posterURL)
        cell.posterImage.kf.setImage(with: posterURL,
                                     placeholder: UIImage(named: "placeHolderImage"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = viewModel.moviesData[indexPath.row]
        
        if let aViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
            aViewController.viewModel = MovieDetailViewModel(movie)
            self.navigationController?.pushViewController(aViewController, animated: true)
        }
    }
}

extension MovieSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        return CGSize(width: width, height: width)
    }
    func calculateWidth() -> CGFloat {
        let calculatedWidth = CGFloat(estimatedWidth)
        let cellCount = floor(CGFloat(self.view.frame.size.width/calculatedWidth))
        
        let margin = CGFloat(cellMargin * 2)
        let width = (self.view.frame.size.width - CGFloat(cellMargin) * (cellCount-1) - margin) / cellCount
        return width
    }
}
