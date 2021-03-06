package geojson;

import geojson.util.*;
import geojson.util.Constants.*;

@:forward(coordinates)
abstract Point(GeoJson<Point, Coordinates>) to GeoJson<Point, Coordinates> {
	
	public var latitude(get, set):Float;
	public var longitude(get, set):Float;
	public var type(get, never):GeometryType<Point>;
	
	public inline function new(latitude:Float, longitude:Float)
		this = createFromCoordinates(new Coordinates(latitude, longitude));
		
	@:to
	public inline function toCoordinates():Coordinates return this.coordinates;
	@:from
	public static inline function fromCoordinates(v:Coordinates):Point return createFromCoordinates(v);
	
	
	static inline function createFromCoordinates(v:Coordinates):Point
		return cast {
			type: (Point:GeometryType<Point>),
			coordinates: v,
		}
	
		
	inline function get_latitude() return this.coordinates[1];
	inline function get_longitude() return this.coordinates[0];
	inline function set_latitude(v) return this.coordinates[1] = v;
	inline function set_longitude(v) return this.coordinates[0] = v;
	inline function get_type() return this.type;
	@:to public inline function toGeoJson():Geometry return cast this;
	
	public function eq(other:Point):Bool
		return latitude == other.latitude && longitude == other.longitude;
	
	public inline function distanceTo(that:Point, radius:Float)
		return this.coordinates.distanceTo(that.coordinates, radius);
	
	public inline function destination(distance:Float, bearing:Float):Point
		return this.coordinates.destination(distance, bearing);
	
	public function initialBearingTo(that:Point)
		return this.coordinates.initialBearingTo(that.coordinates);
	
	public static function interpolate(points:Array<{point:Point, weight:Float}>):Point
		return Coordinates.interpolate([for(point in points) {coordinates: point.point.coordinates, weight: point.weight}]);
	
	public static function average(points:Array<Point>):Point
		return Coordinates.interpolate([for(point in points) {coordinates: point.coordinates, weight: 1}]);
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Coordinates}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Coordinates}>):Point {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid Point';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		return v.type == 'Point' && Coordinates.is(v.coordinates);
	}
}
