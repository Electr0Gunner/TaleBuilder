package engine;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2World;
import flixel.FlxBasic;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.util.FlxSort;

/**
 * Scene is a derived FlxState containing Z and Y based sorting for objects.
 */
class Scene extends FlxState {

    public var sortMode:SortFlags = SortFlags.ByZ;

    override function update(elapsed:Float) {
        super.update(elapsed);
        sortMembers();
        PhysicsWorld.update(elapsed);
    }

    override function draw() {
        super.draw();
        PhysicsWorld.drawDebug();
    }

    override function destroy() {
        super.destroy();
        PhysicsWorld.destroy();
    }

    function sortMembers() {
        if (members == null)
            return;

        members.sort((a:FlxBasic, b:FlxBasic) -> {
            var objectA = Std.isOfType(a, FlxObject) ? cast(a, FlxObject) : null;
            var objectB = Std.isOfType(b, FlxObject) ? cast(b, FlxObject) : null;
            if (objectA == null || objectB == null)
                return 0;

            var orderZ = (sortMode & SortFlags.ByZ) != 0;
            var orderY = (sortMode & SortFlags.ByY) != 0;

            if (orderZ)
            {
                var diff = FlxSort.byValues(FlxSort.ASCENDING, objectA.z, objectB.z);
                if (diff != 0)
                    return diff;
            }
            if (orderY)
            {
               var diff = FlxSort.byValues(FlxSort.ASCENDING, objectA.y, objectB.y);
                if (diff != 0)
                    return diff;
            }

            return 0;
        });
    }


}

enum abstract SortFlags(Int) from Int to Int {
    public static inline var None:Int = 0;
    public static inline var ByZ:Int = 1 << 0;
    public static inline var ByY:Int = 1 << 1;
}