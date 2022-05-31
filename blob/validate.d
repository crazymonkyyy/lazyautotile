import blob;
import std.stdio;
void main(string[] s){
	if(readblob(s[1]).isvalid){
		"valid".writeln;
	} else {
		"INVALID".writeln;
	}
}