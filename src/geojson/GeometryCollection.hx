package geojson;

import geojson.GeoJsonGeometry;
import geojson.GeoJsonGeometryType;
import geojson.util.*;

abstract GeometryCollection(GeometryCollectionObject) from GeometryCollectionObject to GeometryCollectionObject {
	
	public var geometries(get, set):Array<GeoJsonGeometry>;
	public var type(get, never):String;
	
	public static function get<T:GeoJsonGeometry.Typed<T>>(geometry:T):GeoJsonGeometryKind
		return switch geometry.type {
			case Point: Point(geometry);
			case MultiPoint: MultiPoint(geometry);
			case LineString: LineString(geometry);
			case MultiLineString: MultiLineString(geometry);
			case Polygon: Polygon(geometry);
			case MultiPolygon: MultiPolygon(geometry);
		}
	
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


enum GeoJsonGeometryKind {
	Point(geometry:geojson.Point);
	LineString(geometry:geojson.LineString);
	Polygon(geometry:geojson.Polygon);
	MultiPoint(geometry:geojson.MultiPoint);
	MultiLineString(geometry:geojson.MultiLineString);
	MultiPolygon(geometry:geojson.MultiPolygon);
}