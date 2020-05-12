package geojson.util;

import haxe.io.BytesInput;
import haxe.io.Bytes;

class WkbTools {
	public static function parse<T, C>(bytes: Bytes): geojson.util.GeoJson<T, C> {
		var buffer = new BytesInput(bytes, 0);
		function parseGeometry():geojson.util.GeoJson<Dynamic, Dynamic> {
			inline function multi():Dynamic
				return [for (_ in 0...buffer.readInt32()) parseGeometry()];
			inline function parsePoint():Array<Float> {
				var y = buffer.readDouble(), x = buffer.readDouble();
				return [x, y];
			}
			inline function coordinates() {
				var point = parsePoint();
				return new geojson.util.Coordinates(point[0], point[1]);
			}
			buffer.bigEndian = buffer.readByte() == 0;
			return switch buffer.readInt32() {
				case 1:
					var point = parsePoint();
					new geojson.Point(point[0], point[1]);
				case 2:
					new geojson.LineString([
						for (_ in 0...buffer.readInt32())
							coordinates()
					]);
				case 3:
					new geojson.Polygon([
						for (_ in 0...buffer.readInt32()) [for (_ in 0...buffer.readInt32()) coordinates()]
					]);
				case 4:
					geojson.MultiPoint.fromPoints(multi());
				case 5:
					geojson.MultiLineString.fromLineStrings(multi());
				case 6:
					geojson.MultiPolygon.fromPolygons(multi());
				case 7:
					(new geojson.GeometryCollection(multi()) : Dynamic);
				case v:
					throw 'GeoJson type $v not supported';
			}
		}
		return parseGeometry();
	}
}
