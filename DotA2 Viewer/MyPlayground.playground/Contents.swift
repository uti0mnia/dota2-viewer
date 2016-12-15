//: Playground - noun: a place where people can play

import UIKit

let string = "PARTIAL_BLOCKED_BY_LINKEN When blocked, Abaddon still loses health."
let a = string.characters.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true).map({sub in String.init(sub)})
print(a[0])
print(a[1])