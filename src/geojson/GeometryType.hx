package geojson;


@:enum
abstract GeometryType<C>(String) to String {
	var Point:GeometryType<geojson.Point> = 'Point';
	var LineString:GeometryType<geojson.LineString> = 'LineString';
	var Polygon:GeometryType<geojson.Polygon> = 'Polygon';
	var MultiPoint:GeometryType<geojson.MultiPoint> = 'MultiPoint';
	var MultiLineString:GeometryType<geojson.MultiLineString> = 'MultiLineString';
	var MultiPolygon:GeometryType<geojson.MultiPolygon> = 'MultiPolygon';
	
	@:op(A == B)
	function eq(s:String):Bool;
}


