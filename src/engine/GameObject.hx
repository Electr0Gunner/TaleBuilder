package engine;

import box2D.collision.shapes.B2PolygonShape;
import box2D.common.B2Color;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2BodyType;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2FixtureDef;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.util.FlxDirectionFlags;
import openfl.display.Graphics;

class GameObject extends FlxSprite {
    public var body:B2Body;

    public var bodyDefinition:B2BodyDef;

    public var fixture:B2Fixture;

    public var tag:String = "";

    override public function new(X:Float = 0, Y:Float = 0) {
        super(X, Y);

    }

    public function createRectangleBody(Width:Float, Height:Float, type:B2BodyType = DYNAMIC_BODY) 
    {
        var halfWidthM = Utils.pixelsToMeters(Width) / 2;
        var halfHeightM = Utils.pixelsToMeters(Height) / 2;

        bodyDefinition = new B2BodyDef();
        bodyDefinition.position.set(Utils.pixelsToMeters(x) + halfWidthM, Utils.pixelsToMeters(y) + halfHeightM);
        bodyDefinition.type = type;
        bodyDefinition.fixedRotation = true;

        var rectangle = new B2PolygonShape();
        rectangle.setAsBox(halfWidthM, halfHeightM);

        var fixturedef = new B2FixtureDef();
        fixturedef.shape = rectangle;
        fixturedef.density = 1.0;
        fixturedef.friction = 0.3;
        fixturedef.restitution = 0.1;

        body = PhysicsWorld.world.createBody(bodyDefinition);
        fixture = body.createFixture(fixturedef);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        if (body != null)
        {
            body.setLinearVelocity(new B2Vec2(Utils.pixelsToMeters(velocity.x), Utils.pixelsToMeters(velocity.y)));
            updatePosition();
        }
    }

    override function destroy() {
        super.destroy();

        if (body != null)
        {
            body.DestroyFixture(fixture);
            PhysicsWorld.world.destroyBody(body);
        }
    }

    override function drawDebugBoundingBox(gfx:Graphics, rect:FlxRect, allowCollisions:FlxDirectionFlags, partial:Bool) {
        super.drawDebugBoundingBox(gfx, rect, allowCollisions, partial);
        PhysicsWorld.world.drawShape(fixture.getShape(), body.getTransform(), new B2Color(0, 0, 1));
    }

    public function updatePosition() 
    {
        var pos = body.getPosition();
        x = Utils.metersToPixels(pos.x) - width / 2;
        y = Utils.metersToPixels(pos.y) - height / 2;
    }
}