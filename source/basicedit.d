import blob;
import raylib;
import basic;
import safearray;
import format;
import monkyyykeys;
enum windowwidth=300;
enum windowheight=300;
enum scale=1;

void main(string[] s){
	string tilemap;
	array2d!int store;
	readfile(store,tilemap,s[1]);
	int tilesx=store.width;
	int tilesy=store.height;
	int tooltip;
	mixin(import("drawing.mix"));
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		mixin(import("tooltip.mix"));
		drawaligned(store);
		with(button){
		if(mouse1 && ! shift){
			store[toolx,tooly]=tooltip;
		}
		if(mouse1 && shift){
			foreach(x;-2..2+1){
			foreach(y;-2..2+1){
				store[toolx+x,tooly+y]=tooltip;
		}}}
		offsetx+=(a.down*-1)+(d.down*1);
		offsety+=(w.down*-1)+(s.down*1);
		static foreach(i;0..10){
			mixin("if(_"~i.to!string~"){tooltip=hotkeys[i];}");
		}
	}}
	CloseWindow();
}