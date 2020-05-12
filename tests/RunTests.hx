package ;

import geojson.*;
import geojson.util.*;
import tink.unit.*;
import tink.testrunner.*;

#if flash
import flash.system.System.exit;
#else
import Sys.exit;
#end

@:asserts
class RunTests {

	static function main() {
		Runner.run(TestBatch.make([
			new RunTests(),
			new Validation(),
			new WkbTest(),
			#if tink_json new TinkJson(), #end
		])).handle(Runner.exit);
	}
	
	public function new() {}
	
	inline function c(lat, long) return new Coordinates(lat, long);
	
	public function coordinates() {
		var c = new Coordinates(1.1, 2.2);
		var f:Array<Float> = c;
		asserts.assert(f[1] == 1.1);
		asserts.assert(f[0] == 2.2);
		return asserts.done();
	}
	
	public function point() {
		var geo = new Point(1.2, 2.1);
		asserts.assert(geo.type == Point);
		asserts.assert(geo.longitude == 2.1);
		asserts.assert(geo.latitude == 1.2);
		
		geo.latitude = 3.1;
		geo.longitude = 4.2;
		asserts.assert(geo.latitude == 3.1);
		asserts.assert(geo.longitude == 4.2);
		
		geo.latitude += 1;
		geo.longitude -= 1;
		asserts.assert(geo.latitude == 4.1);
		asserts.assert(geo.longitude == 3.2);
		return asserts.done();
	}
	
	public function multiPoint() {
		var geo = new MultiPoint([c(1.2, 2.1),c(1.3, 2.2)]);
		asserts.assert(geo.type == MultiPoint);
		asserts.assert(geo.points[0].longitude == 2.1);
		asserts.assert(geo.points[0].latitude == 1.2);
		asserts.assert(geo.points[1].longitude == 2.2);
		asserts.assert(geo.points[1].latitude == 1.3);
		
		geo.points.push(new Coordinates(1.4, 2.3));
		asserts.assert(geo.points[2].longitude == 2.3);
		asserts.assert(geo.points[2].latitude == 1.4);
		return asserts.done();
	}
	
	public function lineString() {
		var geo = new LineString([c(1.2, 2.1),c(1.3, 2.2)]);
		asserts.assert(geo.type == LineString);
		asserts.assert(geo.points[0].longitude == 2.1);
		asserts.assert(geo.points[0].latitude == 1.2);
		asserts.assert(geo.points[1].longitude == 2.2);
		asserts.assert(geo.points[1].latitude == 1.3);
		asserts.assert(Math.abs(0.0024679744690609 - geo.length) < 0.0000000000000001);
		
		geo.points.push(new Coordinates(1.4, 2.3));
		asserts.assert(geo.points[2].longitude == 2.3);
		asserts.assert(geo.points[2].latitude == 1.4);
		return asserts.done();
	}
	
	public function multiLineString() {
		var geo = new MultiLineString([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		asserts.assert(geo.type == MultiLineString);
		asserts.assert(geo.lines[0].points[0].longitude == 2.1);
		asserts.assert(geo.lines[0].points[0].latitude == 1.2);
		asserts.assert(geo.lines[0].points[1].longitude == 2.2);
		asserts.assert(geo.lines[0].points[1].latitude == 1.3);
		asserts.assert(geo.lines[1].points[0].longitude == 2.3);
		asserts.assert(geo.lines[1].points[0].latitude == 1.4);
		asserts.assert(geo.lines[1].points[1].longitude == 2.4);
		asserts.assert(geo.lines[1].points[1].latitude == 1.5);
		
		geo.lines.push(new Line([c(1.6, 2.5),c(1.7, 2.6)]));
		asserts.assert(geo.lines[2].points[0].longitude == 2.5);
		asserts.assert(geo.lines[2].points[0].latitude == 1.6);
		asserts.assert(geo.lines[2].points[1].longitude == 2.6);
		asserts.assert(geo.lines[2].points[1].latitude == 1.7);
		return asserts.done();
	}
	
	public function polygon() {
		var geo = new Polygon([[c(1.2, 2.1),c(1.3, 2.2)]]);
		asserts.assert(geo.type == Polygon);
		asserts.assert(geo.lines[0].points[0].longitude == 2.1);
		asserts.assert(geo.lines[0].points[0].latitude == 1.2);
		asserts.assert(geo.lines[0].points[1].longitude == 2.2);
		asserts.assert(geo.lines[0].points[1].latitude == 1.3);
		
		geo.lines[0].points.push(new Coordinates(1.4, 2.3));
		asserts.assert(geo.lines[0].points[2].longitude == 2.3);
		asserts.assert(geo.lines[0].points[2].latitude == 1.4);
		return asserts.done();
	}
	
	public function pointInPolygon() {
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
		asserts.assert(geo.containsPoint(c(22.388123, 114.202033)));
		asserts.assert(!geo.containsPoint(c(22.456397, 114.191304)));
		return asserts.done();
	}
	
	public function multiRingPolygon() {
		var geo = new Polygon([[c(1.2, 2.1),c(1.3, 2.2)], [c(1.4, 2.3),c(1.5, 2.4)]]);
		asserts.assert(geo.type == Polygon);
		asserts.assert(geo.lines[0].points[0].longitude == 2.1);
		asserts.assert(geo.lines[0].points[0].latitude == 1.2);
		asserts.assert(geo.lines[0].points[1].longitude == 2.2);
		asserts.assert(geo.lines[0].points[1].latitude == 1.3);
		asserts.assert(geo.lines[1].points[0].longitude == 2.3);
		asserts.assert(geo.lines[1].points[0].latitude == 1.4);
		asserts.assert(geo.lines[1].points[1].longitude == 2.4);
		asserts.assert(geo.lines[1].points[1].latitude == 1.5);
		
		geo.lines.push(new Line([c(1.6, 2.5),c(1.7, 2.6)]));
		asserts.assert(geo.lines[2].points[0].longitude == 2.5);
		asserts.assert(geo.lines[2].points[0].latitude == 1.6);
		asserts.assert(geo.lines[2].points[1].longitude == 2.6);
		asserts.assert(geo.lines[2].points[1].latitude == 1.7);
		return asserts.done();
	}
	
	public function multiPolygon() {
		var geo = new MultiPolygon([
			[[c(1.2, 2.1),c(1.3, 2.2)]], [[c(1.4, 2.3),c(1.5, 2.4)]],
			new Lines([new Line([c(1.6, 2.5),c(1.7, 2.6)])])
		]);
		asserts.assert(geo.type == MultiPolygon);
		asserts.assert(geo.polygons[0].lines[0].points[0].longitude == 2.1);
		asserts.assert(geo.polygons[0].lines[0].points[0].latitude == 1.2);
		asserts.assert(geo.polygons[0].lines[0].points[1].longitude == 2.2);
		asserts.assert(geo.polygons[0].lines[0].points[1].latitude == 1.3);
		asserts.assert(geo.polygons[1].lines[0].points[0].longitude == 2.3);
		asserts.assert(geo.polygons[1].lines[0].points[0].latitude == 1.4);
		asserts.assert(geo.polygons[1].lines[0].points[1].longitude == 2.4);
		asserts.assert(geo.polygons[1].lines[0].points[1].latitude == 1.5);
		
		asserts.assert(geo.polygons[2].lines[0].points[0].longitude == 2.5);
		asserts.assert(geo.polygons[2].lines[0].points[0].latitude == 1.6);
		asserts.assert(geo.polygons[2].lines[0].points[1].longitude == 2.6);
		asserts.assert(geo.polygons[2].lines[0].points[1].latitude == 1.7);
		
		
		return asserts.done();
	}
		
	public function geometryCollection() {
		
		var collection = new GeometryCollection([
			new Point(11, 21),
			new Point(12, 22),
		]);
		
		var count = 0;
		for(point in collection) {
			// $type(point); // geojson.Point, the compiler knows it is a `Point` if you are not mixing different types
			count++;
			asserts.assert(point.latitude == 10. + count);
			asserts.assert(point.longitude == 20. + count);
		}
		return asserts.done();
	}
	
	public function geometryCollectionMixed() {
		
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
			check(asserts, geometry);
			
			// or use the provided static function which wraps the geometry in a Haxe enum (has runtime performance penalty)
			switch GeometryCollection.get(geometry) {
				case Point(geometry):
					asserts.assert(geometry.latitude == 1.1);
					asserts.assert(geometry.longitude == 1.2);
				case MultiPoint(geometry):
					asserts.assert(geometry.points[0].latitude == 2.1);
					asserts.assert(geometry.points[0].longitude == 2.2);
				case LineString(geometry):
					asserts.assert(geometry.points[0].latitude == 3.1);
					asserts.assert(geometry.points[0].longitude == 3.2);
				case MultiLineString(geometry):
					asserts.assert(geometry.lines[0].points[0].latitude == 4.1);
					asserts.assert(geometry.lines[0].points[0].longitude == 4.2);
				case Polygon(geometry):
					asserts.assert(geometry.lines[0].points[0].latitude == 5.1);
					asserts.assert(geometry.lines[0].points[0].longitude == 5.2);
				case MultiPolygon(geometry):
					asserts.assert(geometry.polygons[0].lines[0].points[0].latitude == 6.1);
					asserts.assert(geometry.polygons[0].lines[0].points[0].longitude == 6.2);
			}
		}
		return asserts.done();
	}
	
	inline function check<T:Geometry.Typed<T>>(asserts:AssertionBuffer, geometry:T) {
		// $type(geometry); // check.T, but it will be correctly typed inside the switch block
		switch geometry.type {
			case Point:
				// $type(geometry); // geojson.Point
				asserts.assert(geometry.latitude == 1.1);
				asserts.assert(geometry.longitude == 1.2);
			case MultiPoint:
				// $type(geometry); // geojson.MultiPoint
				asserts.assert(geometry.points[0].latitude == 2.1);
				asserts.assert(geometry.points[0].longitude == 2.2);
			case LineString:
				// $type(geometry); // geojson.LineString
				asserts.assert(geometry.points[0].latitude == 3.1);
				asserts.assert(geometry.points[0].longitude == 3.2);
			case MultiLineString:
				// $type(geometry); // geojson.MultiLineString
				asserts.assert(geometry.lines[0].points[0].latitude == 4.1);
				asserts.assert(geometry.lines[0].points[0].longitude == 4.2);
			case Polygon:
				// $type(geometry); // geojson.Polygon
				asserts.assert(geometry.lines[0].points[0].latitude == 5.1);
				asserts.assert(geometry.lines[0].points[0].longitude == 5.2);
			case MultiPolygon:
				// $type(geometry); // geojson.MultiPolygon
				asserts.assert(geometry.polygons[0].lines[0].points[0].latitude == 6.1);
				asserts.assert(geometry.polygons[0].lines[0].points[0].longitude == 6.2);
		}
		return asserts.done();
	}
	
}