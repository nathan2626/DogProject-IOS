//
//  DogController.swift
//  Dog
//
//

import UIKit

class RaceController: UITableViewController {
    
    @IBOutlet weak var DetailRaceLabel: UILabel!
    var race: String?
    override func viewDidLoad() {
        DetailRaceLabel.text = race
        super.viewDidLoad()
    }
    
    func parse(data: Data) -> Image {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(Image.self, from: data)
            print(result)
            return result
        } catch  {
            print("json error")
            return Image(message: "Json error")
        }
       
    }
}
