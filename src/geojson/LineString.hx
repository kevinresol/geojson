package geojson;

import geojson.util.*;

abstract LineString(GeoJson<LineString, Array<Coordinates>>) to GeoJson<LineString, Array<Coordinates>> {
	
	static inline var TO_RADIANS = 3.14159265359 / 180;
	static inline var TO_DEGREES = 180 / 3.14159265359;

	public var points(get, set):Array<Coordinates>;
	public var type(get, never):GeometryType<LineString>;
	
	
	/**
		Length of this LineString. Normalized against the sphere's radius.
		In other words, multiply this length with the sphere's raduis to get the actual length on the sphere surface.
	**/
	public var length(get, never):Float;
	
	public inline function new(line:Array<Coordinates>)
		this = {
			type: LineString,
			coordinates: line,
		}
		
	
	@:to 
	public inline function toLine():Line return this.coordinates;
	@:from 
	public static inline function fromLine(v:Line) return new LineString(v);

	function get_length() {
		var total = 0.;
		for(i in 0...points.length - 1)
			total += points[i].distanceTo(points[i+1], 1);
		return total;
	}
		
	inline function get_points() return this.coordinates;
	inline function set_points(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Line}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Line}>):LineString {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid LineString';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		if(v.type != 'LineString') return false;
		if(!Std.is(v.coordinates, Array)) return false;
		for(v in (v.coordinates:Array<Dynamic>)) if(!Coordinates.is(v)) return false;
		return true;
	}
}