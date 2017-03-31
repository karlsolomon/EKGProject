//
//  TextFileReader.swift
//  EKGShirt
//
//  Created by Yu, Peter M on 3/30/17.
//  Copyright © 2017 Solomon, Karl. All rights reserved.
//

import Foundation
struct Archive {
    var date: String?
    var time: String?
    var data: [Int16]
    
    init(date: String?, time: String?, data: [Int16]){
        self.date = date
        self.time = time
        self.data = data
        
    }
}
class TextFileReader {
    
    private var directory = String()
    private var fileList = [String]()
    
    init(){
        let location = NSString(string: "pmy89/EKGProject/EKGShirt").stringByExpandingTildeInPath
        self.setDirectory(location)
        
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
        let fileManager = NSFileManager.defaultManager()
        let enumerator:NSDirectoryEnumerator = fileManager.enumeratorAtPath(directory)!
        var list = [String]()
        for element in enumerator{
            if element.hasSuffix(".txt"){
                list.append(element as! String)
            }
        }
        return list
        
    }
    /*func extractAllFile(atPath path: String, withExtension fileExtension:String) -> [String] {
     let pathURL = NSURL(fileURLWithPath: path, isDirectory: true)
     var allFiles: [String] = []
     let fileManager = NSFileManager.defaultManager()
     if let enumerator = fileManager.enumeratorAtPath(path) {
     for file in enumerator {
     if let path = NSURL(fileURLWithPath: file as! String, relativeToURL: pathURL).path
     where path.hasSuffix(".\(fileExtension)"){
     allFiles.append(path)
     }
     }
     }
     return allFiles
     }*/
    func getFileList() -> [String]{
        return fileList
    }
    
    func readFile() -> [String]{
        var fileContent = [String]()
     //   for i in 0...fileList.count {
            let data = try? NSString(contentsOfFile: directory, encoding: NSUTF8StringEncoding)
            fileContent.append(data as! String)
     //   }
        return fileContent
    }
    func getArchive() -> Archive{
        var archive = Archive
        
        return
    }
    
    
    func numberofFiles() -> Int{
        return fileList.count
    }
}

var test = TextFileReader()
