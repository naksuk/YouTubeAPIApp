import UIKit
import Nuke

class VideoViewController: UIViewController {
    
    var selectedItem: Item?
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelTitleLabel: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var baseBackGroundView: UIView!
    @IBOutlet weak var videoImageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var videoImageViewTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.baseBackGroundView.alpha = 1
        }
    }
    
    
    private func setupViews() {
        channelImageView.layer.cornerRadius = 45 / 2
        
        if let url = URL(string: selectedItem?.snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: url, into: videoImageView)
        }
        
        if let channelUrl = URL(string: selectedItem?.channel?.items[0].snippet.thumbnails.medium.url ?? "") {
            Nuke.loadImage(with: channelUrl, into: channelImageView)
        }
        
        videoTitleLabel.text = selectedItem?.snippet.title
        channelTitleLabel.text = selectedItem?.channel?.items[0].snippet.title
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panVideoImageView))
        videoImageView.addGestureRecognizer(panGesture)
    }
    
    @objc private func panVideoImageView(gesture: UIPanGestureRecognizer) {
        
        guard let imageView = gesture.view else { return }
        let move = gesture.translation(in: imageView)
        
        if gesture.state == .changed {
            imageView.transform = CGAffineTransform(translationX: 0, y: move.y)
            
            // 左右のpadding設定
            let movingConstant = move.y / 30

            videoImageViewTrailingConstraint.constant = movingConstant
            videoImageViewLeadingConstraint.constant = movingConstant
            
            //imageViewの高さの動き
            //280（最大値）- 70(最小値) = 210
            let parentViewHeight = self.view.frame.height
            let heightRatio = 210 / (parentViewHeight - (parentViewHeight / 6))
            let moveHeight = move.y * heightRatio
            
            videoImageViewHeightConstraint.constant = 280 - moveHeight
            
            // imageViewの横幅の動き150(最小値)
            let originalWidth = self.view.frame.width
            let minimusImageViewTrailingConstant = -(originalWidth - (150 + 12))
            let constant = originalWidth - move.y
            
            if minimusImageViewTrailingConstant > constant {
                videoImageViewTrailingConstraint.constant = minimusImageViewTrailingConstant
                return
            }
            
            if constant < -12 {
                videoImageViewTrailingConstraint.constant = -constant
            }
            
            
            
        } else if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
                imageView.transform = .identity
                self.backToIdentifyAllViews()
                self.view.layoutIfNeeded()
            })
        }
    }
        
    private func backToIdentifyAllViews() {
        self.videoImageViewHeightConstraint.constant = 280
        self.videoImageViewLeadingConstraint.constant = 0
        self.videoImageViewTrailingConstraint.constant = 0
    }
    
}
