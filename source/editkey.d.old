import raylib;
//import basic;
	import std.conv;
	import std.string;
import format;
void main(string[] s){
	int width=s[1].to!int;
	int hight=s[2].to!int;
	int scale=s[3].to!int;
	int countx=s[4].to!int;
	int county=s[5].to!int;
	Image sheet_=LoadImage(s[6].toStringz);
	int row=sheet_.width/width;
	InitWindow(width*countx*scale, hight*county*scale, "Hello, Raylib-D!");
	Texture2D sheet=LoadTextureFromImage(sheet_);
	int[][] key;
	int[][] lock;
	read(key,s[7]);
	setsize(key,countx,county);
	read(lock,s[8]);
	setsize(lock,countx,county);
	SetWindowPosition(1800,0);
	SetTargetFPS(60);
	int tool=50;
	bool mode=true;
	int trans=128;
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		mixin(import("tooltip.mix"));
		foreach(x;0..countx){
		foreach(y;0..county){
			auto t=key[x][y];
			if(!mode){if(x==toolx&&y==tooly){t=tool;}}
			DrawTextureTiled(sheet,
				Rectangle((t%row)*width,(t/row)*hight,width,hight),
				Rectangle(x*scale*width,y*scale*hight,width*scale,hight*scale),
				Vector2(0,0),0,scale,Colors.WHITE);
			if(mode){
				auto l=lock[x][y];
					if(x==toolx&&y==tooly){l=tool;}
					DrawTextureTiled(sheet,
						Rectangle((l%row)*width,(l/row)*hight,width,hight),
						Rectangle(x*scale*width,y*scale*hight,width*scale,hight*scale),
					Vector2(0,0),0,scale,Color(255,255,255,cast(ubyte)trans%256));
			}
		}}
		if(IsMouseButtonPressed(1)){
			import std.process;
			tool=("./selector "~s[1]~" "~s[2]~" "~s[6])
				.executeShell.output[0..$-1].to!int;
		}
		if(IsMouseButtonDown(0)){
			if(mode){lock[toolx][tooly]=tool;}
			else{key[toolx][tooly]=tool;}
		}
		if(IsMouseButtonPressed(2)){
			mode = ! mode;
		}
		static int timer;
		if(timer==0){
			timer=60*60;
			write(key,s[7]);
			write(lock,s[8]);
			import basic;
			"autosave".writeln;
		}
		else {timer--;}
		trans+=GetMouseWheelMove*16;
	}
	CloseWindow();
}