package geojson;

import geojson.util.*;

abstract MultiPolygon(GeoJson<MultiPolygon, Liness>) to GeoJson<MultiPolygon, Liness> {
	
	public var polygons(get, set):Liness;
	public var type(get, never):GeometryType<MultiPolygon>;
	
	public inline function new(polygons:Liness)
		this = {
			type: MultiPolygon,
			coordinates: polygons,
		}
		
	@:from
	public static inline function fromPolygons(polygons:Array<Polygon>) {
		return new MultiPolygon([for(polygon in polygons) polygon.lines]);
	}
		
	@:to
	public function toPolygons():Array<Polygon> {
		return [for(lines in polygons) new Polygon(lines)];
	}
		
	inline function get_polygons() return this.coordinates;
	inline function set_polygons(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to public inline function toGeoJson():Geometry return cast this;
	
	public function concat(others:Array<Polygon>) {
		return new MultiPolygon(polygons.concat([for(polygon in others) polygon.lines]));
	}
	
	public function containsPoint(point:Coordinates) {
		for(polygon in toPolygons()) if(polygon.containsPoint(point)) return true;
		return false;
	}
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Liness}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Liness}>):MultiPolygon {
		switch rep.get() {
			case v if(is(v)): return cast v;
			default: throw 'Invalid MultiPolygon';
		}
	}
	#end
	
	public static function is(v:Dynamic):Bool {
		// TODO: also check if each lines are valid ring (first and last coordinates are identical)
		return v.type == 'MultiPolygon' && Liness.is(v.coordinates);
	}
}
