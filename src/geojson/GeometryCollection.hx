package geojson;

import geojson.GeoJsonGeometry;
import geojson.GeoJsonGeometryType;
import geojson.util.*;

abstract GeometryCollection(GeometryCollectionObject) from GeometryCollectionObject to GeometryCollectionObject {
	
	public var geometries(get, set):Array<GeoJsonGeometry>;
	public var type(get, never):String;
	
	public inline function new(geometries:Array<GeoJsonGeometry>)
		this = {
			type: 'GeometryCollection',
			geometries: geometries,
		}
	
	public inline function iterator() return geometries.iterator();
	inline function get_geometries() return this.geometries;
	inline function set_geometries(v) return this.geometries = v;
	inline function get_type() return this.type;
}

private typedef GeometryCollectionObject = {
	type:String,
	geometries:Array<GeoJsonGeometry>,
}