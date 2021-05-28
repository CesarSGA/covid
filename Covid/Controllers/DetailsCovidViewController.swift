//
//  DetailsCovidViewController.swift
//  Covid
//
//

import UIKit

class DetailsCovidViewController: UIViewController {

    var cases: Int = 0
    var country : String = ""
    var todayCases: Int = 0
    var deaths: Int = 0
    var todayDeaths: Int = 0
    var recovered: Int = 0
    var todayRecovered: Int = 0
    var flag : String = ""
    
    @IBOutlet weak var confirmadosTotalesLabel: UILabel!
    @IBOutlet weak var confirmadosHoyLabel: UILabel!
    @IBOutlet weak var muertesTotalesLabel: UILabel!
    @IBOutlet weak var muertesHoyLabel: UILabel!
    @IBOutlet weak var recuperadosTotalesLabel: UILabel!
    @IBOutlet weak var recuperadosHoyLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmadosTotalesLabel.text = String(cases)
        confirmadosHoyLabel.text = String(todayCases)
        muertesTotalesLabel.text = String(deaths)
        muertesHoyLabel.text = String(todayDeaths)
        recuperadosTotalesLabel.text = String(recovered)
        recuperadosHoyLabel.text = String(todayRecovered)
        
        let url = NSURL(string: flag)
        let dataImge = NSData(contentsOf : url! as URL)
        self.flagImageView.image = UIImage(data : dataImge! as Data)
    }
}
