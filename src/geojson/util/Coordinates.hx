package geojson.util;

abstract Coordinates(CoordinatesObject) from CoordinatesObject to CoordinatesObject {
	@:to
	public inline function toFloatArray():Array<Float>
		return [this.longitude, this.latitude];
}

typedef CoordinatesObject = {
	latitude:Float,
	longitude:Float,
}