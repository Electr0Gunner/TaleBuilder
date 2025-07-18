package undertale;

import engine.Camera;
import engine.GameObject;
import engine.PhysicsWorld;
import engine.Resources;
import engine.Scene;
import engine.Text;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import undertale.editor.map.MapEditor;
import undertale.object.Entity;
import undertale.object.Player;

class TestState extends Scene {

    var cam:Camera;
    var player:Player;
    var test_wall:GameObject;
    var ui_cam:Camera;

    override public function create() {
        super.create();
        sortMode |= SortFlags.ByY;

        PhysicsWorld.init();

        cam = new Camera(0, 0, 2.0);
        ui_cam = new Camera();
        FlxG.cameras.reset(cam);
        FlxG.cameras.add(ui_cam, false);
        ui_cam.bgColor.alpha = 0;

		var grid:FlxSprite = FlxGridOverlay.create(20, 20, 80, 80, true, 0xFF444444, 0xFF5E5E5E);

		var tileGrid:FlxBackdrop = new FlxBackdrop(grid.graphic);
		tileGrid.z = -1;
		add(tileGrid);

        var test_box1 = new FlxSprite(70, 70);
        test_box1.makeGraphic(16, 16, FlxColor.RED);
        add(test_box1);

        var test_box2 = new FlxSprite(70, 90);
        test_box2.makeGraphic(16, 16, FlxColor.RED);
        test_box2.z = 2;
        add(test_box2);

        var test_box4 = new FlxSprite(70, 110);
        test_box4.makeGraphic(16, 16, FlxColor.RED);
        test_box4.z = 1;
        add(test_box4);

        var text:Text = new Text(100, 100, "TESTING", 12);
        text.z = 99;
        text.camera = ui_cam;
		text.font = Resources.font("fonts/DTM-Sans");
        add(text);

        var mapButton:FlxButton = new FlxButton(400, 300, "Map Editor", function name() {
            FlxG.switchState(MapEditor.new);
        });
        mapButton.camera = ui_cam;
        add(mapButton);

		player = new Player();
		player.attachCamera(cam);
		player.z = 1;
        add(player);
        
		test_wall = new Entity(100, 0, "wall");
        test_wall.makeGraphic(300, 20);
        test_wall.createRectangleBody(300, 20, STATIC_BODY);
        add(test_wall);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}