import Kingfisher

extension UIImageView {
    
    // Extension to load image for image view with given url using King Fisher Lib
    func loadImage(withUrl url: String?) {
        if let url = url {
            self.kf.setImage(with: URL(string: url))
        }
    }
}
