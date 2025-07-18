package engine;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.Json;
import sys.FileSystem;

typedef EventDef = {
    var frame:Int;
    var type:String;
    var args:Array<String>;
}

typedef AnimationEntry = 
{
    var name:Null<String>;
    var prefix:Null<String>;
    var postfix:Null<String>;
    var x:Null<Float>;
    var y:Null<Float>;
    var indices:Null<Array<Int>>;
    var framerate:Null<Int>;
    var loop:Null<Bool>;
    var flipX:Null<Bool>;
    var flipY:Null<Bool>;
    var events:Null<Array<EventDef>>;
}

typedef SpriteDefinition = {
    var animations:Array<AnimationEntry>;
    var animFormat:String;
    var img:String;
}

class Sprite extends FlxSprite {
    public var animOffsets:Map<String, FlxPoint> = new Map<String, FlxPoint>();
    public var spriteDef:SpriteDefinition;

    override public function new(X:Float = 0, Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset) {
        super(X, Y, SimpleGraphic);

        animation.onFrameChange.add(onFrameChange);
    }

    public function loadSprite(path:String) {
		if (!FileSystem.exists(path))
        {
            FlxG.log.error("Sprite definition not found at: " + path);
            return;
        }
		var jsonData:String = FlxG.assets.getText(path);
        spriteDef = Json.parse(jsonData);

        switch (spriteDef.animFormat)
        {
            case "Sparrow":
				frames = FlxAtlasFrames.fromSparrow(Resources.image("images/sprites/mainchar/" + spriteDef.img),
					FlxG.assets.getText(Resources.xml("images/sprites/mainchar/" + spriteDef.img)));
            case "Aseprite":
				frames = FlxAtlasFrames.fromTexturePackerJson(Resources.image("images/sprites/mainchar/" + spriteDef.img),
					FlxG.assets.getText(Resources.json("images/sprites/mainchar/" + spriteDef.img)), false); // no support for durations YET
            case "TexturePackerJson":
				frames = FlxAtlasFrames.fromTexturePackerJson(Resources.image("images/sprites/mainchar/" + spriteDef.img),
					FlxG.assets.getText(Resources.json("images/sprites/mainchar/" + spriteDef.img)), true);
            case "TexturePackerXML":
				frames = FlxAtlasFrames.fromTexturePackerXml(Resources.image("images/sprites/mainchar/" + spriteDef.img),
					FlxG.assets.getText(Resources.xml("images/sprites/mainchar/" + spriteDef.img)));
        }

        for (anim in spriteDef.animations)
        {
            var prefix:String = anim.prefix ?? "";
            var postfix:String = anim.postfix ?? "";
            var xOffset:Float = anim.x ?? 0.0;
            var yOffset:Float= anim.y ?? 0.0;
            var indices:Array<Int> = anim.indices  ?? [];
            var fps:Int = anim.framerate ?? 30;
            var loop:Bool = anim.loop ?? true;
            var flipX:Bool = anim.flipX ?? false;
            var flipY:Bool = anim.flipY ?? false;
            animOffsets.set(anim.name, new FlxPoint(xOffset, yOffset));
            animation.add(anim.name, indices, fps, loop, flipX, flipY);
        }
        for (i in 0...frames.frames.length) {
            trace('Index $i → ${frames.frames[i].name}');
        }
    }

    override function updateAnimation(elapsed:Float) {
        super.updateAnimation(elapsed);
        if (animation.curAnim != null && animOffsets.exists(animation.curAnim.name))
        {
            offset.copyFrom(animOffsets[animation.curAnim.name]);
        }

    }

    private function handleEvent(event:EventDef) {
        
    }

    private function onFrameChange(animName:String, frameNumber:Int, frameIndex:Int) 
    {
        if (spriteDef == null || spriteDef.animations == null)
            return;
        for (anim in spriteDef.animations)
        {
            if (anim.name == animName)
            {
                if (anim.events == null)
                    continue;
                for (event in anim.events)
                {
                    if (event.frame == frameNumber)
                    {
                        handleEvent(event);
                    }
                }
            }
        }
    }
}