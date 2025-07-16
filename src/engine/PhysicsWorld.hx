package engine;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2DebugDraw;
import box2D.dynamics.B2World;
import flixel.FlxG;

class PhysicsWorld {

    public static var world:B2World;
    public static var debugDraw:B2DebugDraw;

    public static function init() 
    {
        world = new B2World(new B2Vec2(), false);

        debugDraw = new B2DebugDraw();
        debugDraw.setFillAlpha(0.3);
        debugDraw.setLineThickness(2);
        debugDraw.setFlags(B2DebugDraw.e_shapeBit | B2DebugDraw.e_jointBit);

        world.setDebugDraw(debugDraw);

        debugDraw.setSprite(Main.debugSprite);
    }

    public static function update(elapsed:Float) 
    {
        if (world == null)
            return;

        debugDraw.setDrawScale(Constants.METER_PIXEL_RATIO * FlxG.camera.zoom);
        world.step(elapsed, 8, 3);

        //Main.debugSprite.x = FlxG.camera.viewMarginX;
        //Main.debugSprite.y = FlxG.camera.viewMarginY;
        //Main.debugSprite.width = FlxG.camera.flashSprite.width;
        //Main.debugSprite.height = FlxG.camera.flashSprite.height;
    }

    public static function drawDebug() {
        if (world == null)
            return;
        Main.debugSprite.alpha = FlxG.debugger.visible ? 0.5 : 0.0;
        world.drawDebugData();
    }
    public static function destroy() {
        Main.debugSprite.graphics.clear();
        Main.debugSprite.alpha = 0.0;
        
    }
}