//: Playground - noun: a place where people can play

import UIKit

struct KV {
    var key: String
    var value: String
}

let kvs = [KV(key: "k1", value: "v1"), KV(key: "k2", value: "v2")]
print(kvs.map({ $0.key }))