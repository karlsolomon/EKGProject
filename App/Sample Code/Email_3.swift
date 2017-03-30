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