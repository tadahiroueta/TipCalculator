//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ueta, Lucas T on 11/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    let billInput = UITextField(), tipAmountOutput = UILabel(), totalOutput = UILabel(), otherTip = UITextField(), input = UIStackView(), tipInput = UISegmentedControl()
    
    var billValue = 0.0 {
        didSet {
            tipValue = billValue * tipPercentage
            totalValue = tipValue + billValue
        }
    }
    
    var tipPercentage = 0.0 {
        didSet {
            tipValue = billValue * tipPercentage
            totalValue = tipValue + billValue
        }
    }
    
    var tipValue = 0.0 {
        didSet { tipAmountOutput.text = String(format: "%.2f", tipValue) }
    }
    
    var totalValue = 0.0 {
        didSet { totalOutput.text = String(format: "%.2f", totalValue) }
    }
    
    var otherTipActive = false {
        didSet {
            if otherTipActive { input.addArrangedSubview(otherTip) }
            else {
                otherTip.endEditing(true)
                otherTip.removeFromSuperview()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        // stack
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 120
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // title
        let title = UILabel()
        title.text = "Tip Calculator"
        title.font = .systemFont(ofSize: 36)
        stack.addArrangedSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: stack.leadingAnchor)
        ])

        // content
        let content = UIStackView()
        content.axis = .vertical
        content.alignment = .center
        content.spacing = 160
        stack.addArrangedSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: 15),
            content.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: -15)
        ])

        // input
        input.axis = .vertical
        input.alignment = .trailing
        input.spacing = 20
        content.addArrangedSubview(input)
        input.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ input.widthAnchor.constraint(equalTo: content.widthAnchor) ])

        // bill amount
        let billAmount = UIStackView()
        billAmount.axis = .horizontal
        billAmount.alignment = .center
        input.addArrangedSubview(billAmount)
        billAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ billAmount.widthAnchor.constraint(equalTo: input.widthAnchor) ])

        // bill label
        let billLabel = UILabel()
        billLabel.text = "Bill amount"
        billLabel.font = .systemFont(ofSize: 20)
        billAmount.addArrangedSubview(billLabel)
        
        // bill input
        billInput.placeholder = "$"
        billInput.keyboardType = .decimalPad
        billInput.borderStyle = .roundedRect
        billInput.addTarget(self, action: #selector(billChanged(_:)), for: .editingChanged)
        billAmount.addArrangedSubview(billInput)
        billInput.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ billInput.widthAnchor.constraint(equalToConstant: 90) ])
        
        // tip
        let tip = UIStackView()
        tip.axis = .horizontal
        tip.alignment = .center
        input.addArrangedSubview(tip)
        NSLayoutConstraint.activate([ tip.widthAnchor.constraint(equalTo: input.widthAnchor) ])
        
        // tip label
        let tipLabel = UILabel()
        tipLabel.text = "Tip"
        tipLabel.font = .systemFont(ofSize: 20)
        tip.addArrangedSubview(tipLabel)
        
        // tip input
        tipInput.insertSegment(withTitle: "0%", at: 0, animated: true)
        tipInput.insertSegment(withTitle: "10%", at: 1, animated: true)
        tipInput.insertSegment(withTitle: "20%", at: 2, animated: true)
        tipInput.insertSegment(withTitle: "Other", at: 3, animated: true)
        tipInput.selectedSegmentIndex = 0
        tipInput.addTarget(self, action: #selector(tipChanged(_:)), for: .valueChanged)
        tip.addArrangedSubview(tipInput)
        NSLayoutConstraint.activate([ tipInput.widthAnchor.constraint(equalToConstant: 220)])
        
        // other tip
        otherTip.placeholder = "%"
        otherTip.keyboardType = .decimalPad
        otherTip.borderStyle = .roundedRect
        otherTip.addTarget(self, action: #selector(tipChanged(_:)), for: .editingChanged)
        otherTip.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ otherTip.widthAnchor.constraint(equalToConstant: 90) ])
        
        // output
        let output = UIStackView()
        output.axis = .vertical
        output.alignment = .center
        output.spacing = 20
        content.addArrangedSubview(output)
        output.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ output.widthAnchor.constraint(equalTo: content.widthAnchor) ])
        
        // tip amount
        let tipAmount = UIStackView()
        tipAmount.axis = .horizontal
        tipAmount.alignment = .center
        output.addArrangedSubview(tipAmount)
        tipAmount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ tipAmount.widthAnchor.constraint(equalTo: output.widthAnchor) ])
        
        // tip amount title
        let tipAmountTitle = UILabel()
        tipAmountTitle.text = "Tip amount"
        tipAmountTitle.font = .systemFont(ofSize: 26)
        tipAmount.addArrangedSubview(tipAmountTitle)
        
        // tip amount output
        tipAmountOutput.font = .systemFont(ofSize: 26)
        tipAmountOutput.textColor = .systemGray
        tipAmount.addArrangedSubview(tipAmountOutput)
        
        // total
        let total = UIStackView()
        total.axis = .horizontal
        total.alignment = .center
        output.addArrangedSubview(total)
        total.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([ total.widthAnchor.constraint(equalTo: output.widthAnchor) ])
        
        // total title
        let totalTitle = UILabel()
        totalTitle.text = "Total"
        totalTitle.font = .systemFont(ofSize: 26)
        total.addArrangedSubview(totalTitle)
        
        // total output
        totalOutput.font = .systemFont(ofSize: 26)
        totalOutput.textColor = .systemGray
        total.addArrangedSubview(totalOutput)
        
        // reset
        let reset = UIButton()
        reset.setTitle("Reset", for: .normal)
        reset.setTitleColor(.systemBlue, for: .normal)
        reset.addTarget(self, action: #selector(resetHandler), for: .touchUpInside)
        view.addSubview(reset)
        reset.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reset.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reset.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
    
    // God bless you Viktoryia from stack overflow
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if billInput.isFirstResponder { billInput.resignFirstResponder() }
    }
    
    @objc func billChanged(_ sender: UITextField) { if let bill = Double(sender.text!) { billValue = bill }}
    
    @objc func tipChanged(_ sender: Any) {
        if let segments = sender as? UISegmentedControl {
            switch segments.selectedSegmentIndex {
                case 0:
                    tipPercentage = 0.0
                    otherTipActive = false
                    break
                case 1:
                    tipPercentage = 0.1
                    otherTipActive = false
                    break
                case 2:
                    tipPercentage = 0.2
                    otherTipActive = false
                    break
                default:
                    tipPercentage = 0.0
                    otherTipActive = true
            }
        }
        else if let input = sender as? UITextField { tipPercentage = (Double(input.text!) ?? 0.0) / 100.0 }
    }
    
    @objc func resetHandler() {
        billValue = 0
        tipInput.selectedSegmentIndex = 0
        otherTipActive = false
        billInput.text = ""
    }
    
}

