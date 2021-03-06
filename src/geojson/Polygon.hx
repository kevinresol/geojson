package geojson;

import geojson.util.*;
import geojson.util.Constants.*;

abstract Polygon(GeoJson<Polygon, Array<Line>>) to GeoJson<Polygon, Array<Line>> {
	
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
	
	/**
		Determines if a point is contained in this polygon.
		Reference: http://geospatialpython.com/2011/01/point-in-polygon.html
		TODO: does this work if the polygon spans across the +/- boundary (e.g. the north/south poles or equator)?
		
		@param point the point to check
		@return true if this polygon contains the given point
	**/
	public function containsPoint(point:Coordinates) {
		function _contains(point:Coordinates, line:Line) {
			var n = line.length - 1;
			var result = false;
			var lat1 = line[0].latitude;
			var long1 = line[0].longitude;
			var longints = Math.NEGATIVE_INFINITY;
			for(i in 0...n+1) {
				var current = line[i % n];
				var lat2 = current.latitude;
				var long2 = current.longitude;
				if(point.latitude > Math.min(lat1, lat2)) {
					if(point.latitude <= Math.max(lat1, lat2)) {
						if(point.longitude <= Math.max(long1, long2)) {
							if(lat1 != lat2)
							longints = (point.latitude - lat1) * (long2 - long1) / (lat2 - lat1) + long1;
							if(long1 == long2 || point.longitude <= longints)
							result = !result;
						}
					}
				}
				lat1 = lat2;
				long1 = long2;
			}
			return result;
		}
		
		// check outer boundary
		if(!_contains(point, lines[0])) return false;
		// check the "holes"
		for(i in 1...lines.length) if(_contains(point, lines[i])) return false;
		return true;
	}
		
	inline function get_lines() return this.coordinates;
	inline function set_lines(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Array<Line>}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Array<Line>}>):Polygon {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid Polygon';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		if(v.type != 'Polygon') return false;
		if(!Std.is(v.coordinates, Array)) return false;
		for(v in (v.coordinates:Array<Dynamic>)) if(!Line.is(v)) return false;
		return true;
	}
}
