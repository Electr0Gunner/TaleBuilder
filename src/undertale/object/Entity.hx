package undertale.object;

import engine.GameObject;

class Entity extends GameObject {
    override public function new(X:Float, Y:Float, Tag:String = "") 
    {
        super(X, Y);
        tag = Tag;
    }

    public function onInteract() {
        trace(tag);
    }
}