//
//  ViewController.swift
//  Covid
//
/
//

import UIKit

struct CovidData: Codable {
    let country: String
    let countryInfo: CountryInfo
    let cases: Int
    let todayCases: Int
    let deaths: Int
    let todayDeaths: Int
    let recovered: Int
    let todayRecovered: Int
}

struct CountryInfo: Codable {
    let flag: String
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var resultados = [CovidData]()
    
    var posicion: Int = 0
    var country: String?
    var cases: Int?
    var todayCases: Int?
    var deaths: Int?
    var todayDeaths: Int?
    var recovered: Int?
    var todayRecovered: Int?
    var flag: String?
    
    @IBOutlet weak var covidTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlString = "https://corona.lmao.ninja/v3/covid-19/countries"
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    //MARK:- Table View Methods
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonPeticion = try? decoder.decode([CovidData].self, from: json) {
            resultados = jsonPeticion
            covidTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = covidTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        celda.textLabel?.text = resultados[indexPath.row].country
        celda.detailTextLabel?.text =  String(resultados[indexPath.row].cases)
        return celda
    }
    
    // Cuando el usuario selecciona un elemento
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        posicion = indexPath.row
        cases = resultados[indexPath.row].cases
        todayCases = resultados[indexPath.row].todayCases
        deaths = resultados[indexPath.row].deaths
        todayDeaths = resultados[indexPath.row].todayDeaths
        recovered = resultados[indexPath.row].recovered
        todayRecovered = resultados[indexPath.row].todayRecovered
        flag = resultados[indexPath.row].countryInfo.flag
        
        self.performSegue(withIdentifier: "covidSegue", sender: self)
    }
    
    // Envio de datos por el Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "covidSegue" {
            let destination = segue.destination as! DetailsCovidViewController
            destination.cases = resultados[posicion].cases
            destination.todayCases = resultados[posicion].todayCases
            destination.deaths = resultados[posicion].deaths
            destination.todayDeaths = resultados[posicion].todayDeaths
            destination.recovered = resultados[posicion].recovered
            destination.todayRecovered = resultados[posicion].todayRecovered
            destination.flag = resultados[posicion].countryInfo.flag
        }
    }
}
