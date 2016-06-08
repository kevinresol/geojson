# geojson [![Build Status](https://travis-ci.org/kevinresol/geojson.svg?branch=master)](https://travis-ci.org/kevinresol/geojson)

GeoJSON for Haxe. 

Wraps GeoJSON objects with abstracts to provide APIs which are much easier to work with.

## Usage

```haxe
var point = new Point(1.2, 2.1);
trace(point.latitude, point.longitude);

var lineString = new LineString([
	new Coordinates(1.2, 2.1),
	new Coordinates(1.2, 2.1),
]);
trace(lineString.points[0].latitude, lineString.points[0].longitude)
```

More: See tests folder.