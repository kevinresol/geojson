package geojson;

import geojson.util.*;

abstract Polygon(GeoJsonPolygon) from GeoJsonPolygon to GeoJsonPolygon {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):String;
	
	public inline function new(points:Line)
		this = {
			type: 'Polygon',
			coordinates: points,
		}
		
	inline function get_points()
		return this.coordinates;
		
	inline function set_points(v:Line)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonPolygon = {
	type:String,
	coordinates:Array<Coordinates>,
}