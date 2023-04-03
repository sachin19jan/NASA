//
//  Created by Sachin, Bhardwaj
//

import UIKit

internal class PictureOfTheDayFirstViewPage: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var pictureImageView: UIImageView!
    private var imageDownloadService: ImageDownloadService!
    private var entityValidator: EntityValidator!
    private let PARAMETER_NAME = "picture"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObserver()
        setupServices()
    }
    
    private func setupServices() {
        imageDownloadService = ImageDownloadServiceImpl()
        entityValidator = EntityValidatorImpl()
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI(_:)), name: .newDownloadedData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateofflineData(_:)), name: .offlineData, object: nil)
    }
    
    @objc private func updateUI(_ notification: NSNotification) {
        let p = notification.userInfo?[PARAMETER_NAME] as? PictureOfTheDay
        let picture = entityValidator.validate(p)
        fillTextView(picture)
        setupImage(picture)
    }
    
    @objc private func updateofflineData(_ notification: NSNotification) {
        if let nasaStorage = OfflineStorage.retrieveData() {
            dateLabel.text = "Picture of the Day"
            titleTextView.text = nasaStorage.name
        }
        if let image = OfflineStorage.loadImage() {
            self.pictureImageView.image = image
        }
    }
    
    private func setupImage(_ picture: PictureOfTheDay) {
        _ = imageDownloadService.runDownload(link: picture.url) { [unowned self] image in
            self.pictureImageView.image = image
            let nasaStorage = NasaStorage(deatils: picture.explanation, name: picture.title)
            OfflineStorage.saveData(data: nasaStorage)
            OfflineStorage.saveImage(image: image ?? UIImage())
            self.notifyStopDownloading()
        }
    }
    
    private func notifyStopDownloading() {
        NotificationCenter.default.post(name: .stopActivityIndicator, object: PictureOfTheDayViewController.self, userInfo: nil)
    }
    
    private func fillTextView(_ picture: PictureOfTheDay) {
        let result = getDataToDisplay(picture)
        dateLabel.text = "Picture of the Day"
        titleTextView.text = result.title
    }
    
    private func getDataToDisplay(_ picture: PictureOfTheDay) -> (date: String, title: String) {
        return ("\(picture.date)", "\(picture.title)")
    }
}
