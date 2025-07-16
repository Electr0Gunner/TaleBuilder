package engine.backend.display;

import flixel.FlxG;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;

class InfoDisplay extends Sprite {
    public var fps_label:FramerateDisplay;
    public var memory_label:MemoryDisplay;
	public var build_label:BuildDisplay;
    public var backdrop:Bitmap;

    @:isVar public static var __bitmap(get, null):BitmapData = null;

    private static function get___bitmap():BitmapData {
		if (__bitmap == null)
			__bitmap = new BitmapData(1, 1, 0xFF000000);
		return __bitmap;
	}
    
	public function new() {
		super();

        x = 5;
        y = 2;
		alpha = 0.0;

		if (__bitmap == null)
			__bitmap = new BitmapData(1, 1, 0xFF000000);

		backdrop = new Bitmap(__bitmap);
		backdrop.alpha = 0.5;
		addChild(backdrop);

        fps_label = new FramerateDisplay(10, 10);
		addChild(fps_label);

		memory_label = new MemoryDisplay(10, fps_label.y + fps_label.height + 5);
		addChild(memory_label);

		build_label = new BuildDisplay(10, memory_label.y + memory_label.height + 5);
		addChild(build_label);
        
		FlxG.stage.addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent) {
			if (e.keyCode == openfl.ui.Keyboard.F3) {
				alpha = alpha == 1.0 ? 0.0 : 1.0;
			}
		});
	}

	public override function __enterFrame(t:Int) {
		if (alpha <= 0.05) return;
		super.__enterFrame(t);

		var w:Float = 0.0;
		var h:Float = 0.0;

		for (child in [fps_label, memory_label, build_label])
		{
			var correct_width = child.x + child.width;
			var correct_height = child.y + child.height;

			if (w < correct_width)
				w = correct_width;
			if (h < correct_height)
				h = correct_height;
		}

		backdrop.x = x;
		backdrop.y = y;
		backdrop.width = w;
		backdrop.height = h;
	}
}