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
		
	inline function get_polygons() return this.coordinates;
	inline function set_polygons(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():Geometry return cast this;
	
	#if tink_json
	@:to
	public function toRepresentation():tink.json.Representation<{type:String, coordinates:Liness}> {
		return new tink.json.Representation(cast this);
	}
	
	@:from
	public static function fromRepresentation(rep:tink.json.Representation<{type:String, coordinates:Liness}>):MultiPolygon {
		switch rep.get() {
			case v if(v.type == 'MultiPolygon'): return cast v;
			default: throw 'Invalid MultiPolygon';
		}
	}
	#end
}
