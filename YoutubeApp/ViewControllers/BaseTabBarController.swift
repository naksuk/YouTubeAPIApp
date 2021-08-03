import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers?.enumerated().forEach({ (index, viewController) in
            switch index {
            case 0:
                setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "ホーム")
            case 1:
                setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "検索")
            case 2:
                setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "登録チャンネル")
            case 3:
                setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "受信トレイ")
            case 4:
                setTabbbarInfo(viewController, selectedImageName: "good-selected", unselectedImageName: "good-unselected", title: "ライブラリ")
            default:
                break
            }
        })
        
    }
    
    
    private func setTabbbarInfo(_ viewController: UIViewController, selectedImageName: String, unselectedImageName: String, title: String) {
        viewController.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.image = UIImage(named: unselectedImageName)?.resize(size: .init(width: 20, height: 20))?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.title = title
        
    }
    
}
