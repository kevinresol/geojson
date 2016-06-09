package geojson;

import geojson.util.*;

private typedef Object = GeoJson<LineString, Array<Coordinates>>;
abstract LineString(Object) from Object to Object {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):GeoJsonGeometryType<LineString>;
	
	public inline function new(line:Array<Coordinates>)
		this = {
			type: LineString,
			coordinates: line,
		}
		
	inline function get_points() return this.coordinates;
	inline function set_points(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():GeoJsonGeometry return cast this;
}
