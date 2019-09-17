package geojson.util;

@:forward(iterator, length, slice)
abstract Lines(Array<Line>) from Array<Line> to Array<Line> from Array<Array<Coordinates>> {
	
	public var lines(get, set):Array<Line>;
	
	public inline function new(lines:Array<Line>)
		this = lines;
		
	inline function get_lines() return this;
	inline function set_lines(v) return this = v;
	
	public static function is(v:Dynamic):Bool {
		if(!Std.is(v, Array)) return false;
		if(v.length == 0) return false;
		for(v in (v:Array<Dynamic>)) if(!Line.is(v)) return false;
		return true;
	}
}