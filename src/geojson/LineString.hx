package geojson;

import geojson.util.*;

abstract LineString(GeoJson<Array<Coordinates>>) from GeoJson<Array<Coordinates>> to GeoJson<Array<Coordinates>> {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):GeoJsonType<Array<Coordinates>>;
	
	public inline function new(line:Array<Coordinates>)
		this = {
			type: LineString,
			coordinates: line,
		}
		
	inline function get_points()
		return this.coordinates;
		
	inline function set_points(v)
		return this.coordinates = v;
		
	inline function get_type() return this.type;
}
