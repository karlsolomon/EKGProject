//
//  TextFileReader.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 3/30/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation

class TextFileReader {
    
    private var directory = String()
    private var fileList = [String]()
    private var fileNames = [String]()
    
    init(){
        fileList = findTextfiles()
    }
    internal func setDirectory(dir: String){
        self.directory = dir
    }
    func findTextfiles() -> [String]{
        var list = [String]()
        let fileManager = NSFileManager.defaultManager()
        let path = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docsDir = path[0].path
        setDirectory(docsDir!)
        let filelist = try? fileManager.contentsOfDirectoryAtPath(docsDir!)
        
        for file: String in filelist!{
            if file.containsString(".txt"){
                let targetPath = docsDir! + "/" + file
                fileNames.append(file)
                list.append(targetPath)
                
            }
        }
        return list
        
    }

    func getFileList() -> [String]{
        return fileList
    }
    private func setFileList(list: [String]){
        fileList = list
    }
    func numberofFiles() -> Int{
        return fileList.count
    }
}

