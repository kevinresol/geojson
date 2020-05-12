package geojson.util;

import geojson.*;
import haxe.io.BytesInput;
import haxe.io.Bytes;

class WkbTools {
	public static function parse<T, C>(bytes: Bytes): GeoJson<T, C> {
		var buffer = new BytesInput(bytes, 0);
		function parseGeometry():GeoJson<Dynamic, Dynamic> {
			inline function multi():Dynamic
				return [for (_ in 0...buffer.readInt32()) parseGeometry()];
			
			inline function coordinates():Coordinates {
				var y = buffer.readDouble(), x = buffer.readDouble();
				return new Coordinates(x, y);
			}
			
			buffer.bigEndian = buffer.readByte() == 0;
			return switch buffer.readInt32() {
				case 1: (coordinates():Point);
				case 2: new LineString([for (_ in 0...buffer.readInt32()) coordinates()]);
				case 3: new Polygon([for (_ in 0...buffer.readInt32()) [for (_ in 0...buffer.readInt32()) coordinates()]]);
				case 4: MultiPoint.fromPoints(multi());
				case 5: MultiLineString.fromLineStrings(multi());
				case 6: MultiPolygon.fromPolygons(multi());
				case 7: (new GeometryCollection(multi()) : Dynamic);
				case v: throw 'WKB type "$v" not supported';
			}
		}
		return parseGeometry();
	}
}
