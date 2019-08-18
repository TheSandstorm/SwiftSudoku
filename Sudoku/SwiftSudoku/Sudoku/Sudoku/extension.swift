import Foundation

extension Sequence {
    //predicate is the parameters for the bool function that has an array and it's going to check if the condition is true
    //Checks if all the elements in the array return true to having one element then it returns true if that is the case
    public func all(_ predicate: (Self.Iterator.Element) throws -> Bool) rethrows -> Bool {
        for element in self {
            let result = try predicate(element)
            if !result {
                return false
            }
        }
        return true
    }

}