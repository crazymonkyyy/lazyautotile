import blob;
import raylib;

enum windowwidth =300;
enum windowheight=300;

enum scale=4;

void main(string[] s){
	string tilemap=s[1];
	mixin(import("drawing.mix"));
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		static int i;
		i++;
		i%=1000;
		drawtile(i/10,100,100);
	}
	CloseWindow();
}