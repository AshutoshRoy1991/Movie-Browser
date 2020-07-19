////
////  MovieListViewController.swift
////  Movie Browser
////
////  Created by Ashutosh Roy on 16/07/20.
////  Copyright © 2020 Ashutosh Roy. All rights reserved.
////
//
//import UIKit
//
//class MovieListViewController: UIViewController {
//    
//    @IBOutlet weak var movieListTableView: UITableView!
//    
//    var moviesData :[MovieResult] = []
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        movieListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "fb")
//        loadMovies(forPage: 1)
//        
//        
//        
//        // Do any additional setup after loading the view.
//    }
//    
//    //MARK: - load data
//    private func loadMovies(forPage page : Int) {
//        _ = NetworkAccess.fetchData(req: MovieListReq(pageNumber: 1),completionHandler: { [weak self] (result) in
//            guard let self = self else {return}
//            switch result {
//            case .success(let movieListing):
//                self.moviesData = movieListing.results
//                self.movieListTableView.reloadData()
//            case .cancel(let cancelError):
//                print(cancelError!)
//            case .failure(let error):
//                print(error!)
//            }
//        })
//    }
//}
//
//extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        moviesData.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "test", for: indexPath)
//        
//        let movie = moviesData[indexPath.row]
//        cell.textLabel?.text = movie.title
//        //        cell.detailTextLabel?.text = movie.overview
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movie = moviesData[indexPath.row]
//        
//        if let aViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController {
//            
////            aViewController.moviesData = movie
//            
//            self.navigationController?.pushViewController(aViewController, animated: true)
//        }
//    }
//}
