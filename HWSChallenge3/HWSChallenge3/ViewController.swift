//
//  ViewController.swift
//  HWSChallenge3
//
//  Created by Adam Delaney on 5/24/20.
//  Copyright © 2020 Adam Delaney. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var wordLabel: UILabel!
    var currentAnswer: UITextField!
    var guessesLabel: UILabel!
    
    var promptWord = ""{
        didSet{
            wordLabel.text = "Word: \(promptWord)"
        }
    }
    var usedLetters = [String]()
    var allWords = [String]()
    var word = ""
    var guesses = 8{
        didSet{
            guessesLabel.text = "Guesses Left: \(guesses)"
        }
    }
    
    

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        wordLabel = UILabel()
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        wordLabel.font = UIFont.systemFont(ofSize: 38)
        wordLabel.text = "Word: "
        view.addSubview(wordLabel)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Type letter here to guess."
        currentAnswer.textAlignment = .center
        currentAnswer.font = UIFont.systemFont(ofSize: 38)
        currentAnswer.isUserInteractionEnabled = true
        view.addSubview(currentAnswer)
        
        guessesLabel = UILabel()
        guessesLabel.translatesAutoresizingMaskIntoConstraints = false
        guessesLabel.textAlignment = .center
        guessesLabel.font = UIFont.systemFont(ofSize: 24)
        guessesLabel.text = "Guesses Left: "
        view.addSubview(guessesLabel)
        
        let guess = UIButton(type: .system)
        guess.translatesAutoresizingMaskIntoConstraints = false
        guess.setTitle("GUESS", for: .normal)
        guess.addTarget(self, action: #selector(guessTapped), for: .touchUpInside)
        view.addSubview(guess)
        
        let clear = UIButton(type: .system)
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let reset = UIButton(type: .system)
        reset.translatesAutoresizingMaskIntoConstraints = false
        reset.setTitle("New Word", for: .normal)
        reset.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        view.addSubview(reset)
        
        NSLayoutConstraint.activate([
            wordLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            currentAnswer.topAnchor.constraint(equalTo: wordLabel.bottomAnchor),
            currentAnswer.centerXAnchor.constraint(equalTo: wordLabel.centerXAnchor),
            
            guessesLabel.bottomAnchor.constraint(equalTo: wordLabel.topAnchor),
            guessesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            guess.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            guess.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            guess.heightAnchor.constraint(equalToConstant: 44),

            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.centerYAnchor.constraint(equalTo: guess.centerYAnchor),
            clear.heightAnchor.constraint(equalToConstant: 44),
            
            reset.topAnchor.constraint(equalTo: guess.bottomAnchor),
            reset.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reset.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        if allWords.isEmpty {
            allWords = ["silkworm"]
        }
        newWord()
    }
    
    
    @objc
    func guessTapped(_ sender: UIButton){
        guard let answerText = currentAnswer.text?.lowercased() else {return}
        if answerText.count > 1 {
            let ac = UIAlertController(title: "One letter at a time.", message: "Please only guess one letter at a time", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default))
            present(ac, animated: true)
        } else {
            usedLetters.append(answerText)
            print(usedLetters)
            checkGuesses(word)
        }
    }
    
    @objc
    func clearTapped(_ sender: UIButton){
        currentAnswer.text = ""
    }
    
    @objc
    func resetTapped(_ sender: UIButton) {
        newWord()
    }
    
    func newWord(){
        word = allWords.randomElement() ?? "silkworm"
        usedLetters.removeAll()
        currentAnswer.text=""
        guesses = 8
        checkGuesses(word)
    }
    
    func newGame(action: UIAlertAction){
        newWord()
    }
    
    func checkGuesses(_ word: String){
        guesses -= 1
        if guesses == 0 {
            let ac = UIAlertController(title: "You lost.", message: "You ran out of guesses! The word was: \(word)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Word", style: .default, handler: newGame))
            present(ac, animated: true)
        }
        
        promptWord = ""
        for letter in word {
            let strLetter = String(letter)
            print(strLetter)
            if usedLetters.contains(strLetter) {
                promptWord += strLetter
            } else {
                promptWord += "?"
            }
        }
        if promptWord == word {
            let ac = UIAlertController(title: "Congratulations", message: "You guessed the word!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "New Word", style: .default, handler: newGame))
            present(ac, animated: true)
        }
    }
    


}

