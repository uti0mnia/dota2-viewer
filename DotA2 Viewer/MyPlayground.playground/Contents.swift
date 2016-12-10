//: Playground - noun: a place where people can play

import UIKit

struct Note {
    var note: String?
    var subnote: [Note]?
}

func print(notes: [Note], withCurrentString string: String = "", andIndent indent: Int = 0) -> String {
    // base case
    if notes.count == 0 {
        return string
    }
    
    // single note case
    let note = notes[0]
    let tab = String(repeating: " ", count: indent)
    var newString = string + "\n\(tab)\(note.note ?? "No Note")"
    if let array = note.subnote {
        newString += print(notes: array, withCurrentString: "", andIndent: indent + 1)
    }
    let newNotes = Array<Note>(notes[1..<notes.count])
    return print(notes: newNotes, withCurrentString: newString, andIndent: indent)
    
}

var note1 = Note(note: "1", subnote: nil)
var note1_1 = Note(note: "1.1", subnote: nil)
var note1_2 = Note(note: "1.2", subnote: nil)
note1.subnote = [note1_1, note1_2]
let note2 = Note(note: "2", subnote: nil)
print(notes: [note1, note2])
