package geojson.util;

import geojson.util.Constants.*;

abstract Coordinates(Array<Float>) to Array<Float> {
	
	public var latitude(get, set):Float;
	public var longitude(get, set):Float;
	
	public inline function new(latitude:Float, longitude:Float)
		this = [longitude, latitude];
		
	inline function get_latitude() return this[1];
	inline function get_longitude() return this[0];
	inline function set_latitude(v) return this[1] = v;
	inline function set_longitude(v) return this[0] = v;
	
	
	// https://www.movable-type.co.uk/scripts/latlong.html#ortho-dist
	public function distanceTo(that:Coordinates, radius:Float) {
		var lat1 = latitude * TO_RADIANS;
		var lat2 = that.latitude * TO_RADIANS;
		var long1 = longitude * TO_RADIANS;
		var long2 = that.longitude * TO_RADIANS;
		var sdlat = Math.sin((lat1 - lat2) / 2);
		var sdlong = Math.sin((long1 - long2) / 2);
		var a = sdlat * sdlat + Math.cos(lat1) * Math.cos(lat2) * sdlong * sdlong;
		return 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a)) * radius;
	}
	
	// https://www.movable-type.co.uk/scripts/latlong.html#dest-point
	/**
	 * [Description]
	 * @param distance normalized distance
	 * @param bearing in degrees
	 */
	public inline function destination(distance:Float, bearing:Float) {
		var lat1 = latitude * TO_RADIANS;
		var long1 = longitude * TO_RADIANS;
		var bearing = bearing * TO_RADIANS;
		var lat2 = Math.asin(Math.sin(lat1) * Math.cos(distance) + Math.cos(lat1) * Math.sin(distance) * Math.cos(bearing));
		var long2 = long1 + Math.atan2(Math.sin(bearing) * Math.sin(distance) * Math.cos(lat1), Math.cos(distance) - Math.sin(lat1) * Math.sin(lat2));
		return new Coordinates(lat2 * TO_DEGREES, long2 * TO_DEGREES);
	}
	
	// https://www.movable-type.co.uk/scripts/latlong.html#bearing
	public function initialBearingTo(that:Coordinates) {
		var lat1 = latitude * TO_RADIANS;
		var lat2 = that.latitude * TO_RADIANS;
		var long1 = longitude * TO_RADIANS;
		var long2 = that.longitude * TO_RADIANS;
		var y = Math.sin(long2 - long1) * Math.cos(lat2);
		var x = Math.cos(lat1) * Math.sin(lat2) - Math.sin(lat1) * Math.cos(lat2) * Math.cos(long2 - long1);
		return Math.atan2(y, x) * TO_DEGREES;
	}
	
	public static function interpolate(points:Array<{coordinates:Coordinates, weight:Float}>):Coordinates {
		// TODO: improve this native implementation
		var lat = 0.;
		var long = 0.;
		var sum = 0.;
		for(point in points) {
			lat += point.coordinates.latitude * point.weight;
			long += point.coordinates.longitude * point.weight;
			sum += point.weight;
		}
		return new Coordinates(lat / sum, long / sum);
	}
	
	public static function average(coordinates:Array<Coordinates>):Coordinates {
		return interpolate([for(c in coordinates) {coordinates: c, weight: 1}]);
	}
	
	#if tink_json
	@:to
	public inline function toRepresentation():tink.json.Representation<Array<Float>> {
		return new tink.json.Representation(this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<Array<Float>>):Coordinates {
		switch rep.get() {
			case [long, lat]: return new Coordinates(lat, long);
			default: throw 'Invalid coordinates';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		return Std.is(v, Array) && v.length == 2 && Std.is(v[0], Float) && Std.is(v[1], Float);
	}
}