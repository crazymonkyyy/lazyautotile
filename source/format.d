import std.stdio;
import safearray;
import blob;
import basic;
void readfile(ref array2d!int store,ref string key,string file){
	auto a=readblob(file);
	store.width=a.get("width").to!int;
	store.height=a.get("height").to!int;
	key=a.get("key");
	store.data=a.data;
}
void writefile(ref array2d!int store,string key,string file){
	auto a=readblob(file);
	a.header=[];
	a.header~="width"~store.width.to!string;
	a.header~="height"~store.height.to!string;
	a.header~="key"~key;
	a.data=store.data;
	a.rewrite;
}
//void setsize(ref array2d!int store, int x, int y){
//	store.length=y;
//	foreach(ref e;store){
//		e.length=x;
//	}
//}
void readkey(ref array2d!int key,ref array2d!int lock, string file,ref string tilemap){
	auto a=readblob(file);
	//try{
		key.width=a.get("width").to!int;
		lock.width=a.get("width").to!int;
		key.height=a.get("height").to!int;
		lock.height=a.get("height").to!int;
		tilemap=a.get("tilemap");
		assert(a.get("depth").to!int==2);
	//}
	//catch(Error){}
	key.data=a.data[0..key.width*key.height];
	lock.data=a.data[key.width*key.height..$];
}
void writekey(ref array2d!int key,ref array2d!int lock,string file,ref string tilemap){
	typeof(readblob(file)) blob;
	blob.file=file;
	foreach(e;key.iterate){
		blob.data~=e;}
	foreach(e;lock.iterate){
		blob.data~=e;}
	blob.header=[
		"width"~key.width.to!string,
		"height"~key.height.to!string,
		"depth2",
		"tilemap"~tilemap,
	];
	blob.rewrite;
}