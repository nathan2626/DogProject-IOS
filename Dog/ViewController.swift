//
//  ViewController.swift
//  Dog
//
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate{

    @IBAction func DoneButton(_ sender: Any) {
    }
    
    @IBAction func ButtonAddFav(_ sender: Any) {
    }
    
    @IBOutlet weak var dogsArray: UITableView!
    var dogs: ResultArray = ResultArray(message: [:])
    var selectedDog: String?

   
    override func viewDidLoad() {
        
        let url = searchUrl()
        if let data = performRequestWithUrl(url: url) {
            print("data \(data)")
            self.dogs = parse(data: data)
            print(dogs)
            
        
        }
        dogsArray.reloadData()
        super.viewDidLoad()
    }
    func searchUrl() -> URL {
        let urlString = String(format:"https://dog.ceo/api/breeds/list/all")
        let url = URL(string: urlString)
        print(url!)
        return url!
    }
    func performRequestWithUrl(url: URL) -> Data? {
        do {
            return try Data(contentsOf: url)
        } catch {
            print(error)
            return nil
        }
    }
    func parse(data: Data) -> ResultArray {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            print(result)
            return result
        } catch  {
            print("json error")
            return ResultArray(message: [:])
        }
       
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = dogs.message.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dogCell", for: indexPath)
        let dog = Array(dogs.message)[indexPath.row].key
        print("index \(dog)")
        
        cell.textLabel?.text = dog
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
        
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedDog = Array(dogs.message)[indexPath.row].key
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dogSegue" {
            let controller = segue.destination as! DogController
            controller.dog = selectedDog
        }
    }

}

