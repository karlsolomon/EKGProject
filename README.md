# EKGProject

Made in part for BME261L at the University of Texas at Austin

Tuesday Section Group 1

Contributors: Karl Solomon, Peter Yu

## Project Overview

This software was developed to be used in conjunction with a portable ECG device powered by RaspberryPi. It was developed in Xcode 7.3 using Swift 2.2 for iOS 8+.

This software allows the user to input symptoms and toggle an ECG recording whenever the user believes he/she is undergoing cardiac discomfort. The RaspberryPi ECG is controlled via iOS application, where the user can also view and send ECG data on the app. 
### Software 

#### Front End
* Symptoms View Controller
* Archives View Controller
* Live Feed View Controller
* Symtpoms Legend View Controller
* Picker View Controller

#### Back End
* SocketServer
	The SocketServer consists of python scripts split up into several runnable classes that are called by a multithreading script. These classes establish two server socket ports specific to the IP address of the device. These ports are used to send bit data between RaspberryPi ECG and iOS app via internet connection. The scripts will control the ADC to read analog data given by the ECG circuit and send the data in .csv format. 
* SocketClient
	The SocketClient is used to create a connection with the ServerSocket scripts. The client asks the server if the connection can be made, in which the server accepts the connection. The client receives bit data from the ServerSocket and parses the data into a CSV file through the CSVParse class. 
* Archive
	Archive is a custom class created to store user inputted data as well as ECG data. It 
* CSVParse
* Symptoms

### Hardware
1. Analog Logic
    1. Amplification
    2. Filtration
2. ADC
