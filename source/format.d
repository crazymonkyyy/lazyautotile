import std.stdio;
void read(ref int[][] store,string file){
	store=[];
	foreach(s;File(file).byLine){
		int[] o;
		//assert(s[$-1]=='\n');
		foreach(c;s){
			o~=cast(int)c;
		}
		store~=o;
	}
}
void write(ref int[][] store,string file){
	auto o=File(file,"w");
	foreach(list;store){
	foreach(e;list){
		o.write(cast(char)e);
	}
		o.writeln;
	}
}
void setsize(ref int[][] store, int x, int y){
	store.length=y;
	foreach(ref e;store){
		e.length=x;
	}
}
unittest{
	int[][] a=[
		[1,2,3],
		[4,5,6],
	];
	write(a,"unittest");
	a=[];
	a.writeln;
	read(a,"unittest");
	a.writeln;
	setsize(a,5,5);
	a.writeln;
}