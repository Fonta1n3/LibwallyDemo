import Foundation
import CLibWally

public enum DataProvider: String {
    case blockstream = "https://blockstream.info/api/"
    case lightswap = "88.98.197.148:8333"
    case customers_node = ""
}



// https://nshipster.com/swift-documentation/
struct Mempool {
    /**
    A mempool...

    - Parameters:
         - name: ...
         - private_key: ...
         - node: ...
         - isMultiSig: ...
         - address_type: ...

    - Throws: None

    - Returns: An initialised wallet instance.
    */
    
    func feeEstimate() -> Data? {
        // Pulls fee estimates from a third party api. Returns JSON.
        return nil
    }
    
    func tx(transaction: String) -> Data? {
        // attempts to find a tx in the mempool and returns the data on its position in the queue IN JSON.
        return nil
    }
}


struct Node {
    /**
    A node ...

    - Parameters:
         - data_provider: the enum of the data provider

    - Throws: None

    - Returns: An initialised wallet instance.
    */
    
    public var data_provider: DataProvider
    
    public init?(_ description: DataProvider) {
        self.data_provider = description
    }
    
    func transaction(txid: String) -> Data? {
        /*
         1. Get the url from the data_provider variable
         2. Make an API call to the data provider, using the txid parameter, to obtain the transaction data
         3. Manipulate the returned data so that it is a Transaction() instance.
         4. Return the Transaction instance.
         
         For more info on how to create a Transaction instance see the documentation here: https://github.com/blockchain/libwally-swift under the section 'Create and sign a transaction:'
         */
        return nil
    }
    
    func balance(address: String) -> Data? {
        /*
          If the data provider is NOT the users node:
         
          1. Get the url from the data_provider variable
          2. Use the address parameter to get the bitcoin address
          3. Make a call to the data_provider e.g. https://blockstream.info/api/address/bc1qkhp5px67j4zgr3pg9kuzufp5c89qtq9tcrvsmf
          4. Calculate the balance which using blockstream or our local ESPLORA would be the following calculation, using the returned JSON: spent_txo_sum - funded_txo_sum
         
         NOT TO BE IMPLEMENTED YET:
         If the data provider is the users node:
         1. Get the url (IP address and port) from the data_provider variable
         2. Ping it to make sure it is avaialble
         3. Get all txid associated with this address, which we store in the database
         4. Make a RPC call to the node using 'gettransaction'
         */
        return nil
    }
    
    func broadcast(txid: String, when: Date = Date()) -> Data? {
        /*
         UPDATE: Whilst the below is true, using Esplora this should be equally easy. Please check the docs on how to do this, and then implement this via Esplora.
         
         Make a RPC call to the node call 'sendrawtransaction' with the txid as the parameter.
         
         Returns an object about the given transaction containing:
         "amount" : total amount of the transaction
         "confirmations" : number of confirmations of the transaction
         "txid" : the transaction ID
         "time" : time associated with the transaction[1].
         "details" - An array of objects containing:
         "account"
         "address"
         "category"
         "amount"
         "fee"
         
         Examples of how to do this in other languages are here:
         https://en.bitcoin.it/wiki/API_reference_(JSON-RPC)#Multi-wallet_RPC_calls
         
         Nodes that you can query for real data are here:
         https://bitnodes.io/nodes/live-map/
         
         or my node which is open to outside connections:
         88.98.197.148:8333
         
         */
        return nil
    }
    
    func isConnected(txid: String) -> Data? {
        // if there's an internet connection, and the DataProvider is us or the customers node, can we connect to the node, can you get a ping?
        return nil
    }
    
    
    
    
}

