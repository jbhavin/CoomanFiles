//
//  MyCustomClass.swift


import UIKit

class MyCustomClass: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class MyLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.masksToBounds = true
        // self.textColor = UIColor.lightGray
        
    }
    
    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            text = key.localized()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}

class MyButton: UIButton {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.masksToBounds = true
        // self.textColor = UIColor.lightGray
        
    }
    
    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            self.setTitle(key.localized(), for: .normal)
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var imageTintColor: UIColor? {
        didSet {
            let image = self.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = imageTintColor
        }
    }
    
}

class MyView: UIView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.masksToBounds = true
        // self.textColor = UIColor.lightGray
        
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
}


class MyImageView: UIImageView {
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var imageTintColor: UIColor? {
        didSet {
            let image = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = image
            self.tintColor = imageTintColor
        }
    }
    
}

class MyTextView: UITextView, UITextViewDelegate {
    
    var placeHolderString : String = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.masksToBounds = true
        // self.textColor = UIColor.lightGray
        self.delegate = self
        
    }
    
    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            text = key.localized()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var placeholder: String? {
        didSet {
            self.text = placeholder
            placeHolderString = self.text
            self.textColor = UIColor.lightGray
        }
    }
    
    @IBInspectable var padding: CGFloat = 0.0 {
        didSet {
            self.setPaddingPoints(padding)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderString
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
}

class MyTextField: UITextField, UITextFieldDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.layer.masksToBounds = true
        // self.textColor = UIColor.lightGaray
        self.delegate = self
        
    }
    
    @IBInspectable var localisedKey: String? {
        didSet {
            guard let key = localisedKey else { return }
            text = key.localized()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            self.setLeftPaddingPoints(leftPadding)
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0.0 {
        didSet {
            self.setRightPaddingPoints(rightPadding)
        }
    }
    
}
