//
//  KeyChain.swift
//  TODO App
//
//  Created by BJIT on 20/10/1401 AP.
//

import Foundation


class KeyChainManager {
    
    static let shared = KeyChainManager()
    
    private init() {}
    
    func writeToKeyChain(account: String,service: String, data: Data) {
        
        let query = [
        kSecClass : kSecClassGenericPassword,
        kSecAttrAccount: account,
        kSecAttrService: service,
        kSecValueData: data
       ] as CFDictionary
          
        let status = SecItemAdd(query, nil)
        
        if status == errSecSuccess {
            print("Account Created Successfully")
        }
        
       else if status == errSecDuplicateItem {
            print("User Already Exist")
        }
        
        else {
            print("Account Creation Failed")
        }
        
    }
    
    func readFromKeyChain(account: String, service: String, userInputPass: String) -> Bool{
        
        var flag = false
        
        let query = [
            kSecClass : kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecAttrService: service,
            kSecReturnData: true,
            kSecReturnAttributes: true
        ] as CFDictionary
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query, &result)
        
        if status == errSecSuccess {
            if let result = result as? [CFString: Any] {
                print("kSecValueData", result[kSecValueData]!)
                print("kSecAttrAccount", result[kSecAttrAccount]!)
                print("kSecAttrService", result[kSecAttrService]!)
                
                if let data = result[kSecValueData] as? Data {
                    let password = try? JSONDecoder().decode(String.self, from: data)
                    
                    
                    if (password == userInputPass) {
                        flag = true
                    }
                    
                    print("Password: ", password!)
                }
            }
            return flag
        }
        else {
            print("Failed")
            return flag
        }
    }
    
//    func delete(account: String, service: String, data: Data) {
//
//        let query = [
//        kSecClass : kSecClassGenericPassword,
//        kSecAttrAccount: account,
//        kSecAttrService: service,
//        kSecValueData: data
//       ] as CFDictionary
//
//        let status = SecItemDelete(query)
//
//        if status == errSecSuccess {
//            print("Account Deleted Successfully")
//        }
//        else {
//            print("Account Deletion Failed")
//        }
//    }
//
//    func update(account: String, service: String, data: Data) {
//
//        let query = [
//        kSecClass : kSecClassGenericPassword,
//        kSecAttrAccount: account,
//        kSecAttrService: service,
//       ] as CFDictionary
//
//        let attributesToUpdate = [
//            kSecValueData: data
//        ] as CFDictionary
//
//        let status = SecItemUpdate(query, attributesToUpdate)
//
//        if status == errSecSuccess {
//            print("Update Successful")
//        }
//        else {
//            print("Update Failed")
//        }
//    }
}


