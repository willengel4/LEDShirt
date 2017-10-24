import UIKit

class ViewController: UIViewController
{
    @IBOutlet var mainView: UIView!
    let width = 9
    let height = 6
    let xOffset = 35
    let yOffset = 100
    let size = 15
    let xSpacing = 2
    let ySpacing = 7
    var grid : [[UIImageView]] = []
    var otherGrid : [[ColorWrapper]] = []
    var brushColor = UIColor.blue
    var red = 0.0
    var green = 0.0
    var blue = 255.0
    var num = 0
    var frames = [Frame]()
    var currFrame : Frame?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        frames = SystemDataHelper().getFrames()
        
        print("Current Frame: ")
        print(SystemDataHelper().loadInText("currentFrame.txt")!)
        let frameIndex = Int(SystemDataHelper().loadInText("currentFrame.txt")!)!
        
        
        if frameIndex >= frames.count
        {
            print("entering 1111")
            currFrame = Frame(str: "fdsf")
            frames.append(currFrame!)
            
            for row in 0...height
            {
                grid.append([])
                otherGrid.append([])
                for col in 0...width
                {
                    let x = xOffset + ((size+xSpacing) * col)
                    let y = yOffset + ((size+ySpacing) * row)
                    let img = UIImageView(frame: CGRect(x: x, y: y, width: size, height: size))
                    img.backgroundColor = brushColor
                    mainView.addSubview(img)
                    grid[row].append(img)
                    otherGrid[row].append(ColorWrapper(red : Int(red), blue : Int(blue), green : Int(green)))
                }
            }
        }
        else
        {
            print("Entering 2222")
            currFrame = frames[frameIndex]
            
            var num = ""
            var count = 0
            var red = 0.0
            var green = 0.0
            var blue = 0.0
            var row = 0
            var col = 0
            grid.append([])
            otherGrid.append([])
            for c in currFrame!.str
            {
                if c == "x"
                {
                    let n = Double(num)!
                    
                    if count == 0
                    {
                        count = 1
                        red = n
                    }
                    else if count == 1
                    {
                        count = 2
                        green = n
                    }
                    else
                    {
                        count = 0
                        blue = n
                        
                        let x = xOffset + ((size+xSpacing) * col)
                        let y = yOffset + ((size+ySpacing) * row)
                        let img = UIImageView(frame: CGRect(x: x, y: y, width: size, height: size))
                        
                        img.backgroundColor = UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: 1.0)
                        let cw = ColorWrapper(red: Int(red), blue: Int(blue), green: Int(green))
                        mainView.addSubview(img)

                        grid[row].append(img)
                        otherGrid[row].append(cw)
                        
                        col += 1
                        
                        if col == width
                        {
                            col = 0
                            row += 1
                            
                            if row == height
                            {
                                break
                            }
                            
                            grid.append([])
                            otherGrid.append([])
                        }
                    }
                    num = ""
                }
                else
                {
                    num += String(c)
                }
            }
        }
        

    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func drag(_ sender: UIPanGestureRecognizer)
    {
        let touchLocation = sender.location(in: sender.view)
        let x = Int(touchLocation.x)
        let y = Int(touchLocation.y)
        
        let row = (y - yOffset) / (size + ySpacing)
        let col = (x - xOffset) / (size + xSpacing)
        
        if row >= 0 && row <= height && col >= 0 && col < width
        {
            grid[row][col].backgroundColor = brushColor
            otherGrid[row][col] = ColorWrapper(red: Int(red), blue: Int(blue), green: Int(green))
        }
    }
    
    func setBrushColor()
    {
        brushColor = UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: 1.0)
        mainView.backgroundColor = brushColor
    }
    
    @IBAction func redChanged(_ sender: UISlider)
    {
        red = Double(sender.value)
        setBrushColor()
    }
    
    @IBAction func clearGrid(_ sender: Any)
    {
        for row in grid
        {
            for space in row
            {
                space.backgroundColor = brushColor
            }
        }
        
        for row in otherGrid
        {
            for space in row
            {
                space.blue = Int(blue)
                space.red = Int(red)
                space.green = Int(green)
            }
        }
    }
    
    @IBAction func greenChanged(_ sender: UISlider)
    {
        green = Double(sender.value)
        setBrushColor()
    }
    
    @IBAction func blueChanged(_ sender: UISlider)
    {
        blue = Double(sender.value)
        setBrushColor()
    }
    
    @IBAction func backPressed(_ sender: Any)
    {
        
    }
    
    @IBAction func savePressed(_ sender: Any)
    {
        var str = ""
        
        print("\(otherGrid.count) x \(otherGrid[0].count)")
        
        for row in otherGrid
        {
            for space in row
            {
                str += "\(space.red)x\(space.green)x\(space.blue)x"
            }
        }
        
        print(str)
        
        currFrame!.str = str
        
        var txt = ""
        
        for frame in frames
        {
            txt += frame.str + "\n"
        }
        
        print(txt)
        
        SystemDataHelper().writeTextToFile(txt, fileName: "frames.txt")
    }
    
}
