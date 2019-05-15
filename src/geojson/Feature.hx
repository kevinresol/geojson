package geojson;

import haxe.DynamicAccess;

@:forward(id, geometry, properties)
abstract Feature(FeatureObject) from FeatureObject to FeatureObject {
	public inline function new(geometry, ?id, ?properties)
		this = {
			type: 'Feature',
			id: id,
			geometry: geometry,
			properties: properties,
		}
}

private typedef FeatureObject = {
	type:String,
	id:String,
	geometry:Geometry,
	properties:DynamicAccess<String>,
}