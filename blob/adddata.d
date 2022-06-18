import blob;
import std.algorithm;
import std.array;
import std.conv;
import std.stdio;
void main(string[] s){
	auto foo=readblob(s[1]);
	foreach(e;s[2..$].map!(a=>a.to!int)){
		foo.data~=e;
	}
	foo.rewrite;
}