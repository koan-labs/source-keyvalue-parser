var fs = require('fs');
var kv_parser = require("../dist/vdf-parser.js")
var targetpath = "./test_vdf.txt"
var file = fs.readFileSync(targetpath, "ucs2")
var parsed = kv_parser.parse(file);
console.log(JSON.stringify(parsed, null, 2))
