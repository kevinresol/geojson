package geojson;

import geojson.util.*;

abstract LineString(GeoJsonLineString) from GeoJsonLineString to GeoJsonLineString {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):String;
	
	public inline function new(line:Line)
		this = {
			type: 'LineString',
			coordinates: line,
		}
		
	inline function get_points()
		return this.coordinates;
		
	inline function set_points(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonLineString = {
	type:String,
	coordinates:Array<Coordinates>,
}