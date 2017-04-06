//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
class Socket{
    
    
    
    var inputStream = NSInputStream()
    var outputStream = NSOutputStream()
    func main(){
        
    }
func asciiToInt(buffer: [UInt8])-> String{
    var result = String()
    for i in buffer{
        //    print(String(UnicodeScalar(i)))
        result += String(UnicodeScalar(i))
    }
    return result
}
func initNetworkCommunication(){
    let addr = "10.146.6.161"
    let port = 8080
    
    //  var host :NSHost = NSHost(address : addr)
    var inp :NSInputStream?
    var out :NSOutputStream?
    NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
    //  NSStream.getStreamsToHost(host, port: port, inputStream: &inp, outputStream: &out)
    
    self.inputStream = inp!
    self.outputStream = out!
    inputStream.open()
    outputStream.open()
    
    
}
func receiveData()->[String]{
    var dataList = [String]()
    var buffer: [UInt8] = [1,2,3]
    var readByte = [UInt8](count: 4, repeatedValue: 0)
    while inputStream.hasBytesAvailable {
        inputStream.read(&readByte, maxLength: 5)
        outputStream.write(&buffer, maxLength: buffer.count)
        print(dataList.append(asciiToInt(readByte)))
    }
    print(readByte)
    
    return dataList
}
}
