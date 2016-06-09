package geojson;

import geojson.util.*;

abstract MultiLineString(GeoJsonMultiLineString) from GeoJsonMultiLineString to GeoJsonMultiLineString {
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):String;
	
	public inline function new(lines:Array<Line>)
		this = {
			type: 'MultiLineString',
			coordinates: lines,
		}
		
	inline function get_lines()
		return this.coordinates;
		
	inline function set_lines(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonMultiLineString = {
	type:String,
	coordinates:Array<Line>,
}