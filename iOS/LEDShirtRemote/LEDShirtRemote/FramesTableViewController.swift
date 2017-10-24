import Foundation
import UIKit

class FramesTableViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    var frames = [Frame]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        frames = SystemDataHelper().getFrames()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return frames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var tableCell = UITableViewCell()
        var label = UILabel()
        label.text = "Frame \(indexPath.row)"
        tableCell.addSubview(label)
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        SystemDataHelper().writeTextToFile("\(indexPath.row)", fileName: "currentFrame.txt")
        self.performSegue(withIdentifier: "toFrame", sender: nil)
    }
    
    @IBAction func clearFrames(_ sender: Any)
    {
        frames = [Frame]()
        SystemDataHelper().writeTextToFile("", fileName: "frames.txt")
    }
    
    @IBAction func addFrame(_ sender: Any)
    {
        SystemDataHelper().writeTextToFile("\(frames.count)", fileName: "currentFrame.txt")
        self.performSegue(withIdentifier: "toFrame", sender: nil)
    }
    
    @IBAction func send(_ sender: Any)
    {
        var urlText = "http://108.161.133.186/shirt/update.php?in=\(SystemDataHelper().getUrlstr())"
        
            print("Hitting: " + urlText)
            
            /* Create the api call */
            let url = URL(string: urlText)
            
            /* Create the request */
            let request = URLRequest(url: url!)
            
            /* Make the request, get the response */
            NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main)
            {(response, data, error) in
                
                /* If there was an error */
                if(error != nil)
                {
                    print("Error")
                }
                    
                    /* If there was no error */
                else
                {
                    /* Get the response */
                    let responseString = NSMutableString(data: data!, encoding: String.Encoding.utf8.rawValue)!                    
                }
            }
        }
    
    
}
