package engine.backend.display;

import lime.app.Application;
import openfl.text.TextField;
import openfl.text.TextFormat;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class BuildDisplay extends TextField {
    public var currentFPS(default, null):Int = 0;
    public var currentRAM(default, null):Float = 0;
    public var peakRAM(default, null):Float = 0;

    private var frameTimes:Array<Float> = [];
    private var elapsed:Float = 0;
    private var cacheCount:Int = 0;

    public function new(x:Float = 10, y:Float = 10, color:Int = 0xFFFFFF) {
        super();

        this.x = x;
        this.y = y;
        width = 400;
        height = 60;
        selectable = false;
        mouseEnabled = false;
        defaultTextFormat = new TextFormat(Global.DEFAULT_FONT, 12, color);
        text = "";
        autoSize = LEFT;
		multiline = true;
    }

    private override function __enterFrame(deltaTime:Float):Void 
    {
		var output = Application.current.meta.get('name') + "\nBUILD:\nID: " + Constants.getBuildID();

        text = output;
    }

}
