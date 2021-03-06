package geojson;

import geojson.util.*;

abstract MultiPoint(GeoJson<MultiPoint, Array<Coordinates>>) to GeoJson<MultiPoint, Array<Coordinates>> {
	
	public var points(get, set):Array<Coordinates>;
	public var type(get, never):GeometryType<MultiPoint>;
	
	public inline function new(points:Array<Coordinates>)
		this = {
			type: MultiPoint,
			coordinates: points,
		}
		
		
	@:from
	public static inline function fromPoints(points:Array<Point>) {
		return new MultiPoint([for(point in points) point.coordinates]);
	}
		
	inline function get_points()return this.coordinates;
	inline function set_points(v)return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Array<Coordinates>}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Array<Coordinates>}>):MultiPoint {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid MultiPoint';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		if(v.type != 'MultiPoint') return false;
		if(!Std.is(v.coordinates, Array)) return false;
		for(v in (v.coordinates:Array<Dynamic>)) if(!Coordinates.is(v)) return false;
		return true;
	}
}
