package undertale.object;

import box2D.common.math.B2Vec2;
import engine.Camera;
import engine.Controls;
import engine.GameObject;
import engine.Global;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Player extends GameObject {

	public var curDirection:String = "d";
	public var baseSpeed:Float = 90.0;

	private var attachedCamera:Camera;

	public var debugSpr:FlxSprite;

	private var _entityInRange:Entity;

    override public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);
		// loadGraphic(Resources.image("sprites/mainchar/mainchar"));
		loadSprite(Resources.json("info/sprites/spr_mainchar"));
        resetSizeFromFrame();
		createRectangleBody(15, 15);
		debugSpr = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0, true);
		debugSpr.scrollFactor.set(0, 0);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

		debugSpr.update(elapsed);

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
		if (attachedCamera != null)
			updateCamera();

		_entityInRange = cast(GameObject.rayCastGetGameObject(new FlxPoint(x + width / 2, y + height / 2), getDirectionVecFromDir(curDirection), 25), Entity);

		if (Controls.justReleased("interact"))
		{
			if (_entityInRange != null)
				_entityInRange.onInteract();
		}
	}

	override function destroy()
	{
		super.destroy();
		debugSpr.destroy();
	}

	override function draw()
	{
		super.draw();
		if (Global.DEBUG_MODE)
		{
			debugSpr.draw();

			var rayColor:FlxColor = _entityInRange != null ? 0xFF00FF00 : 0xFFFF0000;

			FlxSpriteUtil.fill(debugSpr, 0);
			var dirVec = new B2Vec2(getDirectionVecFromDir(curDirection).x, getDirectionVecFromDir(curDirection).y);
			dirVec.multiply(25);

			var screenStart = new FlxPoint(x + width / 2 - camera.scroll.x, y + height / 2 - camera.scroll.y);
			var screenEnd = new FlxPoint(x + width / 2 + dirVec.x - camera.scroll.x, y + height / 2 + dirVec.y - camera.scroll.y);

			FlxSpriteUtil.drawLine(debugSpr, screenStart.x, screenStart.y, screenEnd.x, screenEnd.y, {
				thickness: 3,
				color: rayColor
			});
		}
	}

	public function getDirectionVecFromDir(dir:String):FlxPoint
	{
		switch (dir)
		{
			case "u":
				return new FlxPoint(0, -1);
			case "d":
				return new FlxPoint(0, 1);
			case "l":
				return new FlxPoint(-1, 0);
			case "r":
				return new FlxPoint(1, 0);
			default:
				return new FlxPoint(0, 0);
		}
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

	private function updateCamera()
	{
		camera.follow(this);
	}

	public function attachCamera(camera:Camera)
	{
		attachedCamera = camera;
	}

	public function dettachCamera()
	{
		attachedCamera = null;
	}
}