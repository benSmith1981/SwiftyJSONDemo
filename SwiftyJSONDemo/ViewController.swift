//
//  ViewController.swift
//  SwiftyJSONDemo
//
//  Created by Ben Smith on 09/03/2018.
//  Copyright © 2018 Ben Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var offers: [Offer] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(R.nib.offerTableViewCell)
        APIManager.shared.getSpecialOffers(success: { (offers, _) in
            self.offers = offers
            self.tableView.reloadData()
        }) { (message) in
            print(message)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier:R.reuseIdentifier.offerCell, for: indexPath) as! OfferTableViewCell
        let offer = offers[indexPath.row]
        cell.textLabel?.text = offer.name
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.offers.count
    }
    


}

