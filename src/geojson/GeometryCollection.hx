package geojson;

import geojson.Geometry;
import geojson.GeometryType;
import geojson.util.*;

abstract GeometryCollection<T:Geometry.Typed<T>>(GeometryCollectionObject<T>) from GeometryCollectionObject<T> to GeometryCollectionObject<T> {
	
	public var geometries(get, set):Array<T>;
	public var type(get, never):String;
	
	public static function get<T:Geometry.Typed<T>>(geometry:T):GeometryKind
		return switch geometry.type {
			case Point: Point(geometry);
			case MultiPoint: MultiPoint(geometry);
			case LineString: LineString(geometry);
			case MultiLineString: MultiLineString(geometry);
			case Polygon: Polygon(geometry);
			case MultiPolygon: MultiPolygon(geometry);
		}
	
	public inline function new(geometries:Array<T>)
		this = {
			type: 'GeometryCollection',
			geometries: geometries,
		}
	
	public inline function iterator() return geometries.iterator();
	inline function get_geometries() return this.geometries;
	inline function set_geometries(v) return this.geometries = v;
	inline function get_type() return this.type;
}

private typedef GeometryCollectionObject<T:Geometry.Typed<T>> = {
	type:String,
	geometries:Array<T>,
}


enum GeometryKind {
	Point(geometry:geojson.Point);
	LineString(geometry:geojson.LineString);
	Polygon(geometry:geojson.Polygon);
	MultiPoint(geometry:geojson.MultiPoint);
	MultiLineString(geometry:geojson.MultiLineString);
	MultiPolygon(geometry:geojson.MultiPolygon);
}