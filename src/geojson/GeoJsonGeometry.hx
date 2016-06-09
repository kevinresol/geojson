package geojson;

typedef GeoJsonGeometry = Typed<GeoJsonGeometry>;

typedef Typed<T> = {
	type:GeoJsonGeometryType<T>,
}
