package engine;

import flixel.text.FlxText;

class Text extends FlxText {
    override public function new(X:Float, Y:Float, text:String = "", size:Int = 8, fieldWidth:Int = 0) {
        super(X, Y, fieldWidth, text, size);
    }
}