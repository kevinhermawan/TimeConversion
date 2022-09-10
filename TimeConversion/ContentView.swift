//
//  ContentView.swift
//  TimeConversion
//
//  Created by Kevin Hermawan on 10/09/22.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var timeFrom = "Seconds"
    @State private var timeTo = "Days"
    @FocusState private var inputFocused: Bool
    
    let times = ["Seconds", "Minutes", "Hours", "Days"]
    
    private var result: Double {
        switch timeFrom {
        case "Seconds":
            return fromSeconds(input: input, to: timeTo)
        case "Minutes":
            return fromMinutes(input: input, to: timeTo)
        case "Hours":
            return fromHours(input: input, to: timeTo)
        case "Days":
            return fromDays(input: input, to: timeTo)
        default:
            return 0
        }
    }
    
    func fromSeconds(input: Double, to: String) -> Double {
        switch to {
        case "Minutes":
            return input / 60
        case "Hours":
            return input / 3600
        case "Days":
            return input / 86400
        default:
            return input
        }
    }
    
    func fromMinutes(input: Double, to: String) -> Double {
        switch to {
        case "Seconds":
            return input * 60
        case "Hours":
            return input / 60
        case "Days":
            return input / 1440
        default:
            return input
        }
    }
    
    func fromHours(input: Double, to: String) -> Double {
        switch timeTo {
        case "Seconds":
            return input * 3600
        case "Minutes":
            return input * 60
        case "Days":
            return input / 24
        default:
            return input
        }
    }
    
    func fromDays(input: Double, to: String) -> Double {
        switch to {
        case "Seconds":
            return input * 86400
        case "Minutes":
            return input * 1440
        case "Hours":
            return input * 24
        default:
            return input
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("From", selection: $timeFrom) {
                        ForEach(times, id: \.self) { time in
                            Text(time)
                        }
                    }
                    
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputFocused)
                }
                
                Section {
                    Picker("To", selection: $timeTo) {
                        ForEach(times, id: \.self) { time in
                            Text(time)
                        }
                    }
                    
                    Text(result, format: .number)
                }
            }
            .navigationTitle("TimeConversion")
        } .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    inputFocused = false
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
