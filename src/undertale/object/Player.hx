package undertale.object;

import engine.Controls;
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

		if (Controls.pressed("move_right"))
			velX += baseSpeed;
		if (Controls.pressed("move_left"))
			velX -= baseSpeed;
		if (Controls.pressed("move_up"))
			velY -= baseSpeed;
		if (Controls.pressed("move_down"))
			velY += baseSpeed;

        velocity = new FlxPoint(velX, velY);
		updateAnim();
	}

	private function updateAnim()
	{
		var moving = Controls.pressed("move_up") || Controls.pressed("move_down") || Controls.pressed("move_left") || Controls.pressed("move_right");

		if (Controls.pressed("move_up"))
			curDirection = "u";
		if (Controls.pressed("move_down"))
			curDirection = "d";
		if (Controls.pressed("move_right"))
			curDirection = "r";
		if (Controls.pressed("move_left"))
			curDirection = "l";

		animation.play((moving ? "move_" : "idle_") + curDirection);
            
    }
}