package engine.backend.display;

import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FramerateDisplay extends TextField {
    public var currentFPS(default, null):Int = 0;

    private var frameTimes:Array<Float> = [];
    private var elapsed:Float = 0;
    private var cacheCount:Int = 0;

    public function new(x:Float = 0, y:Float = 0, color:Int = 0xFFFFFF) {
        super();

        this.x = x;
        this.y = y;
        width = 400;
        height = 60;
        selectable = false;
        mouseEnabled = false;
        defaultTextFormat = new TextFormat(Global.DEFAULT_FONT, 12, color);
        text = "FPS: 0";
        autoSize = LEFT;
		multiline = true;

    }

    private override function __enterFrame(deltaTime:Float):Void {
        elapsed += deltaTime;
        frameTimes.push(elapsed);

        // Trim frames older than 1 second
        while (frameTimes.length > 0 && frameTimes[0] < elapsed - 1000) {
            frameTimes.shift();
        }

        var currentCount = frameTimes.length;
        currentFPS = Math.round((currentCount + cacheCount) / 2);

        // Update only if changed
        if (currentCount != cacheCount) {
            var output = "FPS: " + currentFPS;

            #if (gl_stats && !disable_cffi && (!html5 || !canvas))
            output += "\nDrawCalls:";
            output += "\n  Total: " + Context3DStats.totalDrawCalls();
            output += "\n  Stage: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
            output += "\n  Stage3D: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
            #end

            text = output;
        }

        cacheCount = currentCount;
    }
}
