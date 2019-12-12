//
//  PopoverViewController.swift
//  News
//
//  Created by John Grooms on 10/9/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import UIKit
import MessageUI
import Firebase





class PopoverViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, MFMailComposeViewControllerDelegate, UIPopoverPresentationControllerDelegate {


  func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
  {
      textField.resignFirstResponder()
      return true;
  }
  
 // func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
 //   textView.resignFirstResponder()
 //   return true
 //  }
  
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       if(text == "\n") {
           textView.resignFirstResponder()
           return false
       }
       return true
   }
  
 
  var manualAdds = [ManualArticle]()
  var manualArts = ManualArticle()
  var manualArts1 = ManualArticle()
  var manualArts2 = ManualArticle()
  var manualArts3 = ManualArticle()


  var dbREF:DatabaseReference?

  
  
  @IBOutlet weak var title1: UITextField! = nil
  @IBOutlet weak var url1: UITextField!
  @IBOutlet weak var urlImage1: UITextField!
  @IBOutlet weak var animal1: UITextField!
  
  
  @IBOutlet weak var title2: UITextField!
  @IBOutlet weak var url2: UITextField!
  @IBOutlet weak var urlImage2: UITextField!
  @IBOutlet weak var animal2: UITextField!
  
  @IBOutlet weak var title3: UITextField!
  @IBOutlet weak var url3: UITextField!
  @IBOutlet weak var urlImage3: UITextField!
  @IBOutlet weak var animal3: UITextField!
  
  @IBOutlet weak var textView: UITextView!
  
 
  @IBOutlet weak var imageView: UIImageView!
  
  @IBAction func title1(_ sender: Any) {
    

    
 //   func sendEmail(allAddresses: [EmailAddress], imageView: UIImageView? ) {
       func sendEmail(allAddresses: [EmailAddress]) {

  

    var toRecipients: [String] = [" "]
    toRecipients.removeAll()
    for email in allAddresses {
      toRecipients.append(email.emailAddress ?? " ")
    }
    
    
   
      if MFMailComposeViewController.canSendMail() {
           let mail = MFMailComposeViewController()
           mail.mailComposeDelegate = self
        mail.setToRecipients(["animauled@yahoo.com"])
        mail.setBccRecipients(toRecipients)
        mail.setPreferredSendingEmailAddress("animauled@yahoo.com")
        mail.setSubject("New Animal Attacked reported")
   //     mail.setMessageBody("<p>A new animal attack has been reported!</p>", isHTML: true)
        mail.setMessageBody(textView.text, isHTML: true)
        
        
    //    let imageData: NSData = imageView.image!.pngData()! as NSData
    //    mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
        
        guard let filePath = Bundle.main.path(forResource: "SimplePDF", ofType: "pdf") else {
                       return
                   }
                   let url = URL(fileURLWithPath: filePath)
                   
        
        do {
               /*    let attachmentData = try Data(contentsOf: url)
                       mail.addAttachmentData(attachmentData, mimeType: "application/pdf", fileName: "SimplePDF")
        */
 
          let imageData: NSData = imageView.image!.pngData()! as NSData
             mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
                      
                   } catch let error {
                       print("We have encountered error \(error.localizedDescription)")
                   }
        
        
        
 //       let imageData: NSData = imageView?.image!.pngData()! as! NSData
 //       mail.addAttachmentData(imageData as Data, mimeType: "image/png", fileName: "imageName.png")
    

           present(mail, animated: true)
       } else {
           // show failure alert
       }

   
    
    
    
    }




       
       if title1.text! == "email" {
         
         dbREF = Database.database().reference()
        
        
        
        
        
        
        
        // Get email addresses
         var allAddresses: [EmailAddress] = []
        
     //  let handle = dbREF?.child("emailAddresses").queryLimited(toLast: 1000).queryOrdered(byChild: // "emailAddress").observe(.value, with: { (snapshot) in

            self.dbREF?.child("emailAddresses").observeSingleEvent(of: .value, with: { (snapshot) in

            
            
            allAddresses.removeAll()
            
            // Get all of the children objects of the snapshot
            let snapshots = snapshot.children.allObjects as! [DataSnapshot]
            
            // go through each child snapshot
            for snap in snapshots {
              
              // cast snapshot value as dictionary
              let employeeDict = snap.value as! [String:Any]
              
              let key = snap.key
              
              
              var emailAddress = " "
              if employeeDict["emailAddress"] != nil {
                emailAddress = employeeDict["emailAddress"] as! String
              }
              
              
              var name = " "
              if employeeDict["name"] != nil {
                name = employeeDict["name"] as! String
              }
              
                
              
              let e = EmailAddress(emailAddress: emailAddress, name: name)
              
              allAddresses.append(e)
              
              
            }
          
          
          sendEmail(allAddresses: allAddresses)
          })
          
        
        
        
        
        
        
        
        
   //     sendEmail(allAddresses: allAddresses)
        
   //   dismiss(animated: true) {
   //       }
        
  }
  }
  

  
 
 
  
  
  @IBAction func showImagePicker(_ sender: UIButton) {
    self.imagePicker.present(from: sender)
  }
  
  
  
  @IBAction func cancelArticles(_ sender: UIButton) {
    dismiss(animated: true) {
       }
    
  }
  
  @IBAction func processArticles(_ sender: Any) {

   
//    MFMailComposeViewControllerDelegate.self
//    UIPopoverPresentationControllerDelegate.self
 
    
    //   print(title1.text!)
  //    dismiss(animated: true) {
   //   }
    
    manualArts1.title = title1.text!
    manualArts1.url = url1.text!
    manualArts1.urlImage = urlImage1.text!
    manualArts1.animal = animal1.text!
    manualAdds.append(manualArts1)

    manualArts2.title = title2.text!
    manualArts2.url = url2.text!
    manualArts2.urlImage = urlImage2.text!
    manualArts2.animal = animal2.text!
    manualAdds.append(manualArts2)

    manualArts3.title = title3.text!
    manualArts3.url = url3.text!
    manualArts3.urlImage = urlImage3.text!
    manualArts3.animal = animal3.text!
    manualAdds.append(manualArts3)
    
    manualArts.ProcessAdds( manualArticles : manualAdds)
    
    
    
  
    
    
    
    dismiss(animated: true) {
      }
    
//    DispatchQueue.main.async {
 //      self.delegate?.processArticles(title, url, urlImage, animal)
 //   }
  }
  
 
 var imagePicker: ImagePicker!
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
    self.imagePicker = ImagePicker(presentationController: self, delegate: self)
//      dbREF = Database.database().reference()
    
    
    
    
    
    
    
 /*   // Get email addresses
     var allAddresses: [EmailAddress] = []
    
      let handle = dbREF?.child("emailAddresses").queryLimited(toLast: 1000).queryOrdered(byChild: "emailAddress").observe(.value, with: { (snapshot) in

        
        
        allAddresses.removeAll()
        
        // Get all of the children objects of the snapshot
        let snapshots = snapshot.children.allObjects as! [DataSnapshot]
        
        // go through each child snapshot
        for snap in snapshots {
          
          // cast snapshot value as dictionary
          let employeeDict = snap.value as! [String:Any]
          
          let key = snap.key
          
          
          var emailAddress = " "
          if employeeDict["emailAddress"] != nil {
            emailAddress = employeeDict["emailAddress"] as! String
          }
          
          
          var name = " "
          if employeeDict["name"] != nil {
            name = employeeDict["name"] as! String
          }
          
            
          
          let e = EmailAddress(emailAddress: emailAddress, name: name)
          
          allAddresses.append(e)
          
          
        }
        
      
      })
      
    
    
    
 */
    
    
    
    

      title1.delegate=self
      url1.delegate=self
     urlImage1.delegate=self
     animal1.delegate=self
    
     title2.delegate=self
     url2.delegate=self
    urlImage2.delegate=self
    animal2.delegate=self

     title3.delegate=self
     url3.delegate=self
    urlImage3.delegate=self
    animal3.delegate=self

    MFMailComposeViewControllerDelegate.self
         UITextViewDelegate.self
        // Do any additional setup after loading the view.
  
      UIPopoverPresentationControllerDelegate.self

       self.textView.delegate = self
        self.textView.layer.borderWidth = 1.0
    
  }
  
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.layer.borderColor = UIColor.red.cgColor
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    textView.layer.borderColor = UIColor.clear.cgColor
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
      controller.dismiss(animated: true)
  }
  
  
 
  // logic to limit text field length - just uncomment. this is for ALL text fields
  /*
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      // get the current text, or use an empty string if that failed
      let currentText = textField.text ?? ""

      // attempt to read the range they are trying to change, or exit if we can't
      guard let stringRange = Range(range, in: currentText) else { return false }

      // add their new text to the existing text
      let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

      // make sure the result is under 16 characters
      return updatedText.count <= 5
  }
  */
  
  
}


extension PopoverViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.imageView.image = image
    }
}
