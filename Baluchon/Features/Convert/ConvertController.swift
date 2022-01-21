//
//  ConvertController.swift
//  Baluchon
//
//  Created by fred on 24/12/2021.
//

import UIKit

class ConvertController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var originIcon: UILabel!
    @IBOutlet weak var resultAmount: UILabel!
    @IBOutlet weak var convertedIcon: UILabel!
    @IBOutlet weak var infoText: UILabel!
    @IBOutlet weak var switchButton: UIButton!
    @IBOutlet weak var convertToButton: UIButton!

    var originCurrency = "€"
    var convertedCurrency = "$"
    private let repository = ConvertRepository.shared
    var defaults = UserDefaults.standard
    lazy var rate = defaults.double(forKey: "usdrate")
    lazy var timestamp = defaults.integer(forKey: "timestamp")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Convertisseur"
        launchQueryIfNeeded()
        updateInfoRate()
    }

    // MARK: - Convenience Methods

    /// check if is the same day
    func launchQueryIfNeeded() {
        guard let lastStatementDay = Int(lastDay()),
              let currentDay = Int(currentDay()) else { return }
print("last", lastStatementDay)
        print("current", currentDay)
        let delta = abs(currentDay) - abs(lastStatementDay)
        if delta >= 1 {
            getRate()
        }
    }
 
    private func getRate() {
        repository.getRate { rateData, error in
            if let error = error {
                AlertView().presentAlert(message: error.localizedDescription)
            }
            guard let _rateUsd = rateData?.USD,
                  let newTimestamp = rateData?.timestamp
            else { return }
            guard let rateUsd = Double(_rateUsd.withDecimal()) else { return }
            self.defaults.set(rateUsd, forKey: "usdrate")
            self.defaults.set(newTimestamp, forKey: "timestamp")
        }
    }

    private func updateInfoRate() {
        infoText.text = "Le \(lastStatementDate()):  1 € (Euro) = \(rate) $ ((Dollar)"
    }

    func getConvertedAmount(with amountText: String?, originIcon: String) -> String {

        guard var amountText = amountText else {
            return " "
        }
        /// replace comma by dot to convert String to Double
        amountText = amountText.replaceComma()

        guard let amount = Double(amountText) else {
            AlertView().presentAlert(message: "Oups, le montant est incorrect")
            return " "
        }

        let isDollar = originIcon == "$"
        let rate = isDollar ? (1/rate) : rate
        let result = amount * rate
        return String(result.withDecimal()).replaceDot()
    }
    // MARK: - IBActions

    @IBAction func switchIconCurrency(_ sender: UIButton) {
        swap(&originCurrency, &convertedCurrency)
        originIcon.text = originCurrency
        convertedIcon.text = convertedCurrency
        amountField.text = ""
        resultAmount.text = "0.00"
    }

    @IBAction func convertButton(_ sender: UIButton) {
        let amount = getConvertedAmount(
            with: amountField.text,
            originIcon: originCurrency
        )
        resultAmount.text = amount
        amountField.resignFirstResponder()
    }

    // MARK: - Keyboard

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        amountField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountField.resignFirstResponder()
        return true
    }

    // MARK: - Formatted Dates

    func lastStatementDate() -> String {
        let timestamp = defaults.integer(forKey: "timestamp")
        return formattedDate(timestamp, format: "dd/MM/yyyy")
    }

    private func lastDay() -> String {
        let timestamp = defaults.integer(forKey: "timestamp")
        return formattedDate(timestamp, format: "dd")
    }

    private func currentDay() -> String {
        let currentTime = TimeInterval(Date().timeIntervalSince1970)
        return formattedDate(Int(currentTime), format: "dd")
    }

    private func formattedDate(_ timestamp: Int, format: String) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone(secondsFromGMT: 3600)
        return formatter.string(from: date)
    }
}
