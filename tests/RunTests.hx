package ;

import geojson.*;
import geojson.util.*;
import haxe.unit.*;

#if flash
import flash.system.System.exit;
#else
import Sys.exit;
#end

class RunTests extends TestCase{

	static function main() {
		var r = new TestRunner();
		r.add(new RunTests());
		#if tink_json r.add(new TinkJson()); #end
		travix.Logger.exit(r.run() ? 0 : 500);
	}
	
	inline function c(lat, long) return new Coordinates(lat, long);
	
	function testCoordinates() {
		var c = new Coordinates(1.1, 2.2);
		var f:Array<Float> = c;
		assertEquals(1.1, f[1]);
		assertEquals(2.2, f[0]);
	}
	
	function testPoint() {
		var geo = new Point(1.2, 2.1);
		assertEquals('Point', geo.type);
		assertEquals(2.1, geo.longitude);
		assertEquals(1.2, geo.latitude);
		
		geo.latitude = 3.1;
		geo.longitude = 4.2;
		assertEquals(3.1, geo.latitude);
		assertEquals(4.2, geo.longitude);
		
		geo.latitude += 1;
		geo.longitude -= 1;
		assertEquals(4.1, geo.latitude);
		assertEquals(3.2, geo.longitude);
	}
	
	function testMultiPoint() {
		var geo = new MultiPoint([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('MultiPoint', geo.type);
		assertEquals(2.1, geo.points[0].longitude);
		assertEquals(1.2, geo.points[0].latitude);
		assertEquals(2.2, geo.points[1].longitude);
		assertEquals(1.3, geo.points[1].latitude);
		
		geo.points.push(new Coordinates(1.4, 2.3));
		assertEquals(2.3, geo.points[2].longitude);
		assertEquals(1.4, geo.points[2].latitude);
	}
	
	function testLineString() {
		var geo = new LineString([c(1.2, 2.1),c(1.3, 2.2)]);
		assertEquals('LineString', geo.type);
		assertEquals(2.1, geo.points[0].longitude);
		assertEquals(1.2, geo.points[0].latitude);
		assertEquals(2.2, geo.points[1].longitude);
		assertEquals(1.3, geo.points[1].latitude);
		assertEquals(0.002467974469060938, geo.length);
		
		geo.points.push(new Coordinates(1.4, 2.3));
		assertEquals(2.3, geo.points[2].longitude);
		assertEquals(1.4, geo.points[2].latitude);
	}
	
	function testMultiLineString() {
		var geo = new MultiLineString([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('MultiLineString', geo.type);
		assertEquals(2.1, geo.lines[0].points[0].longitude);
		assertEquals(1.2, geo.lines[0].points[0].latitude);
		assertEquals(2.2, geo.lines[0].points[1].longitude);
		assertEquals(1.3, geo.lines[0].points[1].latitude);
		assertEquals(2.3, geo.lines[1].points[0].longitude);
		assertEquals(1.4, geo.lines[1].points[0].latitude);
		assertEquals(2.4, geo.lines[1].points[1].longitude);
		assertEquals(1.5, geo.lines[1].points[1].latitude);
		
		geo.lines.push(new Line([c(1.6, 2.5),c(1.7, 2.6)]));
		assertEquals(2.5, geo.lines[2].points[0].longitude);
		assertEquals(1.6, geo.lines[2].points[0].latitude);
		assertEquals(2.6, geo.lines[2].points[1].longitude);
		assertEquals(1.7, geo.lines[2].points[1].latitude);
	}
	
	function testPolygon() {
		var geo = new Polygon([[c(1.2, 2.1),c(1.3, 2.2)]]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.lines[0].points[0].longitude);
		assertEquals(1.2, geo.lines[0].points[0].latitude);
		assertEquals(2.2, geo.lines[0].points[1].longitude);
		assertEquals(1.3, geo.lines[0].points[1].latitude);
		
		geo.lines[0].points.push(new Coordinates(1.4, 2.3));
		assertEquals(2.3, geo.lines[0].points[2].longitude);
		assertEquals(1.4, geo.lines[0].points[2].latitude);
	}
	
	function testPointInPolygon() {
		var geo = new Polygon([[
	  	c(22.411663305112153,114.21318054199219),
	  	c(22.4124567804752,114.20841693878174),
	  	c(22.418725076512242,114.19841766357422),
	  	c(22.410552431990315,114.17408466339111),
	  	c(22.376269697451125,114.14880752563477),
	  	c(22.35658505121842,114.1560173034668),
	  	c(22.35515621858977,114.17472839355469),
	  	c(22.371031313362913,114.20236587524414),
	  	c(22.37134879679825,114.2251968383789),
	  	c(22.39039647758608,114.2274284362793),
	  	c(22.401347713040746,114.225196838378),
		]]);
		assertTrue(geo.containsPoint(c(22.388123, 114.202033)));
		assertFalse(geo.containsPoint(c(22.456397, 114.191304)));
	}
	
	function testMultiRingPolygon() {
		var geo = new Polygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		assertEquals('Polygon', geo.type);
		assertEquals(2.1, geo.lines[0].points[0].longitude);
		assertEquals(1.2, geo.lines[0].points[0].latitude);
		assertEquals(2.2, geo.lines[0].points[1].longitude);
		assertEquals(1.3, geo.lines[0].points[1].latitude);
		assertEquals(2.3, geo.lines[1].points[0].longitude);
		assertEquals(1.4, geo.lines[1].points[0].latitude);
		assertEquals(2.4, geo.lines[1].points[1].longitude);
		assertEquals(1.5, geo.lines[1].points[1].latitude);
		
		geo.lines.push(new Line([c(1.6, 2.5),c(1.7, 2.6)]));
		assertEquals(2.5, geo.lines[2].points[0].longitude);
		assertEquals(1.6, geo.lines[2].points[0].latitude);
		assertEquals(2.6, geo.lines[2].points[1].longitude);
		assertEquals(1.7, geo.lines[2].points[1].latitude);
	}
	
	function testMultiPolygon() {
		var geo = new MultiPolygon([[[c(1.2, 2.1),c(1.3, 2.2)]], [[c(1.4, 2.3),c(1.5, 2.4)]]]);
		assertEquals('MultiPolygon', geo.type);
		assertEquals(2.1, geo.polygons[0].lines[0].points[0].longitude);
		assertEquals(1.2, geo.polygons[0].lines[0].points[0].latitude);
		assertEquals(2.2, geo.polygons[0].lines[0].points[1].longitude);
		assertEquals(1.3, geo.polygons[0].lines[0].points[1].latitude);
		assertEquals(2.3, geo.polygons[1].lines[0].points[0].longitude);
		assertEquals(1.4, geo.polygons[1].lines[0].points[0].latitude);
		assertEquals(2.4, geo.polygons[1].lines[0].points[1].longitude);
		assertEquals(1.5, geo.polygons[1].lines[0].points[1].latitude);
		
		geo.polygons.push(new Lines([new Line([c(1.6, 2.5),c(1.7, 2.6)])]));
		assertEquals(2.5, geo.polygons[2].lines[0].points[0].longitude);
		assertEquals(1.6, geo.polygons[2].lines[0].points[0].latitude);
		assertEquals(2.6, geo.polygons[2].lines[0].points[1].longitude);
		assertEquals(1.7, geo.polygons[2].lines[0].points[1].latitude);
	}
		
	function testGeometryCollection() {
		
		var collection = new GeometryCollection([
			new Point(11, 21),
			new Point(12, 22),
		]);
		
		var count = 0;
		for(point in collection) {
			// $type(point); // geojson.Point, the compiler knows it is a `Point` if you are not mixing different types
			count++;
			assertEquals(10. + count, point.latitude);
			assertEquals(20. + count, point.longitude);
		}
	}
	
	function testGeometryCollectionMixed() {
		
		// Use `Geometry` as the type parameter
		// when using GeometryCollection for mixed types
		var collection = new GeometryCollection<Geometry>([
			new Point(1.1, 1.2),
			new MultiPoint([c(2.1, 2.2),c(2.3, 2.4)]),
			new LineString([c(3.1, 3.2),c(3.3, 3.4)]),
			new MultiLineString([[c(4.1, 4.2),c(4.3, 4.4)], [c(4.5, 4.6),c(4.7, 4.8)]]),
			new Polygon([[c(5.1, 5.2),c(5.3, 5.4)]]),
			new MultiPolygon([[[c(6.1, 6.2),c(6.3, 6.4)]], [[c(6.5, 6.6),c(6.7, 6.8)]]]),
		]);
		
		for(geometry in collection) {
			// Use a generic function to correctly type the collection objects (no runtime performance penalty)
			check(geometry);
			
			// or use the provided static function which wraps the geometry in a Haxe enum (has runtime performance penalty)
			switch GeometryCollection.get(geometry) {
				case Point(geometry):
					assertEquals(1.1, geometry.latitude);
					assertEquals(1.2, geometry.longitude);
				case MultiPoint(geometry):
					assertEquals(2.1 ,geometry.points[0].latitude);
					assertEquals(2.2 ,geometry.points[0].longitude);
				case LineString(geometry):
					assertEquals(3.1 ,geometry.points[0].latitude);
					assertEquals(3.2 ,geometry.points[0].longitude);
				case MultiLineString(geometry):
					assertEquals(4.1 ,geometry.lines[0].points[0].latitude);
					assertEquals(4.2 ,geometry.lines[0].points[0].longitude);
				case Polygon(geometry):
					assertEquals(5.1 ,geometry.lines[0].points[0].latitude);
					assertEquals(5.2 ,geometry.lines[0].points[0].longitude);
				case MultiPolygon(geometry):
					assertEquals(6.1 ,geometry.polygons[0].lines[0].points[0].latitude);
					assertEquals(6.2 ,geometry.polygons[0].lines[0].points[0].longitude);
			}
		}
		
	}
	
	inline function check<T:Geometry.Typed<T>>(geometry:T) {
		// $type(geometry); // check.T, but it will be correctly typed inside the switch block
		switch geometry.type {
			case Point:
				// $type(geometry); // geojson.Point
				assertEquals(1.1, geometry.latitude);
				assertEquals(1.2, geometry.longitude);
			case MultiPoint:
				// $type(geometry); // geojson.MultiPoint
				assertEquals(2.1 ,geometry.points[0].latitude);
				assertEquals(2.2 ,geometry.points[0].longitude);
			case LineString:
				// $type(geometry); // geojson.LineString
				assertEquals(3.1 ,geometry.points[0].latitude);
				assertEquals(3.2 ,geometry.points[0].longitude);
			case MultiLineString:
				// $type(geometry); // geojson.MultiLineString
				assertEquals(4.1 ,geometry.lines[0].points[0].latitude);
				assertEquals(4.2 ,geometry.lines[0].points[0].longitude);
			case Polygon:
				// $type(geometry); // geojson.Polygon
				assertEquals(5.1 ,geometry.lines[0].points[0].latitude);
				assertEquals(5.2 ,geometry.lines[0].points[0].longitude);
			case MultiPolygon:
				// $type(geometry); // geojson.MultiPolygon
				assertEquals(6.1 ,geometry.polygons[0].lines[0].points[0].latitude);
				assertEquals(6.2 ,geometry.polygons[0].lines[0].points[0].longitude);
		}
	}
	
}