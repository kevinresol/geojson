package geojson;

@:forward(features)
abstract FeatureCollection<T:Geometry.Typed<T>, Data>(FeatureCollectionObject<T, Data>) from FeatureCollectionObject<T, Data> to FeatureCollectionObject<T, Data> {
	public inline function new(features)
		this = {
			type: 'FeatureCollection',
			features: features,
		}
		
	public inline function iterator() return this.features.iterator();
}

private typedef FeatureCollectionObject<T:Geometry.Typed<T>, Data> = {
	type:String,
	features:Array<Feature<T, Data>>,
}