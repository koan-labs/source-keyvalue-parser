[![License](https://img.shields.io/badge/license-mit-blue.svg)](https://opensource.org/licenses/MIT)
vdf-parser-js
======
vdf-parser-js is parser for the source engine's key-value.txt files written in PEG.js. It allows for conversion of source's KeyValue or VDF file format into JSON objects. 

History/Background
------
The KeyValues format, a.k.a. Valve Data Format is used in the Source engine to store meta data for resources, scripts, materials, VGUI elements, and more. The KeyValues.h header in the Source SDK code defines the file format. I didn't pay attention to that when I wrote this because I didn't know it existed. In fact there are a few other projects that do the same thing as this one, but I didn't find any of them until after I wrote this. In any case this one uses a PEG, also it gives nice-ish error messages.

Simple Usage
-----
To use the compiled parser simply require it into your node project. The file you're looking for is `vdf-parser.js` in `./dist`. 

Here's a simple usage example. This can also be found in the `./examples` directory.
```javascript
var fs = require('fs');
var vdf_parser = require("../dist/vdf-parser.js")
var targetpath = "./test_vdf.txt"
var file = fs.readFileSync(targetpath, "ucs2")
var parsed = vdf_parser.parse(file);
console.log(JSON.stringify(parsed, null, 2))
```
Which will return the following:
```json
{
  "firstKeyName": {
    "testValue": "please ignore",
    "nestedObjectsAreFun": {
      "this_is_a_string": "yarn",
      "this-is-a-number": 1337.9001
    }
  }
}
```

The parser will attempt `parseFloat()` any string value that can be cast to a number, otherwise everything is just strings.

Happy parsing everybody!

Advanced Usage
-----
If you're looking to integrate the parser into a project more tightly you may want to recompile it from the original pegjs source. You'll need to install pegjs globally. Also you might want to use one of the other ones people have written.
```
npm install -g pegjs
```
and then compile the source file
```
pegjs vdf-parser.pegjs
```
This gives you the option of using different compilation flags/options as detailed in the [PEG.js](http://pegjs.org/) [documentation](http://pegjs.org/documentation).


References
------
http://pegjs.org/documentation

https://developer.valvesoftware.com/wiki/KeyValues

https://github.com/rossengeorgiev/vdf-parser

https://github.com/devinwl/keyvalues-php

https://github.com/lukezbihlyj/vdf-parser

https://github.com/RJacksonm1/node-vdf

http://codereview.stackexchange.com/questions/61135/parsing-valve-key-value-files
