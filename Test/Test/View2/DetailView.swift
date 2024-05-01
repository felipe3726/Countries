//
//  detailView.swift
//  Test
//
//  Created by Felipe Martinez on 30/04/24.
//

import UIKit

class DetailView: UIViewController{
    @IBOutlet var capitalLbl: UILabel?
    @IBOutlet var officialNameLbl: UILabel?
    @IBOutlet var commonNameLbl: UILabel?
    @IBOutlet var continentLbl: UILabel?
    @IBOutlet var descLbl: UILabel?
    @IBOutlet var coatOfArmsImg: UIImageView?
    @IBOutlet var navButton: UIButton?
    
    var viewModel = DetailViewModel()
    var data: String? = "Moldova"
    
    override func loadView() {
        super.loadView()
        viewModel.fetchMovies(country: data ?? ""){
            DispatchQueue.main.async {
                if let errorMessage = self.viewModel.errorMessage {
                    self.showErrorAlert(message: errorMessage)
                }
            }
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navButton?.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.capitalLbl?.text = viewModel.countries.first?.capital.first
        self.officialNameLbl?.text = viewModel.countries.first?.name.official
        self.commonNameLbl?.text = viewModel.countries.first?.name.common
        self.continentLbl?.text = viewModel.countries.first?.continents.first
        self.descLbl?.text = viewModel.countries.first?.flags.alt
        
        if let img = viewModel.countries.first?.coatOfArms.png{
            let data = try? Data(contentsOf: img)
            self.coatOfArmsImg?.image = UIImage(data: data!)
        }else{
            self.coatOfArmsImg?.image = UIImage(systemName: "photo.artframe")
        }
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func pressed(_ sender: UIButton){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let countryDetailVC = storyboard.instantiateViewController(withIdentifier: "WebView") as! WebView
        countryDetailVC.modalPresentationStyle = .automatic
        countryDetailVC.modalTransitionStyle = .crossDissolve
        self.present(countryDetailVC, animated: true, completion: nil)
    }
}
