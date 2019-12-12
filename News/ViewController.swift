//
//  ViewController.swift
//  News
//
//  Created by John Grooms on 4/25/19.
//  Copyright © 2019 John Grooms. All rights reserved.
//

import UIKit
import Firebase
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {


  var model = ArticleModel()

  var articles = [Article]()
  var dbRef:DatabaseReference?
  var databaseUpdateModel = DatabaseUpdateModel()
  
  var databaseArticles = [DatabaseArticle]()
 // var databaseHandles = [UInt]()
  
  var titleArray = [String]()
  var titleArrayDates = [String]()

  
  var uniqueArticle : Bool = false
  var databaseUpdated : Bool = false
  
  var calculatedAnimal : String = " "
  
  var version = "Version 1.01.01"
  
  @IBOutlet weak var tableView: UITableView!
  
  
  @IBOutlet weak var versionNumber: UILabel!
  
// UIBarButtonItem
   
  @IBAction func displayPopover(_ sender: UIBarButtonItem) {
    let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "PopoverViewController")
    vc.modalPresentationStyle = .popover
    let popover: UIPopoverPresentationController = vc.popoverPresentationController!
    popover.barButtonItem = sender
    present(vc, animated: true, completion:nil)
    
 
  }
  
  @IBAction func eMailButton(_ sender: UIButton) {
    
  }
  
  
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    
    edgesForExtendedLayout = []
    
    Auth.auth().signInAnonymously { (authResult, error) in
      if let error = error {
        print("Sign in failed:", error.localizedDescription)
        
        
        
      } else {
        
        let user = authResult!.user
        let isAnonymous = user.isAnonymous  // true
        let uid = user.uid
        
        
        print ("Signed in with uid:", user, uid)
        
         self.listenForData()
          print("listen for data is done")

        
      }
    }
   
    
    func testFunction() {
      
    }
    
    // Conform to the table view protocols
    tableView.delegate = self
    tableView.dataSource = self
     model.delegate = self
    MFMailComposeViewControllerDelegate.self
    
// key 7d2881a5533e4233962fb032a78019fd
// key 821bf9e74592442591a67792d401f5a6
    
    var searchStringArray = ["Https://newsapi.org/v2/everything?q=(%22shark%20attack%22%20OR%20%22crocodile%20attack%22%20OR%20%22bear%20attack%22%20OR%20%22tiger%20attack%22%20OR%20%22lion%20attack%22%20OR%20%22hippo%20attack%22%20OR%20%22dog%20attack%22%20OR%20%22wolf%20attack%22%20OR%20%22deer%20attack%22%20OR%20%22buffalo%20attack%22%20OR%20%22elephant%20attack%22%20OR%20%22leopard%20attack%22%20OR%20%22cougar%20attack%22%20OR%20%22dingoes%20attack%22%20OR%20%22snake%20attack%22%20OR%20%22shark%20bite%22%20OR%20%22shark%20spotted%22%20OR%20%22crocodile%20spotted%22%20OR%20%22croc%20attack%22%20OR%20%22crocodile%20kills%22%20OR%20%22shark%20kills%22%20OR%20%22bear%20kills%22%20OR%20%22lions%20kill%22%20OR%20%22tiger%20kills%22%20OR%20%22mauled%20by%20a%22%20OR%20%22mauled%20by%20an%22%20OR%20%22bitten%20by%20a%20shark%22%20OR%20%22angry%20elephant%22%20OR%20%22angry%20hippo%22%20OR%20%22angry%20rhino%22%20OR%20%22elephants%20charge%22%20OR%20%22attacked%20by%20bees%22%20OR%20%22stung%20to%20death%22%20OR%20%22shark%20killed%22%20OR%20%22killed%20by%20lions%22)%20-vacuum%20-baby%20-jose%20-game%20-loan%20-terrorist%20-tears%20-jihadi%20-manufacturer%20-heart%20-phone%20-rape%20-murder%20-aircraft%20-military%20-jet%20-boeing%20-criminal-%20-airport%20-isis%20-movie%20-trump%20-election%20-player%20-nra%20-market%20-theatre%20-music%20-islamic%20-nutrients%20-nutricion%20-sexually%20-bomb%20-spam%20-website%20-gameplay%20-hardware%20-financial%20-feminist%20-stadium%20-championship%20-endgame%20-missiles%20-destroyer%20-cabinet%20-contest%20-gasoline%20-oil%20-electricity%20-netflix%20-episode%20-bank%20-war%20-email%20-cancer%20-overdose%20-debt%20-facebook%20-bible%20-internet%20-mastermind%20-contest%20-blast%20-philosopher%20-philosophy%20-robotic%20-football%20-league%20-album%20-songs%20-diablo%20-blizzard%20-sex%20-pregnancy%20-muslim%20-islam%20-jewish%20-israel%20-rugby%20-cup%20-rugby%20-prizewinning%20-rugby%20-design%20-gaming%20-bitcoin%20-theives%20-artwork%20-hijab%20-genre%20-song&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
      
      "https://newsapi.org/v2/everything?q=(%22shark%20attack%22%20OR%20%22shark%20attacks%22%20OR%20%22shark%20bite%22%20OR%20%22shark%20bites%22%20OR%20%22bitten%20by%20a%20shark%22%20OR%20%22shark%20spotted%22%20OR%20%22shark%20kills%22%20OR%20%22attacked%20by%20a%20shark%22%20OR%20%22killed%20by%20a%20shark%22%20OR%20%22killed%20by%20sharks%22%20OR%20%22attacked%20by%20sharks%22%20OR%20%22eaten%20by%20sharks%22%20OR%20%22sharks%20kill%22%20OR%20%22sharks%20attack%22)%20-funds%20-game%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
        "https://newsapi.org/v2/everything?q=(%22crocodile%20attack%22%20OR%20%22crocodile%20attacks%22%20OR%20%22crocodile%20bite%22%20OR%20%22crocodile%20bites%22%20OR%20%22bitten%20by%20a%20crocodile%22%20OR%20%22crocodile%20spotted%22%20OR%20%22crocodile%20kills%22%20OR%20%22attacked%20by%20a%20crocodile%22%20OR%20%22killed%20by%20a%20crocodile%22%20OR%20%22killed%20by%20crocodiles%22%20OR%20%22attacked%20by%20crocodiles%22%20OR%20%22eaten%20by%20crocodiles%22%20OR%20%22crocodiles%20kill%22%20OR%20%22crocodiles%20attack%22%20OR%20%22alligator%20attack%22%20OR%20%22alligator%20attacks%22%20OR%20%22alligator%20bite%22%20OR%20%22alligator%20bites%22%20OR%20%22bitten%20by%20an%20alligator%22%20OR%20%22alligator%20spotted%22%20OR%20%22alligator%20kills%22%20OR%20%22attacked%20by%20an%20alligator%22%20OR%20%22killed%20by%20an%20alligator%22%20OR%20%22killed%20by%20alligators%22%20OR%20%22attacked%20by%20alligators%22%20OR%20%22eaten%20by%20alligators%22%20OR%20%22alligators%20kill%22%20OR%20%22alligators%20attack%22)%20-funds%20-game%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
        "https://newsapi.org/v2/everything?q=(%22bear%20attack%22%20OR%20%22bear%20attacks%22%20OR%20%22bear%20bites%22%20OR%20%22bitten%20by%20a%20bear%22%20OR%20%22bear%20spotted%22%20OR%20%22bear%20kills%22%20OR%20%22attacked%20by%20a%20bear%22%20OR%20%22killed%20by%20a%20bear%22%20OR%20%22killed%20by%20bears%22%20OR%20%22attacked%20by%20bears%22%20OR%20%22eaten%20by%20bears%22%20OR%20%22bears%20kill%22%20OR%20%22bears%20attack%22%20OR%20%22tiger%20attack%22%20OR%20%22tiger%20attacks%22%20OR%20%22tiger%20bites%22%20OR%20%22bitten%20by%20a%20tiger%22%20OR%20%22tiger%20spotted%22%20OR%20%22tiger%20kills%22%20OR%20%22attacked%20by%20a%20tiger%22%20OR%20%22killed%20by%20a%20tiger%22)%20-chicago%20-detroit%20-NFL%20-funds%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
        
        "https://newsapi.org/v2/everything?q=(%22lion%20attack%22%20OR%20%22lion%20attacks%22%20OR%20%22lion%20bites%22%20OR%20%22bitten%20by%20a%20lion%22%20OR%20%22lion%20spotted%22%20OR%20%22lion%20kills%22%20OR%20%22attacked%20by%20a%20lion%22%20OR%20%22killed%20by%20a%20lion%22%20OR%20%22killed%20by%20lions%22%20OR%20%22attacked%20by%20lions%22%20OR%20%22eaten%20by%20lions%22%20OR%20%22lions%20kill%22%20OR%20%22lions%20attack%22%20OR%20%22leopard%20attack%22%20OR%20%22leopard%20attacks%22%20OR%20%22leopard%20bites%22%20OR%20%22bitten%20by%20a%20leopard%22%20OR%20%22leopard%20spotted%22%20OR%20%22leopard%20kills%22%20OR%20%22attacked%20by%20a%20leopard%22%20OR%20%22killed%20by%20a%20leopard%22%20OR%20savaged%20OR%20savages%20OR%20maul%20OR%20mauls%20OR%20mauled)%20-funds%20-game%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
                       
                             "https://newsapi.org/v2/everything?q=(%22elephant%20attack%22%20OR%20%22elephant%20attacks%22%20OR%20%22elephant%20kills%22%20OR%20%22attacked%20by%20an%20elephant%22%20OR%20%22killed%20by%20an%20elephant%22%20OR%20%22killed%20by%20elephants%22%20OR%20%22attacked%20by%20elephants%22%20OR%20%22elephants%20kill%22%20OR%20%22elephants%20attack%22%20OR%20%22hippo%20attack%22%20OR%20%22hippo%20attacks%22%20OR%20%22hippo%20kills%22%20OR%20%22attacked%20by%20a%20hippo%22%20OR%20%22killed%20by%20a%20hippo%22%20OR%20%22killed%20by%20hippos%22%20OR%20%22attacked%20by%20hippos%22%20OR%20%22hippos%20kill%22%20OR%20%22hippos%20attack%22%22rhino%20attack%22%20OR%20%22rhino%20attacks%22%20OR%20%22rhino%20kills%22%20OR%20%22attacked%20by%20a%20rhino%22%20OR%20%22killed%20by%20a%20rhino%22%20OR%20trample%20OR%20tramples%20OR%20trampled)%20-game%20-funds%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
                             "https://newsapi.org/v2/everything?q=(%22stung%20by%22%20OR%20%22bitten%20by%22%20OR%20%22eaten%20by%22%20OR%20%22stung%20to%20death%22%20OR%20%22mauled%20by%22%20OR%20%22gored%20by%22)%20-game%20-funds%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
                             "https://newsapi.org/v2/everything?q=(jellyfish%20OR%20stingray%20OR%20octopus%20OR%20snakebite%20OR%20cougar%20OR%20dingo%20OR%20dingoes%20OR%20coyote%20OR%20coyotes)%20-game%20-funds%20-dress%20-music%20-song%20-halloween%20-trump%20-car&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",

                             "https://newsapi.org/v2/everything?q=(stag%20OR%20moose%20OR%20deer%20OR%20snake%20OR%20spider%20OR%20cobra%20OR%20wasps%20OR%20bees%20OR%20rattlesnake%20OR%20centipede%20OR%20swarm%20OR%20rats%20OR%20monkey%20OR%20monkeys%20OR%20chimps%20OR%20chimp)%20-fund%20-funds%20-game%20-%22spider-man%22%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6",
                             "https://newsapi.org/v2/everything?q=(insect%20OR%20infested%20OR%20bull%20OR%20rabid%20OR%20buffalo%20OR%20bisen%20OR%20scorpion%20OR%20grizzly)%20-game%20-funds%20-market%20-investors%20-consumer%20-bills%20-stocks%20-%22red%20bull%22%20-dress%20-music%20-song%20-halloween%20-trump&sortBy=publishedAt&language=en&apiKey=821bf9e74592442591a67792d401f5a6"
    ]
    

    
    
    // Get the articles from article model
    var firstTimePause = false
    
    for stringURL in searchStringArray {
    model.getArticles(stringURL)
      
      if firstTimePause != true {
      sleep(2)
      firstTimePause = true
    }
      
    }
    
    
    
    
    // Set version number label
    versionNumber.text = version
    
    // get database reference
    dbRef = Database.database().reference()
    
   // listenForData()
   //  print("listen for data is done")
    
  
/*    let animal = "testshark"
    let publishedDate = "2019-05-10T06:34:34Z"
    let employeeData:[String : Any] = ["animal" : animal, "author":"John Grooms", "content" : "This is the content", "description": "This is the description", "publishedAt" : publishedDate, "title": "No Beast is the title", "url" : "www.drudgereport.com", "urlToImage" : "www.image.com", "dateAndAnimal" : (publishedDate+animal) ]
    
    dbRef?.child("NewsOrgArticles").childByAutoId().setValue(employeeData, withCompletionBlock: { (error, ref) in
      
      if error == nil {
        //successful
      } else {
        //unsuccessful
      }
    })
*/
    
  }


  // fires whenever a segue is about to occur, gives access to destination view controller
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // get article user tapped on
    let indexPath = tableView.indexPathForSelectedRow
    
    guard indexPath != nil else {
      print("User didn't select an article")
      return
    }
    
    let article = articles[indexPath!.row]
    
    // get a reference to the detailed view controller
    let detailVC = segue.destination as! DetailViewController
  
    // set the articleurL property for detailed view conroller
    detailVC.articleUrl = article.url
    
  }
  
/*  override func viewDidAppear(_ animated: Bool) {
    
    //  readDataOnce()
    listenForData()
    print("listen for data is done")
  }
*/
  
  override func viewWillDisappear(_ animated: Bool) {
    
    // close database references
 //   for handle in databaseHandles {
 //     dbRef?.removeObserver(withHandle: handle)
 //   }
  }
  
  
  
  
  
  func listenForData() {
    
    let date = Date()
    let minute:TimeInterval = 60.0
    let hour:TimeInterval = 60.0 * minute
    let day:TimeInterval = 24 * hour
    let convertedTitleDateFrom = Date(timeInterval: (-4 * day), since: date)
    
    let formatter2 = DateFormatter()
    formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
    let defaultTimeZoneStr = formatter2.string(from: convertedTitleDateFrom)
    
    
    
    //   let handle = dbRef?.child("articles").queryOrdered(byChild: "title").observe(.value, with: { (snapshot) in
    
    //   let handle = dbRef?.child("articles").queryOrdered(byChild: "title").observe(.value, with: { (snapshot) in
    
    let _ = dbRef?.child("articles").queryOrdered(byChild: "publishedAt").queryStarting(atValue: defaultTimeZoneStr).observeSingleEvent(of: .value, with: { (snapshot) in
      
      
      //        let handle = dbREF?.child("articles").queryOrdered(byChild: "animal").observe(.value, with: { (snapshot) in
      
      
      
      // Get all of the children objects of the snapshot
      let snapshots = snapshot.children.allObjects as! [DataSnapshot]
      
      // Clear new array before parsing employees
      //    self.employees.removeAll()
      self.databaseArticles.removeAll()
      
      // go through each child snapshot
      for snap in snapshots {
        
        // cast snapshot value as dictionary
        let newsDict = snap.value as! [String:Any]
        
        // get the data for an employee
        /*       let name = snap.key
         let age = newsDict["age"] as! Int
         let likes = newsDict["likes"] as! String
         let role = newsDict["role"] as! String */
        
        let key = snap.key
        
        
        
        
        var author = " "
        if newsDict["author"] != nil {
          author = newsDict["author"] as! String
        }
        
        var content = " "
        if newsDict["content"] != nil {
          content = newsDict["content"] as! String
        }
        
        var description = " "
        if newsDict["description"] != nil {
          description = newsDict["description"] as! String
        }
        
        var publishedAt = " "
        if newsDict["publishedAt"] != nil {
          publishedAt = newsDict["publishedAt"] as! String
        }
        
        
        
        var title = " "
        if newsDict["title"] != nil {
          title = newsDict["title"] as! String
        }
        
        var animal = "other"
        if newsDict["animal"] != nil {
          animal = newsDict["animal"] as! String
        }
        
        self.calculatedAnimal = animal
        
        
        
        var url = " "
        if newsDict["url"] != nil {
          
          url = newsDict["url"] as! String
        }
        
        var urlToImage = " "
        if newsDict["urlToImage"] != nil {
          
          urlToImage = newsDict["urlToImage"] as! String
        }
        
        var sourceId = " "
        if (newsDict as NSDictionary).value(forKeyPath: "source.id") != nil {
          sourceId = (newsDict as NSDictionary).value(forKeyPath: "source.id")! as! String
        }
        
        var sourceName = " "
        if (newsDict as NSDictionary).value(forKeyPath: "source.name") != nil {
          sourceName = (newsDict as NSDictionary).value(forKeyPath: "source.name")! as! String
        }
        
        
        
        
        
        
        
        
        //create an employee
        //       let e = Employee(name: name, age: age, likes: likes, role: role)
        
        /*      let e = NewsArticle(key: key, author: author, content: content, description: description, publishedAt: publishedAt, title: title, url: url, urlToImage: urlToImage, animal: animal)
         
         */
        
        let e = DatabaseArticle(key: key, author: author, content: content, description: description, publishedAt: publishedAt, title: title, url: url, urlToImage: urlToImage, animal: animal)
        
        
        /*   let newsData:[String : Any] = ["animal" : animal, "calculatedAnimal" : self.calculatedAnimal, "author": author, "content" : content, "description": description, "publishedAt" : publishedAt, "title": title, "url" : url, "urlToImage" : urlToImage, "dateAndAnimal" : (publishedAt+animal), "sourceId" : sourceId, "sourceName" : sourceName ]
         */
        
        
        let newsData:[String : Any] = ["animal" : animal, "author": author, "content" : content, "description": description, "publishedAt" : publishedAt, "title": title, "url" : url, "urlToImage" : urlToImage, "dateAndAnimal" : (publishedAt+animal), "sourceId" : sourceId, "sourceName" : sourceName ]
        
        
        
        // Add logic to
        
        
        
        if (newsDict as NSDictionary).value(forKeyPath: "source.id") != nil {
          print("source id is \((newsDict as NSDictionary).value(forKeyPath: "source.id")!)")
        }
        
        if (newsDict as NSDictionary).value(forKeyPath: "source.name") != nil {
          print("source name is \((newsDict as NSDictionary).value(forKeyPath: "source.name")!)")
        }
        
        //        print("source is \(newsDict["source]")
        
        
        
        
        
        // add them to array
        //        self.employees.append(e)
        self.databaseArticles.append(e)
        self.titleArray.append(title)
        self.titleArrayDates.append(publishedAt)
        
        
      } // for snap in snapshots
      
      
      print("all snapshots done")
      print("database articles \(self.databaseArticles.count)")
      print("new articles count \(self.articles.count)")
      
      // Stop listeners - required data has been retrieved
      //     for handle in self.databaseHandles {
      //       self.dbRef?.removeObserver(withHandle: handle)
      //     }
      //     self.databaseHandles.removeAll()
      
    }) // let handle
    
    
    // Check if the handle is nil, else save it
    // if handle != nil {
    //    databaseHandles.append(handle!)
    //  }
    
  }
  
  
  
  
} // func listenfordata





















  
  
  




extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
  // return number of articles
    return articles.count
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    // Get a cell
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
    
    
    
    // assign the index of the youtuber to button tag
    cell.addArticleButton.tag = indexPath.row
    // call the subscribeTapped method when tapped
    cell.addArticleButton.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)
          
    
  
    
    
    
    
    // Get the article that table view is trying to display
    let article = articles[indexPath.row]
    
    
      cell.headlineLabel.textColor = UIColor.black
    
  
    if article.added != nil {
    if article.added! {
        cell.headlineLabel.textColor = UIColor.red
      
      }}
    
    
    
    // Customize it
    cell.displayArticle(article)
   
    // if news articles all retrieved and database articles all retrieved, an handles closed
    // and database hasn't been updated yet, update database and set flag
    
    databaseUpdated = true // remove this to update file automatically
    
    if databaseUpdated == false && self.databaseArticles.count > 0 && self.articles.count > 0
      //
       // && self.databaseHandles.count == 0
    {

      databaseUpdateModel.writeUniqueArticles(articles: articles , titleArray: titleArray, titleArrayDates: titleArrayDates)
      databaseUpdated = true
    
    }
    
    
    
    
    // return that cell
    return cell
    
    // TODO: Customize it
    
  }
  
  
  @objc func subscribeTapped(_ sender: UIButton){
    // use the tag of button as index
    print(sender.tag)
    
  //   sender.backgroundColor = UIColor.red
    
    // get article user tapped on
       let indexPath = sender.tag
       
    

    
    // redisplay article in red
    articles[indexPath].added = true
    tableView.reloadData()
    
    
    var article = articles[indexPath]
 //   article.added = true;
       
 
    
    // copy article link to clipboard
   let pasteboard = UIPasteboard.general
   pasteboard.string = article.url
  

 print(sender.tag)
    
    
    if titleArray.contains(article.title!) {
          return
        }
          
    
    titleArray.append(article.title!)
          
    
    
     // Calculate animal type
    
    
    if article.title!.prefix(4) == " ☠️  " {
      let str5 = article.title!.suffix(article.title!.count-4)
      article.title! = String(str5)
    }
    
    
    let calculatedAnimal = lookupAnimal(upperCaseTitle: article.title!.uppercased())
    
            let date = Date()
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
            let defaultTimeZoneStr = formatter2.string(from: date)
            
            let employeeData:[String : Any] = ["animal" : calculatedAnimal, "publishedAt" : defaultTimeZoneStr , "title": article.title ?? " ", "url" : article.url ?? " ", "urlToImage" : article.urlToImage ?? " "]

      
            
            dbRef?.child("articles").childByAutoId().setValue(employeeData, withCompletionBlock: { (error, ref) in
              
              if error == nil {
                //successful
              } else {
                //unsuccessful
              }
            })
    
  } // subscribedTapped
  
  
  
  func lookupAnimal(upperCaseTitle: String) -> String{
    
    switch upperCaseTitle {
    case _ where upperCaseTitle.contains("SHARK"):
      calculatedAnimal = "shark"
    case _ where upperCaseTitle.contains("GREAT WHITE"):
      calculatedAnimal = "shark"
    case _ where upperCaseTitle.contains("CROCODILE"):
      calculatedAnimal = "crocodile"
    case _ where upperCaseTitle.contains("CROC"):
      calculatedAnimal = "crocodile"
    case _ where upperCaseTitle.contains("ELEPHANT"):
      calculatedAnimal = "elephant"
    case _ where upperCaseTitle.contains("SEA LION"):
      calculatedAnimal = "sea lion"
    case _ where upperCaseTitle.contains("MOUNTAIN LION"):
      calculatedAnimal = "mountain lion"
    case _ where upperCaseTitle.contains("LION") && !upperCaseTitle.contains("MILLION"):
      calculatedAnimal = "lion"
    case _ where upperCaseTitle.contains("TIGER"):
      calculatedAnimal = "tiger"
    case _ where upperCaseTitle.contains("ALLIGATOR"):
      calculatedAnimal = "alligator"
    case _ where upperCaseTitle.contains("GATOR"):
      calculatedAnimal = "alligator"
    case _ where upperCaseTitle.contains("WOLF"):
      calculatedAnimal = "wolves"
    case _ where upperCaseTitle.contains("WOLVES"):
      calculatedAnimal = "wolves"
    case _ where upperCaseTitle.contains("DINGO"):
      calculatedAnimal = "dingoes"
    case _ where upperCaseTitle.contains("LEOPARD SEAL"):
      calculatedAnimal = "leopard seal"
    case _ where upperCaseTitle.contains("LEOPARD"):
      calculatedAnimal = "leopard"
    case _ where upperCaseTitle.contains("COUGAR"):
      calculatedAnimal = "mountain lion"
    case _ where upperCaseTitle.contains("PUMA"):
      calculatedAnimal = "mountain lion"
    case _ where upperCaseTitle.contains("PANTHER"):
      calculatedAnimal = "mountain lion"
      case _ where upperCaseTitle.contains("COYOTE"):
        calculatedAnimal = "coyote"
      
    case _ where upperCaseTitle.contains("JAGUAR"):
      calculatedAnimal = "jaguar"
    case _ where upperCaseTitle.contains("HIPPO"):
      calculatedAnimal = "hippo"
    case _ where upperCaseTitle.contains("DOG"):
      calculatedAnimal = "canine"
      case _ where upperCaseTitle.contains("STAFFORDSHIRE TERRIER"):
        calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("LABRADOR"):
      calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("ROTTWEILER"):
      calculatedAnimal = "canine"
      
    case _ where upperCaseTitle.contains("PIT BULL"):
      calculatedAnimal = "canine"
      case _ where upperCaseTitle.contains("PITBULL"):
         calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("BULL TERRIER"):
      calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("GREAT DANE"):
      calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("HOUND"):
      calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("POODLE"):
      calculatedAnimal = "canine"
    case _ where upperCaseTitle.contains("GERMAN SHEPHERD"):
      calculatedAnimal = "canine"
      
      case _ where upperCaseTitle.contains("DACHSHUND"):
           calculatedAnimal = "canine"
      case _ where upperCaseTitle.contains("HUSKY"):
           calculatedAnimal = "canine"
      
      case _ where upperCaseTitle.contains("PUPPY"):
           calculatedAnimal = "canine"
      case _ where upperCaseTitle.contains("PUPPIES"):
           calculatedAnimal = "canine"
      
      
    case _ where upperCaseTitle.contains("BEAR"):
      calculatedAnimal = "bear"
    case _ where upperCaseTitle.contains("GRIZZLY"):
      calculatedAnimal = "bear"
    case _ where upperCaseTitle.contains("GRIZZLIES"):
      calculatedAnimal = "bear"
    case _ where upperCaseTitle.contains("SNAKE"):
      calculatedAnimal = "snake"
      case _ where upperCaseTitle.contains("ANACONDA"):
        calculatedAnimal = "snake"
    case _ where upperCaseTitle.contains("COBRA"):
      calculatedAnimal = "snake"
    case _ where upperCaseTitle.contains("PYTHON"):
      calculatedAnimal = "snake"
      case _ where upperCaseTitle.contains("BOA CONSTRICTOR"):
        calculatedAnimal = "snake"
    case _ where upperCaseTitle.contains("SPIDER"):
      calculatedAnimal = "spider"
    case _ where upperCaseTitle.contains("BLACK WIDOW"):
      calculatedAnimal = "spider"
    case _ where upperCaseTitle.contains("TARANTULA"):
      calculatedAnimal = "spider"
    case _ where upperCaseTitle.contains("RHINO"):
      calculatedAnimal = "rhino"
    case _ where upperCaseTitle.contains("BISON"):
      calculatedAnimal = "bison"
    case _ where upperCaseTitle.contains("DEER"):
      calculatedAnimal = "deer"
    case _ where upperCaseTitle.contains("STAG"):
      calculatedAnimal = "deer"
    case _ where upperCaseTitle.contains("MOOSE"):
      calculatedAnimal = "moose"
    case _ where upperCaseTitle.contains("STINGRAY"):
      calculatedAnimal = "stingray"
    case _ where upperCaseTitle.contains("OCTOPUS"):
      calculatedAnimal = "octopus"
    case _ where upperCaseTitle.contains("SQUID"):
      calculatedAnimal = "squid"
      
    case _ where upperCaseTitle.contains("JELLYFISH"):
      calculatedAnimal = "jellyfish"
      case _ where upperCaseTitle.contains("COCKROACH"):
          calculatedAnimal = "cockroach"
      
    case _ where upperCaseTitle.contains("ELK"):
      calculatedAnimal = "elk"
    case _ where upperCaseTitle.contains("WHALE"):
      calculatedAnimal = "whale"
    case _ where upperCaseTitle.contains("CAMEL"):
      calculatedAnimal = "camel"
    case _ where upperCaseTitle.contains("ZEBRA"):
      calculatedAnimal = "zebra"
    case _ where upperCaseTitle.contains("BEE") && !upperCaseTitle.contains("BEEN"):
      calculatedAnimal = "bees"
    case _ where upperCaseTitle.contains("SKUNK"):
      calculatedAnimal = "skunk"
    case _ where upperCaseTitle.contains("RACOON"):
      calculatedAnimal = "raccoon"
    case _ where upperCaseTitle.contains("RACCOON"):
      calculatedAnimal = "raccoon"
    case _ where upperCaseTitle.contains("FOX"):
      calculatedAnimal = "fox"
    case _ where upperCaseTitle.contains("OTTER"):
      calculatedAnimal = "otter"
    case _ where upperCaseTitle.contains("BOBCAT"):
      calculatedAnimal = "bobcat"
    case _ where upperCaseTitle.contains("CATTLE"):
      calculatedAnimal = "cattle"
    case _ where upperCaseTitle.contains("COW"):
           calculatedAnimal = "cattle"
    case _ where upperCaseTitle.contains("CATERPILLER"):
      calculatedAnimal = "caterpiller"

    case _ where upperCaseTitle.contains("WALRUS"):
      calculatedAnimal = "walrus"
    case _ where upperCaseTitle.contains("SEAGULL"):
      calculatedAnimal = "seagull"
    case _ where upperCaseTitle.contains("TURTLE"):
      calculatedAnimal = "turtle"
    case _ where upperCaseTitle.contains("KANGAROO"):
      calculatedAnimal = "kangaroo"
    case _ where upperCaseTitle.contains("GIRAFFE"):
      calculatedAnimal = "giraffe"
    case _ where upperCaseTitle.contains("WALRUS"):
      calculatedAnimal = "walrus"
    case _ where upperCaseTitle.contains("SEAL"):
      calculatedAnimal = "SEAL"
    case _ where upperCaseTitle.contains("KOMODO") && upperCaseTitle.contains("DRAGON"):
      calculatedAnimal = "komodo dragon"
    case _ where upperCaseTitle.contains("BULL") && !upperCaseTitle.contains("BULLET"):
      calculatedAnimal = "bull"
    case _ where upperCaseTitle.contains("HOG"):
      calculatedAnimal = "hog"
    case _ where upperCaseTitle.contains("PIG"):
      calculatedAnimal = "pig"
    case _ where upperCaseTitle.contains("HORSE"):
      calculatedAnimal = "horse"
    case _ where upperCaseTitle.contains("SLOTH"):
      calculatedAnimal = "sloth"
    case _ where upperCaseTitle.contains("MONKEY"):
      calculatedAnimal = "primates"
      case _ where upperCaseTitle.contains("BABOON"):
        calculatedAnimal = "primates"
      case _ where upperCaseTitle.contains("GORILLA"):
        calculatedAnimal = "primates"
      case _ where upperCaseTitle.contains("CHIMP"):
        calculatedAnimal = "primates"
    case _ where upperCaseTitle.contains("CRICKET"):
      calculatedAnimal = "crickets"
    case _ where upperCaseTitle.contains("PORTUGUESE MAN O' WAR"):
      calculatedAnimal = "portuguese man o' war"
    case _ where upperCaseTitle.contains("HORNET"):
      calculatedAnimal = "hornets"
    case _ where upperCaseTitle.contains("WASP"):
      calculatedAnimal = "wasps"
      case _ where upperCaseTitle.contains("YELLOW JACKET"):
        calculatedAnimal = "wasps"
      case _ where upperCaseTitle.contains("FISH"):
        calculatedAnimal = "fish"

      case _ where upperCaseTitle.contains("MOUSE"):
        calculatedAnimal = "rodents"
      case _ where upperCaseTitle.contains("MICE"):
        calculatedAnimal = "rodents"
      case _ where upperCaseTitle.contains("SCORPION"):
        calculatedAnimal = "scorpion"
      case _ where upperCaseTitle.contains("PEACOCK"):
        calculatedAnimal = "bird"
      case _ where upperCaseTitle.contains("OSTRICH"):
        calculatedAnimal = "bird"
      case _ where upperCaseTitle.contains("ROOSTER"):
        calculatedAnimal = "bird"

      case _ where upperCaseTitle.contains("WOMBAT"):
        calculatedAnimal = "wombat"
      case _ where upperCaseTitle.contains("BOAR"):
        calculatedAnimal = "boar"
      case _ where upperCaseTitle.contains(" ANTS "):
        calculatedAnimal = "ants"
      case _ where upperCaseTitle.contains(" ANT "):
         calculatedAnimal = "ants"
      case _ where upperCaseTitle.contains("INSECT"):
         calculatedAnimal = "insects"
      case _ where upperCaseTitle.contains("CAT"):
        calculatedAnimal = "cat"
      case _ where upperCaseTitle.contains("LOCUST"):
        calculatedAnimal = "insects"
      case _ where upperCaseTitle.contains("ROACH"):
        calculatedAnimal = "insects"
      
      case _ where upperCaseTitle.contains("BEDBUG"):
        calculatedAnimal = "insects"
      case _ where upperCaseTitle.contains("LOCUST"):
        calculatedAnimal = "insects"
      case _ where upperCaseTitle.contains("BED-BUG"):
        calculatedAnimal = "insects"
      case _ where upperCaseTitle.contains("PARASITE"):
        calculatedAnimal = "parasites"
      case _ where upperCaseTitle.contains("PARASITIC"):
        calculatedAnimal = "parasites"
      case _ where upperCaseTitle.contains("TICK"):
        calculatedAnimal = "parasites"
      case _ where upperCaseTitle.contains("LEECH"):
        calculatedAnimal = "parasites"
      case _ where upperCaseTitle.contains("TAPEWORM"):
        calculatedAnimal = "parasites"
      case _ where upperCaseTitle.contains("GEESE"):
        calculatedAnimal = "geese"
      case _ where upperCaseTitle.contains("GOOSE"):
        calculatedAnimal = "geese"
      case _ where upperCaseTitle.contains("RABIES"):
        calculatedAnimal = "rabies"
    case _ where upperCaseTitle.contains("MONSTER"):
        calculatedAnimal = "cryptid"
      case _ where upperCaseTitle.contains("BIGFOOT"):
          calculatedAnimal = "cryptid"
      case _ where upperCaseTitle.contains("BIG FOOT"):
          calculatedAnimal = "cryptid"
      case _ where upperCaseTitle.contains("BUFFALO"):
          calculatedAnimal = "buffalo"
      case _ where upperCaseTitle.contains("KOALA"):
          calculatedAnimal = "koala"
      case _ where upperCaseTitle.contains("RAT"):
        calculatedAnimal = "rodents"
        case _ where upperCaseTitle.contains("RATS"):
          calculatedAnimal = "rodents"
      case _ where upperCaseTitle.contains("DOLPHIN"):
        calculatedAnimal = "dolphins"
      case _ where upperCaseTitle.contains("SQUIRREL"):
        calculatedAnimal = "squirrel"
      case _ where upperCaseTitle.contains("BUGS"):
        calculatedAnimal = "insects"

    default:
      calculatedAnimal = "other"
    }
    
    return(calculatedAnimal)
  }
  

  
  
}




extension ViewController: UITableViewDelegate {
  
/*  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
  {
      let cell = tableView.cellForRow(at: indexPath) as! ArticleCell
    
  

      // change color back to whatever it was
      cell.headlineLabel.textColor = UIColor.black
      
  }    */
  
  
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
    
   // let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
     
    
    
    let cell = tableView.cellForRow(at: indexPath) as! ArticleCell
//    cell.headlineLabel.textColor = UIColor.red
    
    

  
    
    
    // transition to the detail view and pass selected article
   performSegue(withIdentifier: "SegueToDetail", sender: self)
    
  }
}




extension ViewController: ArticleModelProtocol {
  
  func articlesRetrieved(_ articles: [Article], _ firstString: String) {
    
    
    var editArticles = articles
    
    for i in 0..<editArticles.count {
        editArticles[i].categoryPlusPublishedAt = firstString + editArticles[i].publishedAt!
 
      if editArticles[i].urlToImage == nil || editArticles[i].urlToImage == " " {
        editArticles[i].urlToImage = "https://pbs.twimg.com/card_img/1196112240539316230/JD3vl7F9?format=jpg&name=medium"
      }
    
  // editArticles[i].url!.uppercased().contains("STARTRIBUNE")
      
      if editArticles[i].url!.uppercased().contains("FARK") || editArticles[i].url!.uppercased().contains("FREEREPUBLIC") ||
        editArticles[i].url!.uppercased().contains("SLASHDOT") ||
        editArticles[i].url!.uppercased().contains("HPVER") 
          {
       print("warning: \(editArticles[i].url!)")
        editArticles[i].title = " ☠️  "+editArticles[i].title!
      }
      
    }
    
    
    self.articles += editArticles
    
    self.articles.sort(by: { $0.categoryPlusPublishedAt! > $1.categoryPlusPublishedAt! })

    print(self.articles.count)
    





    tableView.reloadData()
  }
}

