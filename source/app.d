import raylib;
//import basic;
	import std.stdio;
	import std.conv;
	import std.string;
import format;
import safearray;
import blob;
import monkyyykeys;

string tilemap;
string file;
string file2;
string keyfile;
array2d!int input;
array2d!int output;
array2d!int key;
array2d!int lock;
enum windowwidth=300;
enum windowheight=300;
enum scale=1;

int lookupconversion(int[3][3] input){
	import keyhandling;
	return lookup(input);
}

void updatecell(int x_,int y_){
	int[3][3] o;
	foreach(x;-1..1+1){
	foreach(y;-1..1+1){
		o[x+1][y+1]=input[x+x_,y+y_];
	}}
	output[x_,y_]=lookupconversion(o);
	if(output[x_,y_]!=input[x_,y_]){import std; "yay".writeln;}
}
void updateallcells(){
	foreach(x;0..input.width){
	foreach(y;0..input.height){
		updatecell(x,y);
	}}
}
void processkey(){
	import keyhandling;
	readkey(key,lock,keyfile,tilemap);
	process(key,lock);
}

void main(string[] s){
	file=s[1];
	file2=s[2];
	readfile(input,keyfile,file);
	readkey(key,lock,keyfile,tilemap);
	processkey;
	int tilesx=input.width;
	int tilesy=input.height;
	output.width=input.width;
	output.height=input.height;
	updateallcells;
	int tooltip;
	mixin(import("drawing.mix"));
	//import keyhandling; printstore;
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		mixin(import("tooltip.mix"));
		drawaligned(output);
		
		import monkyyykeys;
		with(button){
			if(shift+alt+f1){
				import std.process;
				int temp=("./selector "~tilemap).executeShell.output[0..$-1].to!int;
				foreach(x_;0..key.width){
				foreach(y_;0..key.height){
					input[x_,y_]=temp;
				}}
				updateallcells;
			}
			if(mouse1 && ! shift){
				input[toolx,tooly]=tooltip;
				foreach(x;-1..1+1){
				foreach(y;-1..1+1){
					updatecell(toolx+x,tooly+y);
				}}
			}
			if(shift && mouse1){
				foreach(x;-2..2+1){
				foreach(y;-2..2+1){
					input[toolx+x,tooly+y]=tooltip;
				}}
				foreach(x;-3..3+1){
				foreach(y;-3..3+1){
					updatecell(toolx+x,tooly+y);
				}}
			}
			if(mouse2.pressed){
				tooltip=input[toolx,tooly];
			}
			if(mouse3.pressed){
				import std.process;
				tooltip=("./selector "~tilemap).executeShell.output[0..$-1].to!int;
			}
			static int i;
			if(i==0 || f5.pressed){
				i=5*60;
				writefile(input,keyfile,file);
				writefile(output,keyfile,file2);
			} else {i--;}
			int speed=shift?8:1;//copy and pasted, factor out? to mix file
			offsetx+=(a.down*speed)+(d.down*-speed);
			offsety+=(w.down*speed)+(s.down*-speed);
		}
		input.height=output.height;//HACK: I kinda wondering if this just worked, .... I dont know if it did
											//TODO: make sure that input isnt growing when edited
	}
	CloseWindow;
}