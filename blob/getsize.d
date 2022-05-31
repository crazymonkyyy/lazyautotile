import blob;
import std.conv;
import std.stdio;
void main(string[] s){
	auto foo=readblob(s[1]);
	int size=1;
	foreach(d;blobwords){
		auto a=foo.get(d);
		if(a==""){break;}
		d.writeln(":",a);
		size*=a.to!int;
	}
	if(size==1){
		"no size info".writeln;return;}
	"size:".writeln(size);
	if(size==foo.data.length){
		"size value confirmed".writeln; return;}
	"idk things seem broke".writeln(foo.data.length);
}