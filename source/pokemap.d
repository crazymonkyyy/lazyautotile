import blob;
//import basic;
	import std.conv;
import safearray;
import format;
void main(string[] s){
	array2d!int foo;
	foo.width=s[2].to!int;
	foo.height=s[3].to!int;
	write(foo,s[4],s[1]);
}