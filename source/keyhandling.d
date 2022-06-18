struct pair{
	int which;
	int count;
}
alias K=int[3][3];
static pair[][K] store;
void add(K k,int which){
	if(k in store){
	foreach(ref e;store[k]){
		if(e.which==which){
			e.count++;
			return;
	}}}
	store[k]~=pair(which,1);
}
int lookup(K k){
	if(k !in store){
		bool b=true;
		foreach(x;0..2+1){
		foreach(y;0..2+1){
			if(k[x][y]==0){b=false;}}}
		if(b){import std.stdio; writeln("WARN:",k);}
		return k[1][1];
	}
	pair[] list=store[k];
	int count;
	foreach(e;list){
		count+=e.count;}
	import std.random;
	int i=uniform(0,count);
	foreach(e;list){
		i-=e.count;
		if(i<=0){
			return e.which;}
	}
	return k[1][1];
}
import safearray;
void process(array2d!int k, array2d!int l){
	int width=k.width;
	int height=k.height;
	assert(l.width==width);
	assert(l.height==height);
	import std.algorithm;
	int w(int i){
		return min(width,max(0,i));}
	int h(int i){
		return min(height,max(0,i));}
	foreach(x_;0..width+1){
	foreach(y_;0..height+1){
		K foo;
		foreach(x;-1..1+1){
		foreach(y;-1..1+1){
			foo[x+1][y+1]=k[w(x_+x),h(y_+y)];
		}}
		add(foo,l[x_,y_]);
	}}
}
void printstore(){
	import std.stdio;
	"STORE".writeln;
	store.writeln;
}