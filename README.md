# EKGProject

Made in part for BME261L at the University of Texas at Austin

Tuesday Section Group 1

Contributors: Karl Solomon, Peter Yu

## Project Overview

This software was developed to be used in conjunction with a portable ECG device powered by RaspberryPi. It was developed in Xcode 7.3 using Swift 2.2 for iOS 8+.

This software allows the user to input symptoms and toggle an ECG recording whenever the user believes he/she is undergoing cardiac discomfort. The RaspberryPi ECG is controlled via iOS application, where the user can also view and send ECG data on the app. 
### Software 

#### Front End

**Symptoms View Controller**
    
   The user is first prompted with the Symptoms Tab. IF the user feels a cardiac abnormality, he/she can select the "Record" button, which will signal the hardware to start recording ECG data. The user can then select and submit their symptoms from the portrayed list. 

**Archives View Controller**

   The Archives Tab allows the user to view all previous ECG readings separated by their date, time, and selected symptoms. The symptoms are given in abbreviated form, in which the dictionary with abbreviation keys to full names can be accessed by selecting "Dictionary." The user can select specific archived ECG data to view in graphical format. The specific lead can also be selected and viewed through the Picker View. The user can also send the archives via email attachment by accessing the iPhone's Mail application as well as delete any archived data.
    
**Live Feed View Controller**

   The Live Feed Tab allows the user to view live ECG readings presented in graphical format.
    
**Symptoms Legend View Controller**

   The Symptoms Legend shows the entire list of symptoms presented with definitions if necessary as well as abbreviations. 
    
**Picker View Controller**

   The Picker View allows the user to view multiple leads in a selected Archived ECG reading. Once selected, the specific lead is then portrayed in graphical format.

#### Back End

**SocketServer**
 
 The SocketServer consists of python scripts split up into several runnable classes that are called by a multithreading script. These classes establish two server socket ports specific to the IP address of the device. These ports are used to send bit data between RaspberryPi ECG and iOS app via internet connection. The scripts will control the ADC to read analog data given by the ECG circuit and send the data in .csv format. 
 
**SocketClient**
   
   The SocketClient is used to create a connection with the ServerSocket scripts. The client asks the server if the connection can be made, in which the server accepts the connection. The client receives bit data from the ServerSocket and parses the data into a CSV file through the CSVParse class. 
   
**Archive**
  
  Archive is a custom class created to store user inputted data as well as ECG data. Its fields include date, time, lead data, and symptoms saved from the user's selection. Archive also calls CSVParse in order to store the data locally as a .csv file.
  
**CSVParse**
  
  CSVParse is a class that converts the information stored as an Archive class into a .csv file. The file is saved to the Documents Directory of the application and can be accessed by the user in the Archives Tab.
  
**Symptoms**
   
   The Symptoms class holds static lists of common symptoms that occur during cardiac anomalies. These symptoms are tabulated and abbreviated, and they can be viewed and selected via the Symptoms Tab. 

### Hardware
1. Analog Logic
    1. Amplification
    2. Filtration
2. ADC
