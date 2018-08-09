package geojson.util;

abstract Degree(Float) from Float to Float {
	public inline function new(degrees:Float, ?minutes:Float, ?seconds:Float)
		this = degrees + (minutes == null ? 0 : minutes / 60) + (seconds == null ? 0 : seconds / 3600);
}