//
//  Created by Sachin, Bhardwaj
//

import UIKit

internal class PictureOfTheDaySecondViewPage: UIViewController {
    private var entityValidator: EntityValidator!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var explanationTextView: UITextView!
    private let PARAMETER_NAME = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupServices()
        setupObserver()
        makeInitialUIUpdate()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .newDownloadedData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateofflineData(_:)), name: .offlineData, object: nil)
    }
    
    @objc private func updateofflineData(_ notification: NSNotification) {
        if let nasaStorage = OfflineStorage.retrieveData() {
            titleTextView.text = nasaStorage.name
            explanationTextView.text = nasaStorage.deatils
        }
    }
    
    private func setupServices() {
        entityValidator = EntityValidatorImpl()
    }
    
    private func makeInitialUIUpdate() {
       NotificationCenter.default.post(name: .explicityUpdateUI, object: PictureOfTheDayViewController.self)
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        let picture = entityValidator.validate(p)
        fillTextView(picture)
    }
    
    private func fillTextView(_ picture: PictureOfTheDay) {
        let result = getDataToDisplay(picture)
        titleTextView.text = result.title
        explanationTextView.text = result.explanation
    }
    
    private func getDataToDisplay(_ picture: PictureOfTheDay) -> (date: String, title: String, explanation: String) {
        return ("\(picture.date)", "\(picture.title)", "\(picture.explanation)")
    }
}
