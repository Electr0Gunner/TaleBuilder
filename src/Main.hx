package;

import engine.Resources;
import flixel.FlxG;
import flixel.FlxGame;
import haxe.ui.Toolkit;
import haxe.ui.backend.flixel.CursorHelper;
import openfl.display.Sprite;

class Main extends Sprite
{
	public static var infoDisplay:engine.backend.display.InfoDisplay;
	public static var debugSprite:Sprite;

	public function new()
	{
		super();
		
		engine.Global.DEFAULT_FONT = "Determination Sans";
		Toolkit.init(); //Haxe UI
		Toolkit.theme = 'dark';
		CursorHelper.useCustomCursors = false;
		Resources.DEFAULT_LIBRARY = "undertale";
		debugSprite = new Sprite();
		debugSprite.alpha = 0.0;
		debugSprite.mouseEnabled = false;
		addChild(new FlxGame(0, 0, undertale.TestState));
		FlxG.autoPause = false;
		addChild(debugSprite);

		addChild(infoDisplay = new engine.backend.display.InfoDisplay());
	}
}
