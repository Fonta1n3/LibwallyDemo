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
    }
    
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

}

