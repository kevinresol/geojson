import deepequal.DeepEqual.*;
import geojson.util.*;
import geojson.*;
import haxe.unit.*;

using tink.CoreApi;

class TinkJson extends TestCase {
	
	inline function c(lat, long) return new Coordinates(lat, long);
	
	#if tink_json
	public function testStringify() {
		var g = new Point(22.4, 114.4);
		var o:Point = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
		var g = new LineString([c(22.4, 114.4),c(22.5, 114.5)]);
		var o:LineString = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
		var g = new Polygon([[c(22.4, 114.4),c(22.5, 114.4),c(22.4, 114.5),c(22.4, 114.4)]]);
		var o:Polygon = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
		var g = new MultiPoint([c(22.4, 114.4),c(22.5, 114.5)]);
		var o:MultiPoint = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
		var g = new MultiLineString([[c(22.4, 114.4),c(22.5, 114.5)],[c(22.4, 114.4),c(22.5, 114.5)]]);
		var o:MultiLineString = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
		var g = new MultiPolygon([[[c(22.4, 114.4),c(22.5, 114.4),c(22.4, 114.5),c(22.4, 114.4)]]]);
		var o:MultiPolygon = tink.Json.parse(tink.Json.stringify(g));
		assertTrue(compare(g, o).isSuccess());
		
	}
	#end
}