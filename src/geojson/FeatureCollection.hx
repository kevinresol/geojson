package geojson;

@:forward(features)
abstract FeatureCollection(FeatureCollectionObject) from FeatureCollectionObject to FeatureCollectionObject {
	public inline function new(features)
		this = {
			type: 'FeatureCollection',
			features: features,
		}
		
	public inline function iterator() return this.features.iterator();
}

private typedef FeatureCollectionObject = {
	type:String,
	features:Array<Feature>,
}