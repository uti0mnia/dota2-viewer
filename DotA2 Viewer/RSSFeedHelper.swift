//
//  RSSFeedHelper.swift
//  DotA2 Viewer
//
//  Created by McLewin, Casey on 2016-11-01.
//  Copyright © 2016 self. All rights reserved.
//

import Foundation

protocol RSSFeedHelperDelegate {
    func parsingDidFinish()
}

class RSSFeedHelper: NSObject, XMLParserDelegate {
    // properties
    private var tags = ["title", "pubDate", "content:encoded"]
    var parsedData = [[String: String]]()
    var currentDataDictionary = [String: String]()
    var currentElement = ""
    var foundCharacters = ""
    var del: RSSFeedHelperDelegate?
    
    func startParsingURL(rssURL url: URL) {
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
    }
    
    /* Parser Delegate Methods */
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        // set the current element we're parsing
        currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        // make sure it's a relevant current element
        if tags.contains(currentElement) {
            // add the found characters to the current found characters (the parser sends this when finding chars in the tag, not necessarily the whole thing)
            foundCharacters += string
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        // make sure we actually found something
        if foundCharacters != "" && tags.contains(elementName) {
            // handle the \n and \t
            if elementName == "title" { foundCharacters = (foundCharacters as NSString).substring(from: 2) }
            if ["pubDate", "content:encoded"].contains(elementName) { foundCharacters = (foundCharacters as NSString).substring(from: 3) }
                // add to current data dictionary
            currentDataDictionary[elementName] = foundCharacters
            
            // clear found characters
            foundCharacters = ""
            
            // append to parsed data if it's the last tag we're interested in
            if tags.index(of: elementName) == tags.count - 1 {
                parsedData.append(currentDataDictionary)
                currentDataDictionary.removeAll() // clear the dictionary
            }
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        del?.parsingDidFinish()
    }
    
    // Parser Error Handling
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parse error: \(parseError.localizedDescription)")
    }
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        print("Validation error: \(validationError.localizedDescription)")
    }
    
}









































