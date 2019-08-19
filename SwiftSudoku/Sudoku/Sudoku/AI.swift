//
//  AI.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

internal class AI {
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
                    //Checks each row column and grid seperately for only one possible spot
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
                print(board)
                if(backTracking())
                {
                    print("Solution successful")
                }
                else
                {
                    print("Not Solveable")
                }
                return;
            }
        }   
    }
    public func backTracking() -> Bool {
        if(isSolved)
        {
            return true;
        }
        let currentIndex = board.getNextNotSet()
        if(currentIndex == -1)
        {
            return true;
        }
        for value in (1...9)
        {
            if(board.isValueAllowed(index: currentIndex, toValue: value))
            {
                let newCell = Cell(values: [value])
                let rowIndex = currentIndex / 9
                let columnIndex = currentIndex % 9
                let oldCell = board.rows[rowIndex][columnIndex]
                board.rows[rowIndex][columnIndex] = newCell
                if (backTracking())
                {
                    return true
                }
                board.rows[rowIndex][columnIndex] = oldCell
            }
        }
        // Checks if the cell is set
        return false;
    }
}
