package geojson;

import geojson.util.*;

abstract MultiPolygon(GeoJsonMultiPolygon) from GeoJsonMultiPolygon to GeoJsonMultiPolygon {
	
	public var polygons(get, set):Array<Lines>;
	public var type(get, never):String;
	
	public inline function new(polygons:Array<Lines>)
		this = {
			type: 'MultiPolygon',
			coordinates: polygons,
		}
		
	inline function get_polygons()
		return this.coordinates;
		
	inline function set_polygons(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonMultiPolygon = {
	type:String,
	coordinates:Array<Lines>,
}