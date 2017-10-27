package geojson;

import geojson.util.*;

@:forward(coordinates)
abstract Point(GeoJson<Point, Coordinates>) from GeoJson<Point, Coordinates> to GeoJson<Point, Coordinates> {
	
	public var latitude(get, set):Float;
	public var longitude(get, set):Float;
	public var type(get, never):GeometryType<Point>;
	
	public inline function new(latitude:Float, longitude:Float)
		this = {
			type: Point,
			coordinates: new Coordinates(latitude, longitude),
		}
		
	@:to
	public inline function toCoordinates():Coordinates return this.coordinates;
	@:from
	public static inline function fromCoordinates(v:Coordinates) return new Point(v.latitude, v.longitude);
		
	inline function get_latitude() return this.coordinates[1];
	inline function get_longitude() return this.coordinates[0];
	inline function set_latitude(v) return this.coordinates[1] = v;
	inline function set_longitude(v) return this.coordinates[0] = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
}
