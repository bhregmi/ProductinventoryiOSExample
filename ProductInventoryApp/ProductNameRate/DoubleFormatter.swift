//
//  DoubleFormatter.swift
//  ProductInventoryApp
//
//  Created by Test User on 5/5/20.
//  Copyright © 2020 Test User. All rights reserved.
//

import Combine
import SwiftUI


protocol NewFormatter {
    associatedtype Value: Equatable

    /// The logic that converts your value to a string presented by the `TextField`. You should omit any values
    /// - Parameter object: The value you are converting to a string.
    func toString(object: Value) -> String

    /// Once the change is allowed and the input is final, this will convert
    /// - Parameter string: The full text currently on the TextField.
    func toObject(string: String) -> Value

    /// Specify if the value contains a final result. If it does not, nothing will be changed yet.
    /// - Parameter string: The full text currently on the TextField.
    func isFinal(string: String) -> Bool

    /// Specify **all** allowed inputs, **including** intermediate text that cannot be converted to your object **yet** but are necessary in the input process for a final result. It will allow this input without changing your value until a final correct value can be determined.
    /// For example, `1.` is not a valid `Double`, but it does lead to `1.5`, which is. Therefore the `DoubleFormatter` would return true on `1.`.
    /// Returning false will reset the input to the previous allowed value.
    /// - Parameter string: The full text currently on the TextField.
    func allowChange(to string: String) -> Bool
}

struct NewTextField<T: NewFormatter>: View {
    let title: String
    @Binding var value: T.Value
    let formatter: T
    @State private var previous: T.Value
    @State private var previousGoodString: String? = nil

    init(_ title: String, value: Binding<T.Value>, formatter: T) {
        self.title = title
        self._value = value
        self._previous = State(initialValue: value.wrappedValue)
        self.formatter = formatter
    }

    var body: some View {
        let changedValue = Binding<String>(
            get: {
                if let previousGoodString = self.previousGoodString {
                    let previousValue = self.formatter.toObject(string: previousGoodString)

                    if previousValue == self.value {
                        return previousGoodString
                    }
                }

                let string = self.formatter.toString(object: self.value)
                return string
            },
            set: { newString in
                if self.formatter.isFinal(string: newString) {
                    let newValue = self.formatter.toObject(string: newString)
                    self.previousGoodString = newString
                    self.previous = newValue
                    self.value = newValue
                } else if !self.formatter.allowChange(to: newString) {
                    self.value = self.previous
                }
            }
        )

        return TextField(title, text: changedValue)
    }
}

struct DoubleFormatter: NewFormatter {
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.allowsFloats = true
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 15
        return numberFormatter
    }()

    /// The logic that converts your value to a string used by the TextField.
    func toString(object: Double) -> String {
        return numberFormatter.string(from: NSNumber(value: object)) ?? ""
    }

    /// The logic that converts the string to your value.
    func toObject(string: String) -> Double {
        return numberFormatter.number(from: string)?.doubleValue ?? 0
    }

    /// Specify if the value contains a final result. If it does not, nothing will be changed yet.
    func isFinal(string: String) -> Bool {
        return numberFormatter.number(from: string) != nil
    }

    /// Specify **all** allowed values, **including** intermediate text that cannot be converted to your object **yet** but are necessary in the input process for a final result.
    /// For example, `1.` is not a valid `Double`, but it does lead to `1.5`, which is. It will allow this input without changing your value until a final correct value can be determined.
    /// Returning false will reset the input the the previous allowed value. For example, when using the `DoubleFormatter` the input `0.1j` would result in false which would reset the value back to `0.1`.
    func allowChange(to string: String) -> Bool {
        let components = string.components(separatedBy: ".")

        if components.count <= 2 {
            // We allow an Integer or an empty value.
            return components.allSatisfy({ $0 == "" || Int($0) != nil })
        } else {
            // If the count is > 2, we have more than one decimal
            return false
        }
    }
}
