//
//  ViewController.swift
//  CodeGen
//
//  Created by Matt Thomas on 18/12/2022.
//

import UIKit
import Highlightr

final class SearchViewController: UIViewController, SeachResultsDelegate {
    
    @IBOutlet private var seachQueryTextField: UITextField!
    @IBOutlet private var resultsTextView: UITextView!
    @IBOutlet private var searchButton: UIButton!
    
    private var isSyntaxHighlightingEnabled = false
    private var viewModel: SearchViewModel
    
    required init?(coder: NSCoder) {
        self.viewModel = SearchViewModelImpl()
        super.init(coder: coder)
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        seachQueryTextField.layer.borderColor = UIColor.lightGray.cgColor
        seachQueryTextField.clearButtonMode = .whileEditing
        searchButton.addBorder()
    }
    
    @IBAction func toggleSyntaxHighlighting(_ sender: UISwitch) {
        isSyntaxHighlightingEnabled = sender.isOn
    }
    
    @IBAction private func searchButtonTapped(_ sender: Any) {
        
        guard seachQueryTextField.hasText, let searchTerm = seachQueryTextField.text else {
            resultsTextView.text = "Please enter a search term first"
            return
        }
        
        viewModel.performSearch(searchTerm: searchTerm)
    }
    
    func publishResults(results: String) {
        if isSyntaxHighlightingEnabled {
            
            let highlightr = Highlightr()
            highlightr?.setTheme(to: "xcode")

            let highlightedCode = highlightr?.highlight(results, as: "swift")
            resultsTextView.attributedText = highlightedCode
        } else {
            resultsTextView.text = results
        }
    }
}
