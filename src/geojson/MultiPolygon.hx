package geojson;

import geojson.util.*;

abstract MultiPolygon(GeoJson<Array<Lines>>) from GeoJson<Array<Lines>> to GeoJson<Array<Lines>> {
	
	public var polygons(get, set):Array<Lines>;
	public var type(get, never):GeoJsonType<Array<Lines>>;
	
	public inline function new(polygons:Array<Lines>)
		this = {
			type: MultiPolygon,
			coordinates: polygons,
		}
		
	inline function get_polygons()
		return this.coordinates;
		
	inline function set_polygons(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}
