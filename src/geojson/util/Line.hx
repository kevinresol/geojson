package geojson.util;

@:forward(iterator, length, slice)
abstract Line(Array<Coordinates>) from Array<Coordinates> to Array<Coordinates> {
	
	public var points(get, set):Array<Coordinates>;
	
	public inline function new(points:Array<Coordinates>)
		this = points;
		
	inline function get_points() return this;
	inline function set_points(v) return this = v;
	
	public static function is(v:Dynamic):Bool {
		if(!Std.is(v, Array)) return false;
		if(v.length == 0) return false;
		for(v in (v:Array<Dynamic>)) if(!Coordinates.is(v)) return false;
		return true;
	}
}