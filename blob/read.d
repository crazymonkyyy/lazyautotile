import blob;
import std.stdio;
void main(string[] s){
	auto foo=readblob(s[1]);
	foo.header.writeln;
	foo.data.writeln;
}