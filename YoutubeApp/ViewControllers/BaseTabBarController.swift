import UIKit

enum ControllerName: Int {
    case home, search, channel, inbox, library
}

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()

        
    }
    
    private func setupViewController() {
        viewControllers?.enumerated().forEach({ (index, viewController) in
            if let name = ControllerName.init(rawValue: index) {
                switch name {
                case .home:
                    setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "ホーム")
                case .search:
                    setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "検索")
                case .channel:
                    setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "登録チャンネル")
                case .inbox:
                    setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "受信トレイ")
                case .library:
                    setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "ライブラリ")
                }
            }
        })
    }
    
    
    private func setTabbbarInfo(_ viewController: UIViewController, selectedImageName: String, unselectedImageName: String, title: String) {
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.image = UIImage(named: unselectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.title = title
        
    }
    
}
