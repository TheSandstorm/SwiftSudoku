import Foundation

extension Sequence {
    //array is the array that is doing a bool function for all within the array
    //Checks if all the elements in the array return true to having one element then it returns true if that is the case
    public func all(_ array: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            let result = try array(element)
            if !result {
                return false
            }
        }
        return true
    }

}
