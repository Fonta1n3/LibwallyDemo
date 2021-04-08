import Foundation
import CLibWally



public class Wallet {
    /**
    A wallet stores your keys and the information needed to redeem the funds it holds. A user can have multiple wallets for different purposes.

    - Parameters:
         - name: The *x* component of the vector.
         - private_key: The *y* component of the vector.
         - node: The *z* component of the vector.
         - isMultiSig: The *z* component of the vector.
         - address_type: The *z* component of the vector.

    - Throws: None

    - Returns: An initialised wallet instance.
    */
    
    public var name: String
    public let private_key: AnyObject
    public var node: DataProvider
    public var isMultiSig: Bool
    public var address_type: AddressType
    
    init(name: String, private_key: AnyObject, node: DataProvider = .blockstream, isMultiSig: Bool, address_type: AddressType) {
        self.name = name
        self.private_key = private_key
        self.node = node
        self.isMultiSig = isMultiSig
        self.address_type = address_type
    }
    
    
    func address(at_path: String?) -> Address? {
        /*
        1. Get private key.
        2. If the parameter 'at_path' is provided ensure the pk is a HD Key, else ensure the pk is a standard pk
        3. Get the address type from the class
        4. Generate an Address instance using this information
        5. Return the Address instance
        
        */
        return nil
    }
    
    func balance(address: String) -> Double? {
        // Given the address, create an instance of a node using the prefered node above, and fetch the balance.
        return nil
    }
    
    func balance(HDKey: String) -> String? {
        // Given the HD Key, create an instance of a node using the prefered node above, and fetch all of the balances.
        // Search for balances for upto 20 addresses after the last empty one.
        return nil
    }
    
    func transactions(HDKey: String) -> Data? {
        // Given the HD Key, create an instance of a node using the prefered node above, and fetch all of the transactions.
        // Search for transactions for upto 20 addresses after the last empty one.
        return nil
    }
    
    func send(amount: Double, to: String, when: Date = Date()) -> Bool {
        /*
         1. Create a transaction with all of the TXINs and TXOUTs and amount to spend.
         2. Create an instance of a node using the prefered data supplier
         3. Broadcast the transaction at the prefered time
         
         */
        return false
    }
    
}
