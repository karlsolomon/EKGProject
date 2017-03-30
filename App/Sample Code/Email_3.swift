func sendEmail(archiveFile) {
    if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject("")
        mail.addAttachmentData(archiveFile.getCSVData(), mimeType: "text/plain", fileName: "\(archiveFile.getTimeStamp()).csv")
        present(mail, animated: true)
    } else {
        // show failure alert
    }
}

func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    controller.dismiss(animated: true)
}


class ArchiveFile {
    var csvData: [Int];
    var timeStamp: String;

    init(csvData: [Int]) {
        self.csvData = csvData
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        self.timeStamp = "\(month)-\(day)-\(year) \(hour):\(minutes)"
    }

}



import Foundation
import UIKit
import MessageUI
 
class EmailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var recordingDetails = ""
    var recordingDetailsArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        recordingDetailsArr = recordingDetails.componentsSeparatedByString(",")
    }
    
    @IBAction func sendEmailButtonTapped(sender: AnyObject) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["karl.solomon20@gmail.com"])
        mailComposerVC.setSubject("EKG Recording")
        mailComposerVC.setMessageBody("Time: \(recordingDetailsArr[0]) \nSymptoms: \(recordingDetailsArr[1])", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}