//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

public class SudokuBoard: CustomStringConvertible
{
    //Array of cells of the board 2d
    public var rows: [[Cell]];

    public init(boardString: String) 
    {
        //holds an array of characters that should == 81
        let characters = Array(boardString.characters)
        //Sets up the board to be 9 rows
        self.rows = (0..<9)
        //maps the characters
            .map({ rowIndex in
                return characters[rowIndex*9..<rowIndex*9+9]
            })
            //Sets the values for each cell of the board
            .map({ rawRow in
                return rawRow.map({ character in
                    if character == "0" {
                        return Cell.cellIsAnything()
                    } else if let value = Int(String(character)) {
                        return Cell.Set(value)
                    } else {
                        fatalError()
                    }
                })
            })
    }
    //joined puts values between a nest of values
    //Combineds the array
    public var cells: [Cell]
    {
        return Array(rows.joined())
    }
    //$0 is the first parameter passed in the closure
    //This is what gets printed out
    public var description: String
    {
        return self.rows.map({row in 
        return "|" + row.map({ $0.description }).joined(separator: " ") + "|\n"
        })
        .joined()
    }
    //Checks if the board is solved
    public var isSolved: Bool 
    {
        return self.cells.all({ $0.isSet})
    }
    //Gets the row cell array
    public func row(forIndex index: Int) -> [Cell]
    {
        let rowIndex = index / 9;
        return rows[rowIndex];
    }
    //Gets the column cell array
    public func column(forIndex index: Int) -> [Cell]
    {
        let columnIndex = index % 9;
        return self.rows.map({ row in
        return row[columnIndex]
        })
    }
    //Gets the cell array of a grid
    public func smallGrid(forIndex index: Int) -> [Cell]
    {
        let rowIndex = index/9;
        let columnIndex = index % 9;
        let minigridColumnIndex = columnIndex / 3;
        let minigridRowIndex = rowIndex / 3;
        return (0..<3).flatMap({ rowOffset in 
        return self.rows[minigridRowIndex * 3 + rowOffset][minigridColumnIndex * 3..<minigridColumnIndex * 3 + 3]
        })
    }
    //Checks if the value is already in the row, column or minigrid. if true then it's not ok to place.
    public func isValueAllowed(index: Int, toValue value: Int) -> Bool 
    {
        //It check each cell in its array if it contains that set value. It doesn't set the value
        return !self.row(forIndex: index).contains(.Set(value))
        && !self.column(forIndex: index).contains(.Set(value))
        && !self.smallGrid(forIndex: index).contains(.Set(value))
    }
    //Simlier to isValueAllowed except it's looking for only on possible value is in the row
    public func isSingleValueRow(index: Int, toValue value: Int) -> Bool 
    {
        var count = 0
        self.row(forIndex: index).forEach({cell in
        if(cell.values.contains(value))
        {
            count += 1
        }
        })
        if count > 1
        {
            return false
        }
        return true
    }
    
    public func isSingleValueColumn(index: Int, toValue value: Int) -> Bool 
    {
        var count = 0
        self.column(forIndex: index).forEach({cell in
        if(cell.values.contains(value))
        {
            count += 1
        }
        })
        if count > 1
        {
            return false
        }
        return true
    }

    public func isSingleValueSmallGrid(index: Int, toValue value: Int) -> Bool 
    {
        var count = 0
        self.smallGrid(forIndex: index).forEach({cell in
        if(cell.values.contains(value))
        {
            count += 1
        }
        })
        if count > 1
        {
            return false
        }
        return true
    }

    public func update(index: Int, values: [Int]) throws 
    {
        // 
        if values.count == 1,
            let value = values.first,
            !self.isValueAllowed(index: index, toValue: value) {
            throw ConsistencyError()
        }
        //Sets the cell a new value
        let newCell = Cell(values: values)
        let rowIndex = index / 9
        let columnIndex = index % 9
        self.rows[rowIndex][columnIndex] = newCell
    }
    public func Error(index: Int) 
    {
        if index == 1
        {
            print("Values entered are not correct")
        }
    }
    public func validBoard() -> Bool
    {
        var valid = true;
        self.cells.enumerated().forEach({ index, cell in
            if cell.isSet
            {
                return
            }
            //Fliter loops over the collection of values and return the elements that match the condition
            let possibleValues = (1...9).filter ({ value in
            return self.isValueAllowed(index: index, toValue: value)
            })
            //If this happens. Something has gone wrong. The cell was not set but the board won't allow 1-9 at that cell.
            //Therefore board is incorrect
            if possibleValues.isEmpty 
            {
                valid = false;
            }
        })
        return valid
    }
}


public struct ConsistencyError: Error 
{
}
