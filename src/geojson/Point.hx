package geojson;

import geojson.util.*;
import geojson.util.Constants.*;

@:forward(coordinates)
abstract Point(GeoJson<Point, Coordinates>) to GeoJson<Point, Coordinates> {
	
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
	
	// https://www.movable-type.co.uk/scripts/latlong.html
	public function distanceTo(that:Point, radius:Float) {
		var lat1 = latitude * TO_RADIANS;
		var lat2 = that.latitude * TO_RADIANS;
		var long1 = longitude * TO_RADIANS;
		var long2 = that.longitude * TO_RADIANS;
		var sdlat = Math.sin((lat1 - lat2) / 2);
		var sdlong = Math.sin((long1 - long2) / 2);
		var a = sdlat * sdlat + Math.cos(lat1) * Math.cos(lat2) * sdlong * sdlong;
		return 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)) * radius;
	}
	
	// https://www.movable-type.co.uk/scripts/latlong.html
	public function initialBearingTo(that:Point) {
		var lat1 = latitude * TO_RADIANS;
		var lat2 = that.latitude * TO_RADIANS;
		var long1 = longitude * TO_RADIANS;
		var long2 = that.longitude * TO_RADIANS;
		var y = Math.sin(long2 - long1) * Math.cos(lat2);
		var x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(long2 - long1);
		return Math.atan2(y, x) * TO_DEGREES;
	}
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Coordinates}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Coordinates}>):Point {
		switch rep.get() {
			case v if(v.type == 'Point'): return cast v;
			default: throw 'Invalid Point';
		}
	}
	#end
}
