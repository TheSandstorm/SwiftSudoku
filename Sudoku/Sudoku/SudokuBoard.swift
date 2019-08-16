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
    //Array of cells of the board
    public var rows: [[Cell]];

    public init(boardString: String) 
    {
        let characters = Array(boardString.characters)
        self.rows = (0..<9)
            .map({ rowIndex in
                return characters[rowIndex*9..<rowIndex*9+9]
            })
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
    //Combineds the array into a board
    public var cells: [Cell]
    {
        return Array(rows.joined())
    }
    //$0 is the first parameter passed in the closure
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
    //Gets the cell array within a grid
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
        return !self.row(forIndex: index).contains(.Set(value))
        && !self.column(forIndex: index).contains(.Set(value))
        && !self.smallGrid(forIndex: index).contains(.Set(value))
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

}
public struct ConsistencyError: Error 
{
}
