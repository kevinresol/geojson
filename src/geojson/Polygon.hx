package geojson;

import geojson.util.*;

abstract Polygon(GeoJsonPolygon) from GeoJsonPolygon to GeoJsonPolygon {
	
	public var points(get, set):Line;
	public var type(get, never):String;
	inline function get_type() return this.type;
	
	public function new(points:Line)
		this = {
			type: 'Polygon',
			coordinates: points,
		}
		
	inline function get_points()
		return this.coordinates;
		
	inline function set_points(v:Line)
		return this.coordinates = v;
}

private typedef GeoJsonPolygon = {
	type:String,
	coordinates:Line,
}