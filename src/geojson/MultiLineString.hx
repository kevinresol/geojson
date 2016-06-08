package geojson;

import geojson.util.*;

@:forward
abstract MultiLineString(GeoJsonMultiLineString) from GeoJsonMultiLineString to GeoJsonMultiLineString {
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):String;
	inline function get_type() return this.type;
	
	public function new(lines:Array<Line>)
		this = {
			type: 'MultiLineString',
			coordinates: lines,
		}
		
	inline function get_lines()
		return this.coordinates;
		
	inline function set_lines(v)
		return this.coordinates = v;
}

private typedef GeoJsonMultiLineString = {
	type:String,
	coordinates:Array<Line>,
}