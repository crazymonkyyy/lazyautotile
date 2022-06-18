import blob;
void main(string[] s){
	int size=1;
	string[] headers;
	import std.range;
	import std.conv;
	foreach(t,w;zip(s[2..$],blobwords)){
		size*=t.to!int;
		headers~=w~t;
	}
	int[] data;
	data.length=size;
	writeblob(s[1],data,headers);
}