//
//  MovieListingViewController.swift
//  Movie Browser
//
//  Created by Ashutosh Roy on 17/07/20.
//  Copyright © 2020 Ashutosh Roy. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListingViewController: UIViewController {
    
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    
    var estimatedWidth = 150
    var cellMargin = 16
    
    var filter : MovieListFilter = .popular
    
    var viewModel = MovieListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Popular Movies"
        
        fetchMovieFromRemote()
        
        // Do any additional setup after loading the view.
        moviesCollectionView.register(UINib(nibName: "moviewListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "moviewListCollectionViewCell")
    }
    
    func fetchMovieFromRemote() {
        viewModel.fetchMovies(currentPage: 1, filter: filter, completion: {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        })
    }
    
    func fetchNextMoviesFromRemote() {
        viewModel.fetchMovies(currentPage: viewModel.nextPage, filter: filter, completion: {
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
            }
        })
    }
    
    func setUpGridView() {
        let grid = moviesCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        grid.minimumInteritemSpacing = CGFloat(self.cellMargin)
        grid.minimumLineSpacing = CGFloat(self.cellMargin)
    }
    
    override func viewDidLayoutSubviews() {
        setUpGridView()
        DispatchQueue.main.async {
            self.moviesCollectionView.reloadData()
        }
    }
    
    @IBAction func sortButtonClicked(_ sender: Any) {
        switch filter {
        case .popular:
            filter = .topRated
        case .topRated:
            filter = .popular
        }
        self.title = filter.title
        fetchMovieFromRemote()
    }
    
}
extension MovieListingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        
        cell.posterImage.image = UIImage(named: "placeHolderImage")
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
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.hasMorePages {
            if indexPath.row == viewModel.moviesData.count - 1 {
                viewModel.hasMorePages = false
                fetchNextMoviesFromRemote()
            }
        }
        else{
            print("end")
        }
    }
}

extension MovieListingViewController: UICollectionViewDelegateFlowLayout {
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
