package undertale.system.overworld;

import flixel.FlxObject;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxFrame;
import flixel.util.FlxDestroyUtil;
import openfl.geom.ColorTransform;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import undertale.system.overworld.Overworld;

typedef RoomFile =
{
	var layers:Array<Layer>;
}

class Room extends FlxObject {
    public static var tileGraphicCache:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();

    public var layers:Array<Layer> = [{tiles: [], decals: []}];

    var _frame:FlxFrame;
	public var colorTransform(default, null) = new ColorTransform();

    override public function new() {
        super();
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
    }

    override public function draw() {
        super.draw();

        for (layer in layers)
        {
            for (tilecolumn in layer.tiles)
            {
				if (tilecolumn == null)
					continue;
                for (tile in tilecolumn)
                {
                    if (tile == null)
                        continue;
                    var pos:Point = new Point(tile.x * Overworld.TILE_SIZE, tile.y * Overworld.TILE_SIZE);
                    var rect:Rectangle = new Rectangle(0, 0, Overworld.TILE_SIZE, Overworld.TILE_SIZE);

                    if (!tileGraphicCache.exists(tile.img))
                    {
                        var graphic:FlxGraphic = FlxGraphic.fromAssetKey(tile.img);
                        tileGraphicCache.set(tile.img, graphic);
                    }
                    _frame = tileGraphicCache[tile.img].imageFrame.frame;

                    camera.copyPixels(_frame, tileGraphicCache[tile.img].bitmap, rect, pos, colorTransform, openfl.display.BlendMode.NORMAL, false);
                }
            }

            for (decal in layer.decals)
            {

            }
        }
    }

    override function destroy() {
        super.destroy();
        _frame = FlxDestroyUtil.destroy(_frame);
    }
}