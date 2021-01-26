//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Aasmaan Yadav on 21/01/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var starterCars = StarterCars()
    
    @State private var selectedCar: Int = 0
    
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var weightPackage = false
    @State private var enginePackage = false
    
    @State private var remainingFunds = 1000
    
    @State private var remainingTime = 10
    
    var exhaustPackageEnabled: Bool {
        return ((remainingFunds - 500) >= 0 || exhaustPackage == true) ? (remainingTime > 0) ? true : false : false
//        if (remainingFunds - 500) >= 0 || exhaustPackage == true {
//            return true
//        }else{
//            return false
//        }
    }
    
    var tiresPackageEnabled: Bool {
        return ((remainingFunds - 250) >= 0 || tiresPackage == true) ? (remainingTime > 0) ? true : false : false
    }
    
    var weightPackageEnabled: Bool {
        return ((remainingFunds - 250) >= 0 || weightPackage == true) ? (remainingTime > 0) ? true : false : false
    }
    
    var enginePackageEnabled: Bool {
        return ((remainingFunds - 750) >= 0 || enginePackage == true) ? (remainingTime > 0) ? true : false : false
    }
    
    var randomCarEnabled: Bool {
        return (remainingTime > 0) ? true : false
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        
        //Bindings - problem can change car infinetely with randdom car button
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                }else{
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
                
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in
                self.tiresPackage = newValue
                
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 250
                }else{
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 250
                }
                
            }
        )
        
        let weightPackageBinding = Binding<Bool> (
            get: { self.weightPackage },
            set: { newValue in
                self.weightPackage = newValue
                
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.9
                    remainingFunds -= 250
                }else{
                    starterCars.cars[selectedCar].acceleration += 0.9
                    remainingFunds += 250
                }
                
            }
        )
        
        let enginePackageBinding = Binding<Bool> (
            get: { self.enginePackage },
            set: { newValue in
                self.enginePackage = newValue
                
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.4
                    starterCars.cars[selectedCar].topSpeed += 10
                    starterCars.cars[selectedCar].handling -= 1
                    remainingFunds -= 750
                }else{
                    starterCars.cars[selectedCar].acceleration += 0.4
                    starterCars.cars[selectedCar].topSpeed -= 10
                    starterCars.cars[selectedCar].handling += 1
                    remainingFunds += 750
                }
                
            }
        )
        
        //display stuff
        VStack {
            
            Text("\(remainingTime)")
                .onReceive(timer, perform: { _ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    }
                })
                .foregroundColor(.red)
            
            Form {
                
                //car info and random button
                VStack (alignment: .leading, spacing: 20) {
                    
                    Text( starterCars.cars[selectedCar].displayStats() )
                    
                    Button("Random Car", action: {
                        self.resetDisplay()
                        if selectedCar == self.starterCars.cars.count - 1 {
                            selectedCar = 0
                        }else{
                            selectedCar = selectedCar + 1
                        }
                    })
                    .disabled(!randomCarEnabled)
                }
                
                //toggles
                Section {
                    Toggle("Exhaust Package (cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(!exhaustPackageEnabled)
                    Toggle("Tires Package (cost: 250)", isOn: tiresPackageBinding)
                        .disabled(!tiresPackageEnabled)
                    Toggle("Weight Package (cost: 250)", isOn: weightPackageBinding)
                        .disabled(!weightPackageEnabled)
                    Toggle("Engine Package (cost: 750)", isOn: enginePackageBinding)
                        .disabled(!enginePackageEnabled)
                }
            }
            
            //funds
            Text("Remaining funds: \(remainingFunds)")
                .foregroundColor(.black)
                .baselineOffset(20)
                .bold()
        }
    }
    
    func resetDisplay() {
        remainingFunds = 1000
        //could you use a for loop here?
        
        if exhaustPackage == true {
            exhaustPackage = false
            starterCars.cars[selectedCar].topSpeed -= 5
        }
        if tiresPackage == true {
            tiresPackage = false
            starterCars.cars[selectedCar].handling -= 2
        }
        if weightPackage == true {
            weightPackage = false
            starterCars.cars[selectedCar].acceleration += 0.9
        }
        if enginePackage == true {
            enginePackage = false
            starterCars.cars[selectedCar].acceleration += 0.4
            starterCars.cars[selectedCar].topSpeed -= 10
            starterCars.cars[selectedCar].handling += 1
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
