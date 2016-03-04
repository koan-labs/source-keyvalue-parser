valve_text
	= wrapper
    
wrapper
	= __ value:member {
    var res = {};
    res[value.name] = value.value
    return res;
    }
__ 
  = ( whiteSpace / lineTerminator / lineComment )* 

whiteSpace 
  = [\t\v\f \u00A0\uFEFF] 

lineTerminator 
  = [\n\r] 

lineComment 
  = "//" (!lineTerminator anyCharacter)* 

anyCharacter 
  = . 

escape         = "\\"
quotation_mark = '"'  
begin_object    = __ "{" __
end_object      = __ "}" __

string "string"
  = quotation_mark chars:char* quotation_mark { return chars.join(""); }

char
  = unescaped
  / escape
    sequence:(
        '"'
      / "\\"
      / "/"
      / "b" { return "\b"; }
      / "f" { return "\f"; }
      / "n" { return "\n"; }
      / "r" { return "\r"; }
      / "t" { return "\t"; }
      / "u" digits:$(HEXDIG HEXDIG HEXDIG HEXDIG) {
          return String.fromCharCode(parseInt(digits, 16));
        }
    )
    { return sequence; }

unescaped      = [^\0-\x1F\x22\x5C]
DIGIT  = [0-9]
HEXDIG = [0-9a-f]i

object
  = name:begin_object
      members:(
      head:member
      tail:(__ m:member { return m; })*
      {
        var result = {}, i;

        result[head.name] = head.value;

        for (i = 0; i < tail.length; i++) {
          result[tail[i].name] = tail[i].value;
        }

        return result;
      }
    )?
    end_object
	{ return members !== null ? members: {}; }
    
member
  = name:string __ value:value __{
      return { name: name, value: value };
    }

value
  = object
  / number
  / string

false = "false" { return false; }
null  = "null"  { return null;  }
true  = "true"  { return true;  }

number "number"
  = quotation_mark num:(minus? int frac? exp? { return text() }) quotation_mark {return parseFloat(num)}

decimal_point = "."
digit1_9      = [1-9]
e             = [eE]
exp           = e (minus / plus)? DIGIT+
frac          = decimal_point DIGIT+
int           = zero / (digit1_9 DIGIT*)
minus         = "-"
plus          = "+"
zero          = "0"
