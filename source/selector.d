import raylib;
import basic;

void main(string[] s){
	int width=s[1].to!int;
	int hight=s[2].to!int;
	SetTraceLogLevel(int.max);
	Image sheet_=LoadImage(s[3].toStringz);
	int scale=1080/sheet_.width;
	InitWindow(sheet_.width*scale, sheet_.height*scale, "Hello, Raylib-D!");
	Texture2D sheet=LoadTextureFromImage(sheet_);
	SetWindowPosition(700,0);
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
			(toolx+tooly*(sheet.width/width)).writeln;
			goto exit;
		}
	}
	exit:
	CloseWindow();
}