package undertale.system.overworld;

typedef Tile = 
{
    var x:Int;
    var y:Int;

    var img:String;
}

typedef Decal = 
{
    var x:Float;
    var y:Float;

    var img:String;
}

typedef Layer = 
{
    var tiles:Array<Array<Tile>>;
    var decals:Array<Array<Decal>>;
}

class Overworld {
    public static final TILE_SIZE:Int = 20;
}