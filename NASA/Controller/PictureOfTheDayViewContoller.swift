//
//  Created by Sachin, Bhardwaj
//

import UIKit

internal class PictureOfTheDayViewController: UIPageViewController {
    private var downloader: DataDownloadService!
    private var serializer: Serializer!
    private var uiViewControllerFactory: UIViewControllerFactory!
    private var uiViewControllerValidator: UIViewControllerValidator!
    private var sendPicture: [String: PictureOfTheDay?]?
    private var lastDownloadedPictureOfTheDay: PictureOfTheDay!
    private var activityIndicator: UIActivityIndicatorView!
    private let FIRST_PAGE_NAME = "PictureOfTheDayFirstPage"
    private let SECOND_PAGE_NAME = "PictureOfTheDaySecondPage"
    private let PARAMETER_NAME = "picture"
    internal lazy var associatedPageViews: [UIViewController] = {
        return [uiViewControllerFactory.create(name: FIRST_PAGE_NAME),
                uiViewControllerFactory.create(name: SECOND_PAGE_NAME)]
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if lastDownloadedPictureOfTheDay == nil {
            getTodayPictureOfTheDay()
        }
        else {
            
        }
    }

    internal func getTodayPictureOfTheDay() {
        downloadJSONfromServer(date: getCurrentDate())
    }
    
    internal func downloadJSONfromServer(date: Date) {
        if  NetworkMonitor.shared.currentStatus != .satisfied {
            NotificationCenter.default.post(name: .offlineData, object: PictureOfTheDayFirstViewPage.self, userInfo: nil)
            NotificationCenter.default.post(name: .offlineData, object: PictureOfTheDaySecondViewPage.self, userInfo: nil)
            let alert = UIAlertController(title: "No internet Connection", message: "Check internet connection and run application again", preferredStyle: .alert)
            present(alert, animated: true)
        } else {
            runActivityIndicator(associatedPageViews.first!)
            _ = downloader.runDownload(date: date) { [unowned self] data in
                self.serializer.decode(ofType: PictureOfTheDay.self, data: data) { [unowned self] pictureOfTheDay in
                    self.lastDownloadedPictureOfTheDay = pictureOfTheDay
                    self.sendPicture = [self.PARAMETER_NAME: pictureOfTheDay]
                    self.sendData()
                }
            }
        }
    }
    
    @objc private func stopActivityIndicator() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [unowned self] in
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func configure() {
        setupDelegates()
        setupServices()
        setupObserver()
        setupAssosiatedPageViews()
    }
    
    fileprivate func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(sendData), name: .explicityUpdateUI, object: sendPicture)
        NotificationCenter.default.addObserver(self, selector: #selector(stopActivityIndicator), name: .stopActivityIndicator, object: nil)
    }
    
    @objc private func sendData() {
        NotificationCenter.default.post(name: .newDownloadedData, object: PictureOfTheDayFirstViewPage.self, userInfo: sendPicture)
    }
    
    private func runActivityIndicator(_ uiView: UIViewController) {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = uiView.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        uiView.view.addSubview(activityIndicator)
    }
    
    fileprivate func setupDelegates() {
        dataSource = self
    }
    
    fileprivate func setupServices() {
        downloader = NASADownloadService()
        serializer = JSONSerializer()
        uiViewControllerFactory = UIViewControllerFactoryImpl()
        uiViewControllerValidator = UIViewControllerValidatorImpl()
    }
    
    fileprivate func setupAssosiatedPageViews() {
        let firstViewController = uiViewControllerValidator.validate(associatedPageViews.first)
        setViewControllers([firstViewController], direction: .forward, animated: true)
    }
    
    fileprivate func getCurrentDate() -> Date {
        return Date().addingTimeInterval(-1 * 60 * 60 * 8)
    }
    
}
