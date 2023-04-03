//
//  Created by Sachin, Bhardwaj
//

import UIKit

internal class UIViewControllerFactoryImpl : UIViewControllerFactory {
    private let STORYBOARD_NAME = "Main"
    
    func create(name: String) -> UIViewController {
        return UIStoryboard(name: STORYBOARD_NAME, bundle: nil).instantiateViewController(withIdentifier: name)
    }
}
