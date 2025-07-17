package undertale.object;

import engine.GameObject;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Player extends GameObject {

	public var curDirection:String = "d";
	public var baseSpeed:Float = 90.0;

    override public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
		// loadGraphic(Resources.image("sprites/mainchar/mainchar"));
		loadSprite(Resources.file("info/sprites/spr_mainchar"));
        resetSizeFromFrame();
		createRectangleBody(15, 15);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        var velX = 0.0;
        var velY = 0.0;

        if (FlxG.keys.pressed.D)
			velX += baseSpeed;
        if (FlxG.keys.pressed.A)
			velX -= baseSpeed;
        if (FlxG.keys.pressed.W)
			velY -= baseSpeed;
        if (FlxG.keys.pressed.S)
			velY += baseSpeed;

        velocity = new FlxPoint(velX, velY);
		updateAnim();
	}

	private function updateAnim()
	{
		if (FlxG.keys.pressed.W)
			curDirection = "u";
		if (FlxG.keys.pressed.S)
			curDirection = "d";
		if (FlxG.keys.pressed.D)
			curDirection = "r";
		if (FlxG.keys.pressed.A)
			curDirection = "l";

		animation.play("idle_" + curDirection);
            
    }
}