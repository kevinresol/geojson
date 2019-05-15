package geojson.util;

import geojson.*;

@:forward(iterator, length, slice, concat)
abstract Liness(Array<Lines>) from Array<Lines> to Array<Lines> from Array<Array<Line>> {
	@:from
	public static inline function fromCoordinates(v:Array<Array<Array<Coordinates>>>):Liness
		return cast v;
	
	public var lines(get, set):Array<Lines>;
	
	public inline function new(lines:Array<Lines>)
		this = lines;
		
	inline function get_lines() return this;
	inline function set_lines(v) return this = v;
	
	@:to inline function toPolygonArray():Array<Polygon>
		return [for(lines in this) new Polygon(lines)];
}