//
//  AI.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

public class AI {
    //Board value
    public var board: SudokuBoard
    //Starts with the board
    public init(board: SudokuBoard) 
    {
        self.board = board
    }
    //Checks if the board is solved
    public var isSolved: Bool 
    {
        return board.isSolved
    }
    public func solve()
    {
        while (!isSolved)
        {
            var valuesWereSetThisIteration = false;
            //Checks for each index of the array if that cell is first set. 
            //if not then looks at all possible values for that cell
            board.cells.enumerated().forEach({ index, cell in
            // Checks if the cell is set
                if cell.isSet{
                    return
                }
                //Fliter loops over the collection of values and return the elements that match the condition
                let possibleValues = (1...9).filter ({ value in
                    return board.isValueAllowed(index: index, toValue: value)
                })
                //If this happens. Something has gone wrong. The cell was not set but the board won't allow 1-9 at that cell.
                //Therefore board is incorrect
                if possibleValues.isEmpty {
                    return
                }
                if possibleValues.count == 1
                {
                    valuesWereSetThisIteration = true;
                }
                //Trys to update the board with this new value. Board has ? cause it might not have anything in it. 
                //But it should due to creating board correctly                            
                try? board.update(index: index, values: possibleValues)
                //Add another strategy
                if (valuesWereSetThisIteration == false)
                {
                    possibleValues.forEach({value in
                    if(valuesWereSetThisIteration == true)
                    {
                        return
                    }
                    if(board.isSingleValueRow(index: index, toValue: value) == true || board.isSingleValueColumn(index: index, toValue: value) == true || board.isSingleValueSmallGrid(index: index, toValue: value) == true)
                    {
                        let newCell = Cell(values: [value])
                        let rowIndex = index / 9 
                        let columnIndex = index % 9  
                        board.rows[rowIndex][columnIndex] = newCell
                        valuesWereSetThisIteration = true;     
                    }
                    })
                }
            })
            
            //If there was no change in board state then break the while.
            if(!valuesWereSetThisIteration)
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
