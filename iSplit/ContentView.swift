//
//  ContentView.swift
//  iSplit
//
//  Created by Kaumon Aung on 14.04.20.
//  Copyright © 2020 Kaumon Aung. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Bindings & Computed Properties
    @State private var priceAmount = ""
    @State private var peopleAmount = ""
    @State private var tipAmount = 0
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    
    // Computes the total check with tip
    var totalCheckAmountWithTip: Double {
        let amount = Double(priceAmount) ?? 0
        let tipSelection = tipAmount
        let tipAmount = Double(tipPercentages[tipSelection])
        
        let tipInPercentage = tipAmount / 100
        let totalCheck = amount * (1 + tipInPercentage)
        
        return totalCheck
    }
    
    // Computes only the tip amount
    var onlyTip: Double {
        let amount = Double(priceAmount) ?? 0
        let tipSelection = tipAmount
        let tipAmount = Double(tipPercentages[tipSelection])
        
        let tipInPercentage = tipAmount / 100
        let onlyTipAmount = tipInPercentage * amount
        
        return onlyTipAmount
    }
    
    // Computes the amount per person
    var amountPerPerson: Double {
        let amount = Double(priceAmount) ?? 0
        let tipSelection = tipAmount
        let tipAmount = Double(tipPercentages[tipSelection])
        let amountOfPeople = Double(peopleAmount) ?? 1
        
        let tipInPercentage = tipAmount / 100
        let totalCheck = amount * (1 + tipInPercentage)
        let perPerson = totalCheck / amountOfPeople
        
        return perPerson
    }
    
    // MARK: - Content View
    var body: some View {
        
        NavigationView {
            
            Form {
                Section(header: Text("Check amount")) {
                    TextField("Enter check amount here ...", text: $priceAmount)
                }
                Section(header: Text("Number of people")) {
                    TextField("Enter number of people here ...", text: $peopleAmount)
                }
                Section(header: Text("Select the tip amount")) {
                    Picker(selection: $tipAmount, label: Text("Select the tip amount")) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    } .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Check amount")) {
                    Text("Tip: $\(onlyTip, specifier: "%.2f")")
                }
                Text("Total: $\(totalCheckAmountWithTip, specifier: "%.2f")")
                    .font(.headline)
                Text("Per Person: $\(amountPerPerson, specifier: "%.2f")")
                    .font(.headline)
            }
            .navigationBarTitle("iSplit", displayMode: .large)
        }
    } // End body
} // End ContentView

// MARK: - Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
