package geojson;

import geojson.util.*;

abstract Point(GeoJsonPoint) from GeoJsonPoint to GeoJsonPoint {
	
	public var latitude(get, set):Float;
	public var longitude(get, set):Float;
	public var type(get, never):String;
	
	public inline function new(latitude:Float, longitude:Float)
		this = {
			type: 'Point',
			coordinates: new Coordinates(latitude, longitude),
		}
		
	inline function get_latitude() return this.coordinates[1];
	inline function get_longitude() return this.coordinates[0];
	inline function set_latitude(v) return this.coordinates[1] = v;
	inline function set_longitude(v) return this.coordinates[0] = v;
	inline function get_type() return this.type;
}

private typedef GeoJsonPoint = {
	type:String,
	coordinates:Coordinates,
}