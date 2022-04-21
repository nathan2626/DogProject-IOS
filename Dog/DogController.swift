//
//  DogController.swift
//  Dog
//
//

import UIKit

class DogController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var dog: String?
    var dogSelected: Image = Image(message: "")
    override func viewDidLoad() {
        let url = searchUrl()
        if let data = performRequestWithUrl(url: url) {
            print("data \(data)")
            self.dogSelected = parse(data: data)
            let urlDogSelected = URL(string: dogSelected.message)!
            if let dataURL = try? Data(contentsOf: urlDogSelected){
                imageView.image = UIImage(data: dataURL)
            }
        
        }
        super.viewDidLoad()
    }
    func searchUrl() -> URL {
        if let dogRace = self.dog {
            let urlString = String(format:"https://dog.ceo/api/breed/"+dogRace+"/images/random")
            let url = URL(string: urlString)
            print(url!)
            return url!
        }
        return URL(string: "error")!
    }
    func performRequestWithUrl(url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error)
            return nil
        }
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "RaceSegue" {
                let controller = segue.destination as! RaceController
                controller.race = self.dog
            }
        }
}
