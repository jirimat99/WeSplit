//
//  ContentView.swift
//  WeSplit
//
//  Created by Jiri Matousek on 25.02.2023.
//

import SwiftUI



struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peoplecount = Double(numberOfPeople + 2)
        let tipselection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipselection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peoplecount
    return amountPerPerson
        }
    var totalAmount: Double {
        let peoplecount = Double(numberOfPeople + 2)
        let tipselection = Double(tipPercentage)
        let tipValue = checkAmount/100 * tipselection
        let grandTotal = checkAmount + tipValue
    return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CZK") )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
               

                        }
                    }
                }
//MARK:------------------------------------------------------------------------
               
                
                Section {
                    Picker("Pick Tip Percentage", selection: $tipPercentage) { ForEach(tipPercentages, id: \.self) {
                        Text($0, format: .percent)
                    }
                    }
                    .pickerStyle(.segmented)
                    
                } header: { Text("Choose a tip percentage") }
//MARK:------------------------------------------------------------------------
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CZK" ))
                              
                } header: {
                    Text("Total amount with tip")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "CZK"))
                        .padding(20)

                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(.green)
                        .cornerRadius(10)

                }
                
                header: {
                 Text("Amount per person")
                }
                
//MARK:------------------------------------------------------------------------
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
