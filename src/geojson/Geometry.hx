package geojson;

typedef Geometry = Typed<Geometry>;

typedef Typed<T> = {
	type:GeometryType<T>,
	coordinates:Dynamic,
}
