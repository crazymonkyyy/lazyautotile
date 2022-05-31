enum bool verbose=true;
enum bool safe=true;
struct array2d(T,int WIDTH=-1,int HEIGHT=-1){
	static if(WIDTH<1){
		int width_=-1;
		auto width(){return width_;}
		auto width(int i){
			if(data.length==0){
				width_=i; return;
			}
			if(width_==-1){
				static if(verbose){
					import std.stdio;
					"WARN: you set the width after putting data in?".writeln;
				}
				width_=i; return;
			}
			static if(verbose){
				import std.stdio;
				"WARN: you resized the width of a 2d array that may have had data in it; this deletes everything cause not gonna impliment that".writeln;
			}
			static if(HEIGHT==-1){
				data=[];
			} else {
				//todo
			}
			width_=i;
		}
	} else {
		enum width_=WIDTH;
		auto width(){return width_;}
		auto width(int i){
			assert(i==width,"god help you");
			return width_;
		}
	}
	static if(HEIGHT==-1){
		int height(){
			int t=cast(int)data.length/width;
			if(t*width==data.length){
				return t;
			}
			return t+1;
		}
		void height(int i){
			data.length=width*i;}
	} else {
		enum height_=HEIGHT;
		auto height(){return height_;}
		auto height(int i){
			assert(i==height,"god help you");
			return height_;
		}
	}
	static if(WIDTH==-1 || HEIGHT==-1){
		T[] data;
		enum isdynamic=true;
	} else {
		T[WIDTH*HEIGHT] data;
		enum isdynamic=false;
	}
	ref T opIndex(int x,int y){
		static if(isdynamic){
			if(width==-1){
				static if(safe){
					width=x+1;
					height=y+1;
					static if(verbose){
						import std.stdio;
						"WARN: width was set by first call, this is a bad idea".writeln;
					}
				} else {
					assert(0);
			}}
			if(height<y){
				data.length=width*(y+1);
				static if(verbose){
					import std.stdio;
					"WARN: height is being expanded".writeln;
				}
			}
		}
		static if(safe){
			int clamp(int a,int b){
				import std.algorithm;
				auto t= max(0,min(a,b-1));
				static if(verbose){if(t!=a){
					import std.stdio;
					"WARN: clamped access".writeln;
				}}
				return t;
			}
			return data[clamp(y,height)*width+clamp(x,width)];
		}
		return data[y*width+x];
	}
	auto iterate(){
		struct range(T){
			T* parent;
			int i;
			ref front(){return parent.data[i];}
			void popFront(){i++;}
			bool empty(){return i>=parent.data.length;}
		}
		return range!(typeof(this))(&this);
	}
	auto opIndex(){return iterate;}
	auto iteratebyrow(){
		struct apply(P){
			P* parent;
			int opApply(int delegate(int,T[]) d){
				foreach(i;0..parent.height){
					auto slice=parent.data[i*parent.width..(i+1)*parent.width];
					auto result=d(i,slice);
					if(result){return result;}
				}
				return 0;
			}
		}
		return apply!(typeof(this))(&this);
	}
	int opApply(int delegate(int,T[]) d){
		foreach(i;0..height){
			auto result=d(i,data[i*width..(i+1)*width]);
			if(result){return result;}
		}
		return 0;
	}
	int opApply(int delegate(int,int,ref T) d){
		foreach(i;0..cast(int)data.length){
			auto r=d(i%width,i/width,data[i]);
			if(r){return r;}
		}
		return 0;
	}
	string toString(){
		import std.conv;
		import std.algorithm;
		string o=T.stringof;
		o~="["~width.to!string~","~height.to!string~"] [\n";
		foreach(i,a;this){
			o~=a.to!string;
			o~="\n";
		}
		o~="]";
		return o;
	}
}
import std.stdio;
unittest{
	array2d!(int,10,10) foo;
	foo.width=10;
	foo.height=10;
	int j;
	foreach(ref i;foo[]){
		i=j;j++;
		if(j>101){assert(0);}
	}
	foo.writeln;
	foreach(a,i;foo){
		i.writeln;
		i[0]=a;
		i.writeln;
	}
	foo.writeln;
	foreach(x,y,ref i;foo){
		i=x*y;
	}
	foo.writeln;
}