import raylib;
//import basic;
	import std.algorithm;
	import std.conv;
	import std.string;
import format;

alias block=int[3][3];
alias tile=int;
alias tiles=tile[];

tiles[block] lookup_;
void addlookup(block b,tile t){
	if(b in lookup_){
		lookup_[b]=lookup_[b]~t;
	} else {
		lookup_[b]=[t];
	}
}
tile lookup(block b){
	if(b in lookup_){ return lookup_[b][0];}
	return b[1][1];
}
int[][] key;
int[][] lock;
int[][] input;
int[][] output;
int countx;
int county;
string inputfile;
string outputfile;
string lockfile;
string keyfile;
void loadkeylock(){
	read(key,keyfile);
	read(lock,lockfile);
}
void processlockandkey(){
	lookup_.clear;
	tile l(ulong x,ulong y){
		import std;
		return lock
			[min($-1,max(0,x))]
			[min($-1,max(0,y))];
	}
	foreach(x;0..key[0].length){
	foreach(y;0..key.length){
		addlookup(
			[
				[l(x-1,y-1),l(x+0,y-1),l(x+1,y-1),],
				[l(x-1,y+0),l(x+0,y+0),l(x+1,y+0),],
				[l(x-1,y+1),l(x+0,y+1),l(x+1,y+1),],
			],key[x][y]);
	}}
}
void readinputfromfile(){
	read(input,inputfile);
	countx=cast(int)max(input[0].length,countx);
	county=cast(int)max(input.length,county);
	setsize(input,countx,county);
	setsize(output,countx,county);
}
void createoutput(){
	tile l(ulong x,ulong y){
		import std;
		return input
			[min($-1,max(0,x))]
			[min($-1,max(0,y))];
	}
	foreach(x;0..input[0].length){
	foreach(y;0..input.length){
		output[x][y]=lookup([
			[l(x-1,y-1),l(x+0,y-1),l(x+1,y-1),],
			[l(x-1,y+0),l(x+0,y+0),l(x+1,y+0),],
			[l(x-1,y+1),l(x+0,y+1),l(x+1,y+1),],
		]);
	}}
}
void writeinputtofile(){
	write(input,inputfile);
}
void writeoutputtofile(){
	write(output,outputfile);
}

void main(string[] s){
	bool gui=s[1].to!bool;
	int width=s[2].to!int;
	int hight=s[3].to!int;
	countx=s[4].to!int;
	county=s[5].to!int;
	Image sheet_=LoadImage(s[6].toStringz);
	int row=sheet_.width/width;
	inputfile=s[7];
	outputfile=s[8];
	keyfile=s[9];
	lockfile=s[10];
	int scale=2;
	loadkeylock;
	processlockandkey;
	//import std.stdio; lookup_.writeln;
	readinputfromfile;
	createoutput;
	writeoutputtofile;
	
	if(gui){
	int tool=100;
	InitWindow(width*countx*scale, hight*county*scale, "Hello, Raylib-D!");
	Texture2D sheet=LoadTextureFromImage(sheet_);
	SetWindowPosition(1800,0);
	SetTargetFPS(60);
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		
		mixin(import("tooltip.mix"));
		foreach(x;0..countx){
		foreach(y;0..county){
			auto t=output[x][y];
			if(x==toolx&&y==tooly){t=tool;}
			DrawTextureTiled(sheet,
				Rectangle((t%row)*width,(t/row)*hight,width,hight),
				Rectangle(x*scale*width,y*scale*hight,width*scale,hight*scale),
				Vector2(0,0),0,scale,Colors.WHITE);
		}}
		if(IsMouseButtonPressed(1)){
			import std.process;
			tool=("./selector "~s[2]~" "~s[3]~" "~s[6])
				.executeShell.output[0..$-1].to!int;
		}
		if(IsMouseButtonDown(0)){
			input[toolx][tooly]=tool;
			createoutput;
		}
		DrawFPS(10,10);
	}
	CloseWindow();
}}