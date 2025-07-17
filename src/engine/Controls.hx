package engine;

import flixel.FlxG;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.keyboard.FlxKey;

class Controls
{
    public static var binds:Map<String, ControlBind> = new Map<String, ControlBind>();

    public static function registerBind(name:String, key:FlxKey) {
        var bind:ControlBind = new ControlBind(key);
        binds.set(name, bind);
    }

    public static function pressed(bind:String):Bool {
        if (!binds.exists(bind))
        {
            FlxG.log.error("Bind for " + bind + " was not found");
            return false;
        }
        return binds[bind].pressed();
    }

    public static function released(bind:String):Bool {
        if (!binds.exists(bind))
        {
            FlxG.log.error("Bind for " + bind + " was not found");
            return false;
        }
        return binds[bind].released();
    }

    public static function justPressed(bind:String):Bool {
        if (!binds.exists(bind))
        {
            FlxG.log.error("Bind for " + bind + " was not found");
            return false;
        }
        return binds[bind].justPressed();
    }

    public static function justReleased(bind:String):Bool {
        if (!binds.exists(bind))
        {
            FlxG.log.error("Bind for " + bind + " was not found");
            return false;
        }
        return binds[bind].justReleased();
    }
}

class ControlBind {
    public var key:FlxKey;

    public function new(Key:FlxKey) {
        key = Key;
    }

    public function pressed():Bool {
        return FlxG.keys.checkStatus(key, FlxInputState.PRESSED);
    }

    public function released():Bool {
        return FlxG.keys.checkStatus(key, FlxInputState.RELEASED);
    }

    public function justPressed():Bool {
        return FlxG.keys.checkStatus(key, FlxInputState.JUST_PRESSED);
    }

    public function justReleased():Bool {
        return FlxG.keys.checkStatus(key, FlxInputState.JUST_RELEASED);
    }
}