package geojson;

import geojson.util.*;

abstract MultiRingPolygon(GeoJsonMultiRingPolygon) from GeoJsonMultiRingPolygon to GeoJsonMultiRingPolygon {
	
	public var rings(get, set):Array<Line>;
	public var type(get, never):String;
	inline function get_type() return this.type;
	
	public function new(rings:Array<Line>)
		this = {
			type: 'Polygon',
			coordinates: rings,
		}
		
	inline function get_rings()
		return this.coordinates;
		
	inline function set_rings(v)
		return this.coordinates = v;
}

private typedef GeoJsonMultiRingPolygon = {
	type:String,
	coordinates:Array<Line>,
}