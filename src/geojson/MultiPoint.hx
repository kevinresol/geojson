package geojson;

import geojson.util.*;

private typedef Object = GeoJson<MultiPoint, Array<Coordinates>>;
abstract MultiPoint(Object) from Object to Object {
	
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
