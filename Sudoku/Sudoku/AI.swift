//
//  AI.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

public class AI {
    
    public var board: SudokuBoard

    public init(board: SudokuBoard) 
    {
        self.board = board
    }
    public var isSolved: Bool 
    {
        return board.isSolved
    }
    public func solve()
    {
        while (!isSolved)
        {
            var valueWasSetThisIteration = false;

            board.cells.enumerated().forEach({ index, cell in

                if cell.isSet{
                    return
                }
                //Fliter loops over the collection of values and return the elements that match the condition
                let possibleValues = (1...9).filter ({ value in
                    return board.isValueAllowed(index: index, toValue: value)
                })
                if possibleValues.isEmpty {
                    return
                }
                if possibleValues.count == 1
                {
                    valueWasSetThisIteration = true;
                }                            
                try? board.update(index: index, values: possibleValues)
            })
            //Add another strategy
          /*  if(!valueWasSetThisIteration)
            {
                for (index,cell) in board.cells.enumerated()
                {
                    if cell.isSet
                    {
                        continue
                    }

                }
            }*/
            if(!valueWasSetThisIteration)
            {
                return;
            }
        }   
    }
    public func bruteForce() {
        self.solve()

        if isSolved {
            return
        }

        let optional = board.cells.enumerated().sorted(by:{left, right in 
        return left.1.values.count < right.1.values.count
        }).first(where: { !$0.1.isSet })

        guard let (index, cell) = optional else { return }

        for value in cell.values {

            var copy = self.board

            do {
                try copy.update(index: index, values: [value])
                print(copy)
            } catch let error {
                if error is ConsistencyError {
                    continue
                }
            }

            let solver = AI(board: copy)
            solver.bruteForce()
            
            if solver.isSolved {
                self.board = solver.board
                return
            }

        }
    }
}
