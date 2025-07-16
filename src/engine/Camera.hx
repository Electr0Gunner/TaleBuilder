package engine;

import flixel.FlxCamera;

class Camera extends FlxCamera {
    override public function new(x = 0.0, y = 0.0, zoom = 0.0, width = 0, height = 0) {
        super(x, y, width, height, zoom);
    }
}