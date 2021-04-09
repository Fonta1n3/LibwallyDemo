//
//  ViewController.swift
//  LibwallyDemo
//
//  Created by Peter Denton on 4/7/21.
//

import UIKit
import LibWally

class ViewController: UIViewController {

    @IBOutlet weak private var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addressLabel.text = msigAddress()
        //createTx()
    }
    
    // MARK: CODE FOR CREATING A MULTISIG ADDRESS
    
    // Generates a new seed and creates a 2/2 bip67 witness script hash address from two random pubkeys derived from the same master key
    private func msigAddress() -> String? {
        guard let entropy = entropy(),
              let mnemonic = mnemonic(entropy),
              let masterKey = masterKey(mnemonic, "") else {
            
            return nil
        }
        
        guard let key1 = randomKey(masterKey),
              let key2 = randomKey(masterKey) else {
            
            return nil
        }
        
        let scriptPubKey = ScriptPubKey(multisig: [key1, key2], threshold: 2, bip67: true)
        
        guard let msigAddress = Address(scriptPubKey, .testnet) else { return nil }
        
        return msigAddress.description
    }
    
    // Creates the entropy for our seed via the cryptographically secure random number generator
    private func entropy() -> Data? {
        let bytesCount = 16
        var randomBytes = [UInt8](repeating: 0, count: bytesCount)
        let status = SecRandomCopyBytes(kSecRandomDefault, bytesCount, &randomBytes)
        
        if status == errSecSuccess {
            return Data(randomBytes)
        } else {
            return nil
        }
    }
    
    // Converts the entropy to a bip39 mnemonic
    private func mnemonic(_ entropy: Data) -> String? {
        let bip39Entropy = BIP39Entropy(entropy)
        
        guard let mnemonic = BIP39Mnemonic(bip39Entropy) else { return nil }

        return mnemonic.description
    }
    
    // Converts the mnemonic to the root key
    private func masterKey(_ words: String, _ passphrase: String) -> String? {
        guard let mnemonic = BIP39Mnemonic(words) else { return nil }
        
        let seedHex = mnemonic.seedHex(passphrase)
        
        guard let hdMasterKey = HDKey(seedHex, .testnet) else { return nil }
        
        return hdMasterKey.xpriv
    }
    
    // Derives a random witness script hash public key from the master key
    private func randomKey(_ masterKey: String) -> PubKey? {
        let randomIndex = Int.random(in: 1..<10000)
        
        guard let hdkey = HDKey(masterKey),
              let path = BIP32Path("m/48h/1h/0h/2h/0/\(randomIndex)"),
              let xpub = try? hdkey.derive(path) else {
            
            return nil
        }
        
        return xpub.pubKey
    }
    
    
    
    
    // MARK: CODE FOR CREATING A MULTISIG TRANSACTION
    
//    private func createTx() {
//        let wif1 = "cRtSbgrwqTUHXSCUqxF32LyubDwaJvsjjoVxSJ7CTFwUrLvaAqPq"
//        let wif2 = "cV7dwpvTTA5N2Zhw2Bb4DyaNsiHh9GoGtPHQcucaZ4dA1tEeLfVB"
//
//        guard let key1 = Key(wif1, .testnet) else { return }
//
//        guard let key2 = Key(wif2, .testnet) else { return }
//
//        let scriptPubKey = ScriptPubKey(multisig: [key1.pubKey, key2.pubKey], threshold: 2, bip67: true)
//
//        // tb1qymexfsv454rjg2ct65arrsg6fmcvazja7rag23geulfd6p32p9zq56dep0 has a balance of 0.0001 tbtc which will act as our input
//        guard let msigAddress = Address(scriptPubKey, .testnet) else { return }
//
//        // The txid of our input
//        guard let inputTx = Transaction("0fa000b5a87c6536f9af1a1495780435fe6efeb2670389bd260fceb7bf96432f") else { return }
//
//        let vout: UInt32 = 1
//        let amount: Satoshi = 10000
//
//        // PAIN POINT: LIBWALLY-SWIFT DOES NOT ALLOW US TO BUILD MULTISIG TRANSACTIONS, ONLY SINGLE SIG
//
//        //let witness = WitnessType.
//
//        //let input = TxInput(inputTx, vout, amount, nil, <#T##witness: Witness?##Witness?#>, scriptPubKey)
//
//    }

}

