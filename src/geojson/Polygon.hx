package geojson;

import geojson.util.*;

private typedef Object = GeoJson<Polygon, Array<Line>>;
abstract Polygon(Object) from Object to Object {
	
	static inline var TO_RADIANS = 3.14159265359 / 180;
	static inline var TO_DEGREES = 180 / 3.14159265359;
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):GeometryType<Polygon>;
	
	public inline function new(lines:Array<Line>)
		this = {
			type: Polygon,
			coordinates: lines,
		}
		
	/**
		Construct a regular polygon
		@param center center of the Polygon
		@param sides number of sides of the polygon
		@param radius radius of the polygon, normalized against the sphere's radius. For the Earth, use X(km) / 6378.1 (the Earth has mean radius of 6371km)
		@param bearing the starting bearing in degrees, default 0
		
		Example: 
		The following code constructs a hexagon of radius 10km centered somewhere in Asia
		`regular([114.153775, 22.413735], 6, 10 / 6371)`
	**/
	public static function regular(center:Coordinates, sides:Int, radius:Float, bearingOffset:Float = 0) {
		var lat = center.latitude * TO_RADIANS;
		var long = center.longitude * TO_RADIANS;
		var sinLat = Math.sin(lat);
		var cosLat = Math.cos(lat);
		var sinRadius = Math.sin(radius);
		var cosRadius = Math.cos(radius);
		bearingOffset *= TO_RADIANS;
		
		var points = [for(n in 0...sides) {
			var bearing = 2 * 3.14159265359 / sides * n + bearingOffset;
			new Coordinates(
				(Math.asin(sinLat * cosRadius + cosLat * sinRadius * Math.cos(bearing))) * TO_DEGREES,
				(long + Math.atan2(Math.sin(bearing) * sinRadius * cosLat, cosRadius - sinLat * sinLat)) * TO_DEGREES
			);
		}];
		points.push(points[0]); // back to origin
		return new Polygon([points]);
	}
		
	inline function get_lines() return this.coordinates;
	inline function set_lines(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
}
