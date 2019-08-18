//
//  main.swift
//  Sudoku
//
//  Created by John Strange on 5/08/19.
//  Copyright © 2019 John Strange. All rights reserved.
//

import Foundation


var start = true;

func clearScreen()
{
    for _ in 0..<100
    {
        print("");
    }
}

func createBoard() -> String
{
    var boardString = "";
    while (true)
    {
        if(boardString.count < 81)
        {
            var Input = readLine()
            var vaild = true
            if(Input != nil)
            {
                let string = Input
            }
            let characters = Array(Input.characters)
            characters.forEach({character in
                if let value = Int(String(character))
                {

                }
                else
                {
                    vaild = false;
                }
            })
            if(vaild == true)
            {
                boardString = 
            }
            
        }
        else if(boardString.count == 81)
        {
            var tempBoard = SudokuBoard(boardString: boardString);
            if(tempBoard.validBoard() == true)
            {
                return boardString
            }
            else
            {
                print("Board was not vaild.")
                boardString = ""
            }
        }
        else
        {
            print("Board was too long or contained letters. Resetting board")
            boardString = ""
        }   
    }
}
func selectBoard() -> String
{
    print("(1) or (Easy) board")
    print("(2) or (Medium) board")
    print("(3) or (Hard) board")
    print("(4) or (Example) board")
    var Input = readLine()
    while (true)
    {
        switch Input
        {
            case "1", "Easy", "easy":
                return "003020600900305001001806400008102900700000008006708200002609500800203009005010300";
            case "2", "Medium", "medium", "Mid", "mid":
                return "000000008300000500004300091001046750049000010070005000000400060000081004005000073";
            case "3", "Hard", "hard":
                return "000030002000900830100700540080004000000050080470000306000060415009501060600000000";
            case "4","Example", "example":
                return "800406007000000400010000650509030780000070000048020103052000090001000000300902005";
            default:
            print("Please enter the details correctly")
            print("(1) or (Easy) board")
            print("(2) or (Medium) board")
            print("(3) or (Hard) board")
            print("(4) or (Example) board")
            Input = readLine()
        }
    }

}
func randomBoard() -> String
{
    return ""
}
func Start() -> SudokuBoard
{
    var boardString = "";
    while(true)
    {
    print("Welcome to the SudokuSolver\nSelect if you wish to create a board or randomise a board")
    print("(1) or (Create) Create your own board")
    print("(2) or (Random) Create a random board")
    print("(3) or (Preset) Create a preset board")
    print("(q) or (Quit) Quit")
    var mainInput = readLine();
        switch mainInput 
        {
        case "1", "Create", "create":       
            clearScreen()
            boardString = createBoard()
            let m_Board = SudokuBoard(boardString: boardString);
            start = false;
            return m_Board;
        case "2", "Random", "random":
            clearScreen()         
            boardString = randomBoard();
            let m_Board = SudokuBoard(boardString: boardString);
            print("Board");
            print(m_Board);
            start = false;
            return m_Board;
        case "3", "Preset", "preset":
            clearScreen()
            boardString = selectBoard();
            let m_Board = SudokuBoard(boardString: boardString);
            print("Board");
            print(m_Board);
            start = false;
            return m_Board;
        case "q","Q","Quit","quit":
            exit(0);
        default:
            mainInput = readLine();
            clearScreen()
            print("Please enter the details correctly")
        }
    }
}
while(true)
{   
    if(start == true )
    {
        let Board = Start();
        let Solver = AI(board: Board);
        Solver.solve()
        if(Solver.isSolved)
        {
            print("Board solved using normal solver");
        } 
        else 
        { 
            print(Solver.board);
            print("Board solver failed. Switching to bruteforce mode");
            while (!Solver.isSolved)
            {
                Solver.bruteForce()
            }
        }        
        print(Solver.board);
    }  
    print("Do you wish to quit?")
    print("(1) or (Restart) Restart the system")
    print("(q) or (Quit) Quit")
    var Input = readLine();
    switch Input
    {
        case "1","Restart","restart":
        start = true;
        case "Quit","quit", "q", "Q":
        exit(0);
        default:
        clearScreen()
        print("Please enter the details correctly")
        Input = readLine();
    }
}