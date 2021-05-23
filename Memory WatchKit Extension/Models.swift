//
//  Models.swift
//  Memory WatchKit Extension
//
//  Created by Guillermo Frias on 21/01/2021.
//
import SwiftUI

func randomColor() -> Color {
    return [Color.red, Color.blue, Color.green, Color.yellow].randomElement()!
}

enum Turn {
    case human
    case machine
}

class State: ObservableObject {
    @Published var turn: Turn = .machine
    @Published var current: Color?
    @Published var display: String = ""
    
    private var score:Int = 0
    @Published var maxScore:Int = 0
    
    @Published var ended: Bool = false
    
    private var sequence: [Color] = []
    private var index: Int = 0
    
    func nextMachine() {
        display = "..."
        var nextTurn: Turn = .machine
        if index == sequence.count {
            sequence.append(randomColor())
            current = sequence.last!
            nextTurn = .human
            score = 0
            index = 0
        } else {
            current = sequence[index]
            index += 1
        }
        if let current = current {
            playSound(current)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.current = nil
            self.turn = nextTurn
            
            if self.turn == .machine {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.nextMachine()
                }
            } else {
                self.display = "\(self.score)"
            }
        }
    }
    
    func nextHuman(_ color: Color) {
        display = "\(score)"
        current = color
        if sequence[index] == color {
            index += 1
            score += 1
            display = "\(score)"
            maxScore = max(maxScore, score)
            
            if index == sequence.count {
                index = 0
                turn = .machine
                score = 0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.current = nil
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                        self.nextMachine()
                    }
                }
            } else {
                let currIdx = index
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    if currIdx == self.index {
                        self.current = nil
                    }
                }
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.ended = true
            }
        }
    }
    
    func reset() {
        turn = .machine
        current = nil
        score = 0
        display = "..."
        ended = false
        sequence = []
        index = 0
        maxScore = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.nextMachine()
        }
    }
}
