package geojson.util;

abstract Line(Array<Coordinates>) from Array<Coordinates> to Array<Coordinates> {
	
	public var points(get, set):Array<Coordinates>;
	
	public inline function new(points:Array<Coordinates>)
		this = points;
		
	inline function get_points() return this;
	inline function set_points(v) return this = v;
}