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
    var data: [[Int16]]
    
    init(date: String?, time: String?, data: [[Int16]]){
        self.date = date
        self.time = time
        self.data = data
        
    }
}
class TextFileReader {
    
    private var directory = String()
    private var fileList = [String]()
    
    init(){
        let location = NSString(string: "Users/pmy89/EKGProject/EKGShirt").stringByExpandingTildeInPath
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
        var list = [String]()
        let fileManager = NSFileManager.defaultManager()
        let path = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let docsDir = path[0].path
        
        let filelist = try? fileManager.contentsOfDirectoryAtPath(docsDir!)
        for file: String in filelist!{
            if file.containsString(".txt"){
                let targetPath = docsDir! + "/" + file
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
    func getArchive() -> [Archive]{
        var archiveList = [Archive]()
        let dataArray = readFile()
        var intvalueArray = [Int16]()
        var intArray = [[Int16]]()
        //separates lead data string into Int16 matrix
        for (key,value) in dataArray{
            var dataString = dataArray[key]
            var leadArray = dataString?.componentsSeparatedByString("\n")
            for i in 0..<leadArray!.count{ // index starts at 2 to avoid the date and time
                var valueArray = leadArray![i].componentsSeparatedByString(" ")
                for j in 1..<valueArray.count{
                    intvalueArray.append(Int16(valueArray[j])!)
                }
                intArray.append(intvalueArray)
            }
            
            
            var datetime = key.componentsSeparatedByString("_")
            var date = datetime[0]
            var time = datetime[1]
            var newArchive = Archive(date: date, time: time, data: intArray)
            archiveList.append(newArchive)
        }
     return archiveList
        
    }
    
    
    func numberofFiles() -> Int{
        return fileList.count
    }
}

var test = TextFileReader()
