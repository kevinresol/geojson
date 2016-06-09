package geojson;

import geojson.util.*;

private typedef Object = GeoJson<MultiPolygon, Array<Lines>>;
abstract MultiPolygon(Object) from Object to Object {
	
	public var polygons(get, set):Array<Lines>;
	public var type(get, never):GeoJsonGeometryType<MultiPolygon>;
	
	public inline function new(polygons:Array<Lines>)
		this = {
			type: MultiPolygon,
			coordinates: polygons,
		}
		
	inline function get_polygons() return this.coordinates;
	inline function set_polygons(v) return this.coordinates = v;
	inline function get_type() return this.type;
	@:to inline function toGeoJson():GeoJsonGeometry return cast this;
}
