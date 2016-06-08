package geojson;

import geojson.util.*;

abstract MultiRingPolygon(GeoJsonMultiRingPolygon) from GeoJsonMultiRingPolygon to GeoJsonMultiRingPolygon {
	
	public var rings(get, set):Array<Line>;
	public var type(get, never):String;
	
	public inline function new(rings:Array<Line>)
		this = {
			type: 'Polygon',
			coordinates: rings,
		}
		
	inline function get_rings()
		return this.coordinates;
		
	inline function set_rings(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}

private typedef GeoJsonMultiRingPolygon = {
	type:String,
	coordinates:Array<Line>,
}