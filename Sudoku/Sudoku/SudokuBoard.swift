//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

class SudokuBoard
{
    var Board = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    init() {
        
    }
    func RandomBoard()
    {
        
    }
    func CheckBoard()
    {
        
    }
    func DrawBoard()
    {
        for col in 0..<9
        {
            for row in 0..<9
            {
                if (row == 3 || row == 6)
                {
                    print("| ", terminator:"");
                }
                print(Board[col][row], terminator:" ");
            }
            if (col == 2 || col == 5)
            {
                print("\n------+-------+-------");
            }
            else
            {
                print("");
            }
        }
    }
}
