package undertale.object;

import box2D.common.math.B2Vec2;
import engine.GameObject;
import engine.GameObject;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Player extends GameObject {

    public var speed:Float;

    override public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
        loadGraphic(Resources.image("sprites/mainchar/mainchar_d0"));
        resetSizeFromFrame();
        createRectangleBody(15, 15);

        FlxG.watch.add(this, "x");
        FlxG.watch.add(this, "y");
        FlxG.watch.add(body, "x");
        FlxG.watch.add(body.m_linearVelocity, "y");
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        var velX = 0.0;
        var velY = 0.0;

        if (FlxG.keys.pressed.D)
            velX += speed;
        if (FlxG.keys.pressed.A)
            velX -= speed;
        if (FlxG.keys.pressed.W)
            velY -= speed;
        if (FlxG.keys.pressed.S)
            velY += speed;

        velocity = new FlxPoint(velX, velY);
    }
}