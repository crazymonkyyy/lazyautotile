import blob;
import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
void main(string[] s){
	auto foo=readblob(s[1]);
	foo.header~=s[2..$].joiner(" ").array.to!string;
	//foo.header.writeln;
	foo.rewrite;
}