package geojson.util;

@:forward(iterator, length, slice)
abstract Lines(Array<Line>) from Array<Line> to Array<Line> from Array<Array<Coordinates>> {
	
	public var lines(get, set):Array<Line>;
	
	public inline function new(lines:Array<Line>)
		this = lines;
		
	inline function get_lines() return this;
	inline function set_lines(v) return this = v;
}