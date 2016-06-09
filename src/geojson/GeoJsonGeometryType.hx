package geojson;


@:enum
abstract GeoJsonGeometryType<C>(String) to String {
	var Point:GeoJsonGeometryType<geojson.Point> = 'Point';
	var LineString:GeoJsonGeometryType<geojson.LineString> = 'LineString';
	var Polygon:GeoJsonGeometryType<geojson.Polygon> = 'Polygon';
	var MultiPoint:GeoJsonGeometryType<geojson.MultiPoint> = 'MultiPoint';
	var MultiLineString:GeoJsonGeometryType<geojson.MultiLineString> = 'MultiLineString';
	var MultiPolygon:GeoJsonGeometryType<geojson.MultiPolygon> = 'MultiPolygon';
}


