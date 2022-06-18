import blob;
import raylib;
import basic;
int windowwidth=1920;
int windowheight=1080;
void main(string[] s){
	SetTraceLogLevel(int.max);
	string tilemap=s[1];
	float scale=2;
	enum tilesx=0;
	enum tilesy=0;
	import monkyyykeys;
	mixin(import("drawing.mix"));
	scale=min(1920.0/sheet.width,1080.0/sheet.height);
	enum scales=[.1,.25,.5,.75,1,1.25,1.5,1.66,2,4,5,8,12,1000];
	scale=scales[scales.countUntil!("a>b")(scale)-1];
	windowwidth=cast(int)(sheet.width*scale);
	windowheight=cast(int)(sheet.height*scale);
	SetWindowSize(min(windowwidth,1920),min(windowheight,1080));
	RestoreWindow();
	SetTargetFPS(60);
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		DrawTextureEx(sheet,Vector2(0,0),0,scale,Colors.WHITE);
		mixin(import("tooltip.mix"));
		DrawFPS(10,10);
		if(IsMouseButtonPressed(0)){
			(toolx+tooly*(sheet.width/tilewidth)).writeln;
			goto exit;
		}
	}
	exit:
	CloseWindow();
}