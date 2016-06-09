package geojson;

import geojson.util.*;

private typedef Object = GeoJson<Polygon, Array<Line>>;
abstract Polygon(Object) from Object to Object {
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):GeoJsonGeometryType<Polygon>;
	
	public inline function new(lines:Array<Line>)
		this = {
			type: Polygon,
			coordinates: lines,
		}
		
	inline function get_lines() return this.coordinates;
	inline function set_lines(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():GeoJsonGeometry return cast this;
}
