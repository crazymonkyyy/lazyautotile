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
array2d!int key;
array2d!int lock;
enum windowwidth=300;
enum windowheight=300;
enum scale=.25;//todo make a more robust solution

void main(string[] s){
	file=s[1];
	readkey(key,lock,file,tilemap);
	int tilesx=key.width;
	int tilesy=key.height;
	int transperency=128;
	bool active=true;
	int tooltip;
	mixin(import("drawing.mix"));
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		mixin(import("tooltip.mix"));
		with(button){
			if( ! ctrl){drawaligned(lock);}
			if( ! alt && ! ctrl){
				drawalignedtrans(key,cast(ubyte)transperency);
			}
			if(alt){active=false;}
			if(ctrl){
				active=true;
				drawaligned(key);
			}
			if(shift+alt+f1){
				import std.process;
				int temp=("./selector "~tilemap).executeShell.output[0..$-1].to!int;
				foreach(x_;0..key.width){
				foreach(y_;0..key.height){
					lock[x_,y_]=temp;
					key[x_,y_]=temp;
			}}}
			if(active && mouse1 && !shift){
				key[toolx,tooly]=tooltip;}
			if(!active && mouse1 && !shift){
				lock[toolx,tooly]=tooltip;}
			if(active && mouse1 && shift){
				foreach(x;-2..2+1){
				foreach(y;-2..2+1){
					key[toolx+x,tooly+y]=tooltip;
			}}}
			if(!active && mouse1 && shift){
				foreach(x;-2..2+1){
				foreach(y;-2..2+1){
					lock[toolx+x,tooly+y]=tooltip;
			}}}
			if(active && mouse2.pressed){
				tooltip=key[toolx,tooly];}
			if(! active && mouse2.pressed){
				tooltip=lock[toolx,tooly];}
			if(mouse4.pressed){
				import std.process;
				tooltip=("./selector "~tilemap).executeShell.output[0..$-1].to!int;
			}
			if(mouse3.pressed){
				active=!active;}
			if( ! shift){
				transperency+=GetMouseWheelMove*16;
			} else {
				transperency+=GetMouseWheelMove*1;
			}
			transperency%=ubyte.max;
			static foreach(i;0..10){
				mixin("if(_"~i.to!string~"){tooltip=hotkeys[i];}");
			}
			static int timer;
			if(f5.pressed){timer=0;}
			if(timer==0){
				timer=60*60;
				writekey(key,lock,file,tilemap);
				"autosave".writeln;
			} else { timer--;}
			
			int speed=shift?8:1;
			offsetx+=(a.down*speed)+(d.down*-speed);
			offsety+=(w.down*speed)+(s.down*-speed);
	}}
	CloseWindow;
}