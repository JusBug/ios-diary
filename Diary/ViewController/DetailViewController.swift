//
//  DetailViewController.swift
//  Diary
//
//  Created by yyss99, Jusbug on 2023/08/30.
//

import UIKit

final class DetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    private let sample: Sample?
    let placeHolderText = "Input Text"
    
    init?(sample: Sample? = nil, coder: NSCoder) {
        self.sample = sample
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
        configureNavigationTitle()
        setUpOvserver()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    private func setUpOvserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configureTextView() {
        guard let sample else {
            textView.text = placeHolderText
            textView.textColor = .lightGray
            textView.delegate = self

            return
        }
        textView.layer.borderWidth = 1
        textView.text = sample.title + "\n\n" + sample.body
    }
    
    private func configureNavigationTitle() {
        guard let createdDate = sample?.createdDate else {
            let formattedTodayDate = CustomDateFormatter.formatTodayDate()
            self.navigationItem.title = formattedTodayDate
            return
        }
        let formattedSampleDate = CustomDateFormatter.formatSampleDate(sampleDate: createdDate)
        
        self.navigationItem.title = formattedSampleDate
    }
    
    @objc private func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame = (sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            let safeAreaBottom = view.safeAreaInsets.bottom
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight - safeAreaBottom, right: 0)
            
            textView.contentInset = contentInsets
        }
    }
    
    @objc private func keyboardWillHide(_ sender: Notification) {
        textView.contentInset = UIEdgeInsets.zero
    }
}

extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeHolderText {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = placeHolderText
            textView.textColor = .lightGray
        }
    }
}
