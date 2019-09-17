package geojson;

import geojson.util.*;

abstract MultiLineString(GeoJson<MultiLineString, Array<Line>>) to GeoJson<MultiLineString, Array<Line>> {
	
	public var lines(get, set):Array<Line>;
	public var type(get, never):GeometryType<MultiLineString>;
	
	public inline function new(lines:Array<Line>)
		this = {
			type: MultiLineString,
			coordinates: lines,
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
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Array<Line>}>):MultiLineString {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid MultiLineString';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		if(v.type != 'MultiLineString') return false;
		if(!Std.is(v.coordinates, Array)) return false;
		for(v in (v.coordinates:Array<Dynamic>)) if(!Line.is(v)) return false;
		return true;
	}
}
