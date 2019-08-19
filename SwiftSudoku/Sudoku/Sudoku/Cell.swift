import Foundation

internal struct Cell: Equatable, CustomStringConvertible
{
    public let values: [Int];

    // Checks if the cell only has 1 possible value in it
    public var isSet: Bool 
    {
        return values.count == 1;
    }
    //States what the cells value is. Ex: if set then its the value else it's 0
    public var description: String 
    {
        if isSet, let first = values.first
        {
            return  String(first);
        }
        return "0"
    }
    //Creates a set cell
    public static func Set(_ value: Int) -> Cell
    {
        return Cell(values: [value])
    }
    //Creates a Cell that has any of the 9 possible values
    public static func cellIsAnything() -> Cell
    {
        return Cell(values: Array(1...9));
        
    }
}
