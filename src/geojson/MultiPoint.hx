package geojson;

import geojson.util.*;

abstract MultiPoint(GeoJsonMultiPoint) from GeoJsonMultiPoint to GeoJsonMultiPoint {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):String;
	
	public function new(points:Array<Coordinates>)
		this = {
			type: 'MultiPoint',
			coordinates: points,
		}
		
	inline function get_points()
		return this.coordinates;
		
	inline function set_points(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonMultiPoint = {
	type:String,
	coordinates:Array<Coordinates>,
}