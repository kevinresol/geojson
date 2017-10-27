package geojson;

import geojson.util.*;

abstract MultiPoint(GeoJson<MultiPoint, Array<Coordinates>>) from GeoJson<MultiPoint, Array<Coordinates>> to GeoJson<MultiPoint, Array<Coordinates>> {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):GeometryType<MultiPoint>;
	
	public inline function new(points:Array<Coordinates>)
		this = {
			type: MultiPoint,
			coordinates: points,
		}
		
	inline function get_points()return this.coordinates;
	inline function set_points(v)return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
}
