# EKGProject (EKG Shirt)

Made in part for BME261L at the University of Texas at Austin

Tuesday Section Group 1

Contributors: Karl Solomon, Peter Yu

## Project Overview

This software was developed to be used in conjunction with a portable ECG device powered by RaspberryPi. It was developed in Xcode 7.3 using Swift 2.2 for iOS 8+.

This software allows the user to input symptoms and toggle an ECG recording whenever the user believes he/she is undergoing cardiac discomfort. The RaspberryPi ECG is controlled via iOS application, where the user can also view and send ECG data on the app. The software requires an internet connection provided by the phone's hotspot as well as the EKG Shirt attached and powered.

### Software 


#### Front End

**SymptomsViewController.swift**
    
   The user is first prompted with the Symptoms Tab. IF the user feels a cardiac abnormality, he/she can select the "Record" button, which will signal the hardware to start recording ECG data. The user can then select and submit their symptoms from the portrayed list. 

**ArchivesViewController.swift**

   The Archives Tab allows the user to view all previous ECG readings separated by their date, time, and selected symptoms. The symptoms are given in abbreviated form, in which the dictionary with abbreviation keys to full names can be accessed by selecting "Dictionary." The user can select specific archived ECG data to view in graphical format. The specific lead can also be selected and viewed through the Picker View. The user can also send the archives via email attachment by accessing the iPhone's Mail application as well as delete any archived data.
    
**LiveFeedViewController.swift**

   The Live Feed Tab allows the user to view live ECG readings presented in graphical format. The data will display ECG data sent from 
    
**SymptomsLegendViewController.swift**

   The Symptoms Legend shows the entire list of symptoms presented with definitions if necessary as well as abbreviations. This is used when referencing abberviations listed on each Archive.
    
**PickerViewController.swift**

   The Picker View allows the user to view multiple leads in a selected Archived ECG reading. Once selected, the specific lead is then portrayed in graphical format. 

#### Back End - iOS Application

**SocketServer**
 
 The SocketServer consists of python scripts split up into several runnable classes that are called by a multithreading script. These classes establish two server socket ports specific to the IP address of the device. These ports are used to send bit data between RaspberryPi ECG and iOS app via internet connection. The scripts will control the ADC to read analog data given by the ECG circuit and send the data byte buffer format. Values will be read from 3 leads at a sampling rate of at least 125 Hz. Seperate port numbers wll be used for the Archive data and Live Feed data to ensure data purity.
 
**SocketClient.swift**
   
   The SocketClient is used to create a connection with the ServerSocket scripts. The client asks the server if the connection can be made, in which the server accepts the connection. The client then receives bit data from the ServerSocket and parses the data into a .csv file.
   
**LiveFeedClient.swift**

   The LiveFeedClient is used to create a connection with the livefeed.py server socket. The client sends the specified lead number (default: Lead 1) to the server, and the server responds with a 1 second buffoer of ECG data. The client then waits for 1 second and repeats the call/response protocol until the user exits the Live Feed tab. The lead number displayed can be changed through the PickerViewController.swift and selecting the desired lead number.

**Archive.swift**
  
  Archive is a custom class created to store user received ECG data as well as ECG data. Its fields include date, time, lead data, and symptoms saved from the user's selection. Each archive is assigned a unique URL in which the data is stored locally in the application's Document Directory. Archive also calls CSVParse to convert the received data's .csv file into integer arrays.
  
**CSVParse.swift**
  
  CSVParse is a class that converts the ECG information stored as a .csv file into The file is saved to the Documents Directory of the application and can be accessed by the user in the Archives Tab. The URL for the file is saved through the Archive class
  
**Symptoms.swift**
   
   The Symptoms class holds static lists of common symptoms that occur during cardiac anomalies. These symptoms are tabulated and abbreviated, and they can be viewed and selected via the Symptoms Tab. 

### Back End - RaspberryPi

**Main**
  Initiates all classes which are established as runnable threads as well as global variables and external libraries. These threads are run continuously as long as the RaspberryPi is active and powered.
  
**DataBuffer**
  DataBuffer stores the ECG data in integer arrays. The DataBuffer manipulates indices for 3 arrays (buffers) to delineate at least 2.5 minutes of data. The data sent from both archiveServer and livefeed are called through functions getArchiveData() and getLiveData() respectively. The dataBuffer buffers are updated via the ECGRead, and the indices for the buffers are incremented after each analog read. 
  
**ArchiveServer**

  ArchiveServer creates a server socket on the iPhone's IP address. The script first waits for an Archive client connection, and when a connection is established, ArchiveServer calls the getArchiveData() function from the DataBuffer class. Once the data is collected, the data is then sent to the client in a single array. 
  
**LiveFeed**
  LiveFeed creates a server socket on the iPhone's IP address. The script first waits for a Live Feed client connection, and when a connection is established, the server then waits for the lead number to be sent as a "key." The "key" determines which lead data to be called from the DataBuffer, and the relevant data is then sent to the client. If the connection is broken, the server waits for a new client connection to be established.
  
**ECGRead**
  ECGRead employs the WiringPi library, in which the script can manipulate the MCP3008 to output analog data through the function analogRead(). Each DataBuffer corresponding to the lead is updated with the captured ECG data. ECGRead runs continuously as long as the RasberryPi is powered. ECG readings are taken at a sampling rate of at least 125 Hz.
  
### Hardware
1. Analog Logic (For each of 3 leads)
    1. Amplification
    	AD8226 Instrumentation Amplifier
    2. Voltage Follower
    	TLV2774CN
2. ADC
	MCP3008 10 bit
