package engine.backend.display;

import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class MemoryDisplay extends TextField {
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
        text = "Memory Usage: UNKNOWN";
        autoSize = LEFT;
		multiline = true;
    }

    private override function __enterFrame(deltaTime:Float):Void 
    {
        currentRAM = System.totalMemory;
        if (currentRAM > peakRAM) peakRAM = currentRAM;

        var output = "Memory Usage: " + getSizeString(currentRAM);
        output += " (Peak: " + getSizeString(peakRAM) + ")";

        text = output;
    }

    public static function getSizeString(size:Float):String {
		var labels = ["B", "KB", "MB", "GB", "TB"];
		var rSize:Float = size;
		var label:Int = 0;
		while(rSize > 1024 && label < labels.length-1) {
			label++;
			rSize /= 1024;
		}
		return '${Std.int(rSize) + "." + addZeros(Std.string(Std.int((rSize % 1) * 100)), 2)}${labels[label]}';
	}

	public static inline function addZeros(str:String, num:Int) {
		while(str.length < num) str = '0${str}';
		return str;
	}

}
