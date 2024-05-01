//
//  ViewController.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    let viewModel = MoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.fetchMovies {
            DispatchQueue.main.async {
                if let errorMessage = self.viewModel.errorMessage {
                    self.showErrorAlert(message: errorMessage)
                } else {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! CountryCell
        
        let country = viewModel.countries[indexPath.row]
        
        cell.commonNameLbl?.text = country.name?.common
        cell.officialNameLbl?.text = country.name?.official
        
        if let img = country.flags?.png{
            let data = try? Data(contentsOf: img)
            cell.imageCountry?.image = UIImage(data: data!)
        }else{
            cell.imageCountry?.image = UIImage(systemName: "photo.artframe")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = viewModel.countries[indexPath.row]
        navigateToMovieDetail(with: country.name?.common ?? "")
        print("Go!")
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToMovieDetail(with country: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let countryDetailVC = storyboard.instantiateViewController(withIdentifier: "DetailView") as! DetailView
        
        countryDetailVC.data = country
        countryDetailVC.modalPresentationStyle = .automatic
        countryDetailVC.modalTransitionStyle = .crossDissolve
        self.present(countryDetailVC, animated: true, completion: nil)
    }
}


