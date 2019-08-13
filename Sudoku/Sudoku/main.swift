//
//  main.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation


var start = true;

func Start(Board: SudokuBoard)
{
    print("Welcome to the SudokuSolver\n Select if you wish to create a board or randomise a board")
    print("(1) or (Create) Create your own board")
    print("(2) or (Random) Create a random board")
    print("(q) or (Quit) Quit")
    
    var IncorrectInput = true;
    var Input = readLine();
    while(IncorrectInput == true)
    {
        switch Input {
        case "1", "Create", "create":
            Board.CreateBoard();
            Board.DrawBoard();
            IncorrectInput = false;
            for _ in 0..<100{
                print("");
            }
            start = false;
        case "2", "Random", "random":
            Board.RandomBoard();
            Board.DrawBoard();
            IncorrectInput = false;
            for _ in 0..<100{
                print("");
            }
            start = false;
        case "q","Q","Quit","quit":
            IncorrectInput = false;
            start = false;
            exit(0);
        default:
            print("Please enter the details correctly")
            print("(1) or (Create) Create your own board")
            print("(2) or (Random) Create a random board")
            Input = readLine();
        }
    }
}

func SolverStarts(Board: SudokuBoard)
{
    //var AI = AI.init()
}

while(true)
{
    
    var NewBoard = SudokuBoard.init()
    
    if(start == true )
    {
        Start(Board: NewBoard);
    }
    SolverStarts(Board: NewBoard);
    
}
