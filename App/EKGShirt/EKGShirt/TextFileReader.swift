//
//  TextFileReader.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 3/30/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

//TODO: DEPRECATED

import Foundation

class TextFileReader {
    
    private var directory = String()
    private var fileList = [String]()
    private var fileNames = [String]()
    
    init(){
       // let location = NSString(string: "Users/pmy89/EKGProject/EKGShirt").stringByExpandingTildeInPath
     //   self.setDirectory(location)
        
        /*let folderPath = NSBundle.mainBundle().pathForResource("Files", ofType: nil)
         setDirectory(folderPath!)
         self.fileList = extractAllFile(atPath: self.directory, withExtension: "txt")
         */
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
        
 
      /*  let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(docsDir!)!
       
        for element in enumerator{
            if element.hasSuffix(".txt"){
                list.append(element as! String)
            }
        }*/
        return list
        
    }

    func getFileList() -> [String]{
        return fileList
    }
    private func setFileList(list: [String]){
        fileList = list
    }
    func readFile() -> [String: String]{
        var fileContent = [String:String]()
        for i in 0..<fileList.count {
            
            let data = try? NSString(contentsOfFile: fileList[i], encoding: NSUTF8StringEncoding)
            
            fileContent.updateValue(data as! String, forKey: fileList[i])
        }
        return fileContent
    }

    
    func numberofFiles() -> Int{
        return fileList.count
    }
}

//var test = TextFileReader()
