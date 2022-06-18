import raylib;
import monkyyykeys;
void main(){
	InitWindow(200,200,"hi");
	while (!WindowShouldClose()){
		BeginDrawing();
		scope(exit) EndDrawing();
		ClearBackground(Colors.BLACK);
		import std.traits;
		import std.stdio;
		foreach(b;[EnumMembers!button]){
			if(b.pressed){
				b.writeln;
		}}
		if(button.mouse1.pressed){
			"HI".writeln;
		}
		with (button){
			if(alt+mouse1-shift){
				"HELLLO".writeln;}
			if(shift+mouse2){
				"HENLO".writeln;}
			if(shift+mouse1-alt){
				"GOOD BYE".writeln;}
		}
	}
	CloseWindow();
}