//
//  SystemDataHelper.swift
//  EventBlender
//
//  Created by Will Engel on 9/24/16.
//  Copyright © 2016 SnappyApps. All rights reserved.
//

import Foundation

class SystemDataHelper
{
    func loadInText(_ file : String) -> String?
    {
        /* The document directory */
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
        {
            /* The full path to the file */
            let path = URL(fileURLWithPath: dir).appendingPathComponent(file)
            
            do
            {
                /* Get the text in the file and return it */
                let text2 = try NSString(contentsOf: path, encoding: String.Encoding.utf8.rawValue) as String
                
                return text2
            }
            catch
            {
                /* If there was an error, the access token probably doesn't exist */
                print("Error reading from " + file)
            }
        }
        
        return nil
    }
    
    func replace(str: String, target: String, withString: String) -> String
    {
        return str.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func getUrlstr() -> String
    {
        var s = loadInText("frames.txt")!
        return replace(str: s, target: "\n", withString: "y")
    }
    
    /* This function will write the specified text to the specified file */
    func writeTextToFile(_ text : String, fileName : String)
    {
        /* Get the path to the documents directory */
        if let dir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true).first
        {
            /* The full path */
            let path = URL(fileURLWithPath: dir).appendingPathComponent(fileName)
            
            do
            {
                /* Do the writing */
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
            }
            catch
            {
                print("error writing to " + fileName)
            }
        }
    }
    
    func getFrames() -> [Frame]
    {
        var frames = [Frame]()
        let allFrames = SystemDataHelper().loadInText("frames.txt")
        
        var currFrame = ""
        for c in allFrames!.characters
        {
            if c == "\n"
            {
                print(currFrame)
                frames.append(Frame(str: currFrame))
                currFrame = ""
            }
            else
            {
                currFrame += String(c)
            }
        }
        
        if currFrame != ""
        {
            print(currFrame)
            frames.append(Frame(str: currFrame))
        }
        
        return frames
    }
}
