package geojson;

import geojson.util.*;

abstract MultiLineString(GeoJson<MultiLineString, Array<Line>>) from GeoJson<MultiLineString, Array<Line>> to GeoJson<MultiLineString, Array<Line>> {
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):GeometryType<MultiLineString>;
	
	public inline function new(lines:Array<Line>)
		this = {
			type: MultiLineString,
			coordinates: lines,
		}
		
	inline function get_lines() return this.coordinates;
	inline function set_lines(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
}
