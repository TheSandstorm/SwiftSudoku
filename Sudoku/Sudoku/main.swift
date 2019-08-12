//
//  main.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation

print("Welcome to the SudokuSolver\n Select if you wish to create a board or randomise a board")
print("(1) or (Create) Create your own board")
print("(2) or (Random) Create a random board")
var Board = SudokuBoard.init()
var IncorrectInput = true;
var Input = readLine();
while(IncorrectInput == true)
{
    switch Input {
    case "1", "Create", "create":
        Board.DrawBoard()
        IncorrectInput = false;
    case "2", "Random", "random":
        Board.RandomBoard()
        IncorrectInput = false;
    default:
        print("Please enter the details correctly")
        print("(1) or (Create) Create your own board")
        print("(2) or (Random) Create a random board")
        Input = readLine();
    }
}
Board.DrawBoard()

print("Hello, World!")

