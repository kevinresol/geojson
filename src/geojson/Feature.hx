package geojson;

import haxe.DynamicAccess;
import haxe.extern.*;

@:forward(id, geometry, properties)
abstract Feature<T:Geometry.Typed<T>, Data>(FeatureObject<T, Data>) from FeatureObject<T, Data> to FeatureObject<T, Data> {
	public inline function new(geometry, ?properties:Data, ?id:FeatureId) {
		this = {
			type: 'Feature',
			geometry: geometry,
			properties: properties,
		}
		if(id != null) this.id = id;
	}
		
	public inline function get() return GeometryCollection.get(this.geometry);
}

private typedef FeatureObject<T:Geometry.Typed<T>, Data> = {
	type:String,
	geometry:T,
	properties:Data,
	?id:FeatureId,
}

typedef FeatureId = EitherType<String, Int>;