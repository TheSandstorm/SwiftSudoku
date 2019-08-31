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
// Creates a board. This is done by either using 81 length string or entering each value manually
func createBoard() -> String
{
    var boardString = "";
    while (true)
    {
        print("Do you wish to enter a 81 length string or enter each value 1 by 1")
        print("1. 81 String\n2. Enter 1 by 1")
        let Input = readLine();
        switch Input
        {
            case "1", "String", "string":
            var stringMenu = true;
            while (stringMenu)
            {
                print("Enter a 81 length string that contains values 0-9 where 0 is blank.\nOr just enter 'b' or 'B' to head back to the previous menu.");
                let stringInput = readLine();
                if let tempString = stringInput
                {
                    if(tempString.count < 81)
                    {
                        if(tempString == "b" || tempString == "B")
                        {
                            stringMenu = false;
                        }
                        else
                        {
                            print("The String that was entered was too short. Or was not 0")
                        }
                    }
                    else if(tempString.count == 81)
                    {
                        var vaild = true
                        let characters = Array(tempString)
                        characters.forEach({character in
                            if Int(String(character)) != nil
                            {
                                    
                            }
                            else
                            {
                                vaild = false;
                            }
                        })
                        if(vaild == true)
                        {
                            boardString = tempString
                            let tempBoard = SudokuBoard(boardString: boardString);
                            if(tempBoard.validBoard() == true)
                            {
                                return boardString
                            }
                            else
                            {
                                print("Input was not valid. Contains a two of the same value in the row, column or grid")
                                boardString = ""
                            }
                        }
                        else
                        {
                            print("Board was not vaild. Contained a letter or other char")
                            boardString = ""
                        }
                    }
                    else
                    {
                        print("String was too long.")
                    } 
                } 
            }
            case "2":
            var secondInput = true;
            boardString = "000000000000000000000000000000000000000000000000000000000000000000000000000000000";
            var currentIndex = 0;
            let tempBoard = SudokuBoard(boardString: boardString)
            while (secondInput)
            {
                if(currentIndex >= 81)
                {
                    return boardString;
                }
                print(tempBoard);
                print("Current Position",currentIndex)
                print("Enter a value that's is from 0-9 where 0 is blank.\nOr just enter b to head back to the previous menu.");
                let stringInput = readLine();
                if let tempString = stringInput
                {
                    var valid = true;
                    if(tempString == "b" || tempString == "B")
                    {
                        secondInput = false;
                    }
                    else if(tempString.count == 1)
                    {
                        let characters = Array(tempString)
                        characters.forEach({character in
                            if Int(String(character)) != nil
                            {
                                    
                            }
                            else
                            {
                                valid = false;
                            }
                        })
                        if(valid == true)
                        {
                            let characters = Array(tempString)
                            if let value = Int(String(characters[0]))
                            {
                                if(tempString == "0")
                                {
                                    currentIndex += 1;
                                }
                                else if(tempBoard.isValueAllowed(index: currentIndex, toValue: value))
                                {
                                    let newCell = Cell(values: [value])
                                    let rowIndex = currentIndex / 9
                                    let columnIndex = currentIndex % 9
                                    tempBoard.rows[rowIndex][columnIndex] = newCell
                                    currentIndex += 1;
                                }
                                else
                                {
                                    print("Value was not allowed at that position")
                                }
                            }
                        }
                        else
                        {
                            print("Enter a number. Not a letter");
                        }
                    }
                    else
                    {
                        print("Enter only 1 value");
                    }
                }
            } 
            default:
            print("Please enter the details correctly")
        }
        
    }
}
// Selects a premade board
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
//creates a random board.
func randomBoard() -> String
{
    var boardString = "000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    let tempBoard = SudokuBoard(boardString: boardString);
    if(tempBoard.randomBoard())//creates a random completed board
    {
        print("Random board Created\n",tempBoard);
    }
    var isValueNotCorrect = true;
    var Input = 0;
    //allows a set amount of values to be removed from the randomly created board
    while isValueNotCorrect {
        print("Enter a value between 1-81 to be removed")
        guard let numberValue = readLine() else { return "" };
        if let value = Int(String(numberValue))
        {
            Input = value;
        }
        else
        {
            Input = 0;
        }
        switch Input
        {
        case 1...81:
            isValueNotCorrect = false;
            
        default:
            print("Try again")
        }
    }
    if(Input == 81)
    {
        return boardString;
    }
    while (Input != 0)
    {
        let Row = Int.random(in: 0...8);
        let Column = Int.random(in: 0...8);
        tempBoard.rows[Row][Column] = Cell.cellIsAnything()
        Input -= 1;
    }

    boardString = tempBoard.stringOutput();
    return boardString;
}
//Start menu of the program
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
//Main loop
while(true)
{   
    if(start == true )
    {
        let Board = Start();
        let Solver = AI(board: Board);
        Solver.solve()
        print(Solver.board);
    }  
    print("Do you wish to quit?")
    print("(1) or (Restart) Restart the system")
    print("(q) or (Quit) Quit")
    let Input = readLine();
    switch Input
    {
        case "1","Restart","restart":
        start = true;
        case "Quit","quit", "q", "Q":
        exit(0);
        default:
        clearScreen()
        print("Please enter the details correctly")
    }
}
