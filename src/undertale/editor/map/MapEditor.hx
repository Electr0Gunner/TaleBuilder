package undertale.editor.map;

import engine.Camera;
import engine.Scene;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.tweens.FlxTween;
import haxe.ui.RuntimeComponentBuilder;
import haxe.ui.components.Button;
import haxe.ui.components.TextField;
import haxe.ui.containers.dialogs.Dialog;
import haxe.ui.containers.menus.MenuItem;
import haxe.ui.core.Component;
import lime.utils.Assets;
import undertale.system.overworld.Overworld.Layer;
import undertale.system.overworld.Overworld.Tile;
import undertale.system.overworld.Overworld;
import undertale.system.overworld.Room;

enum MapTool {
    TOOL_BRUSH;
    TOOL_SELECT;
    TOOL_DELETE;
}

class MapEditor extends Scene {

    var room:Room;

    var currentLayer:Int = 0;

    var selectedTile:Tile;

    var tileIndicator:FlxSprite;

    var gameCamera:Camera;
    var ui_cam:Camera;
    var _ui:Component;
    var _newMapDialog:Dialog;
    var _openmapDialog:Dialog;

    var mapWidth:Int = 50;
    var mapHeight:Int = 50;

    var currentTool:MapTool = TOOL_BRUSH;

    override function create() {
        gameCamera = new Camera(0, 0, 2.0);
        ui_cam = new Camera();
        FlxG.cameras.reset(gameCamera);
        FlxG.cameras.add(ui_cam, false);
        ui_cam.bgColor.alpha = 0;

        super.create();

        var grid:FlxSprite = FlxGridOverlay.create(20, 20, -1, -1, true, 0xFF444444, 0xFF5E5E5E);
        grid.z = -1;
        add(grid);

        var editorPath = Resources.xml("MapEditor", "editor/map");
        _ui = RuntimeComponentBuilder.fromString(Assets.getText(editorPath));
        _ui.cameras = [ui_cam];
        _ui.z = 100;
        add(_ui);

        tileIndicator = new FlxSprite(0,0);
        tileIndicator.z = 99; //Above everything;
        tileIndicator.makeGraphic(Overworld.TILE_SIZE, Overworld.TILE_SIZE, 0xFFFFFFFF);
        tileIndicator.alpha = 0;
        FlxTween.tween(tileIndicator, {"alpha": 1}, 1, {
            onComplete: indicatorTweenDissappear
        });
        add(tileIndicator);


        var newMapItem = _ui.findComponent("ID_NEWMAP", MenuItem);
        newMapItem.onClick = onNewMapClick;

        var openMapItem = _ui.findComponent("ID_OPENMAP", MenuItem);
        openMapItem.onClick = onOpenMapClick;

        var paintBttn = _ui.findComponent("ID_PAINTTOOL", Button);
        paintBttn.onClick = onPaintToolClick;

        var eraseBttn = _ui.findComponent("ID_ERASETOOL", Button);
        eraseBttn.onClick = onEraseToolClick;

        var selectBttn = _ui.findComponent("ID_SELECTTOOL", Button);
        selectBttn.onClick = onSelectToolClick;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        var mousePos = FlxG.mouse.getPosition();

        var xT:Int = Math.round(mousePos.x / Overworld.TILE_SIZE);
        var yT:Int = Math.round(mousePos.y / Overworld.TILE_SIZE);

        tileIndicator.x = xT * Overworld.TILE_SIZE;
        tileIndicator.y = yT * Overworld.TILE_SIZE;

        if (room == null)
            return;
        room.update(elapsed);

        if (FlxG.mouse.justReleased)
        {
            switch (currentTool)
            {
                case TOOL_BRUSH:
                    paintTile(xT, yT);
                case TOOL_SELECT:
                    selectTile(xT, yT);
                case TOOL_DELETE:
                    deleteTile(xT, yT);
            }
        }
    }

    function paintTile(tileX:Int, tileY:Int) {
        room.layers[currentLayer].tiles[tileX][tileY] = {x:tileX, y: tileY, img: "data/editor/map/temp_tile.png"}; //temp
    }

    function selectTile(tileX:Int, tileY:Int) {
        
    }

    function deleteTile(tileX:Int, tileY:Int) {
        room.layers[currentLayer].tiles[tileX][tileY] = null;
    }


    public function createMap(name:String) {
        room = new Room();
        clearGrid();
    }

    public function clearGrid() {
        tileIndicator.visible = true;
            var tiles = [];
        for (x in 0...mapWidth) {
            var column = [];
            for (y in 0...mapHeight) {
                column.push(null);
            }
            tiles.push(column);
        }

        room.layers = [{
            tiles: tiles,
            decals: []
        }];
    }
    

    override function draw() {
        super.draw();
        if (room != null)
            room.draw();
    }


    //////////////////////////
    ///    UI FUNCTION     ///
    //////////////////////////

    function indicatorTweenAppear(tween:FlxTween) 
    {
        FlxTween.tween(tileIndicator, {"alpha": 1}, 1, {
            onComplete: indicatorTweenDissappear
        });
    }


    function indicatorTweenDissappear(tween:FlxTween) {
                FlxTween.tween(tileIndicator, {"alpha": 0}, 1, {
            onComplete: indicatorTweenAppear
        });
    }

    public function onSelectToolClick(e:haxe.ui.events.MouseEvent) {
        currentTool = TOOL_SELECT;
    }
    public function onPaintToolClick(e:haxe.ui.events.MouseEvent) {
        currentTool = TOOL_BRUSH;
    }
    public function onEraseToolClick(e:haxe.ui.events.MouseEvent) {
        currentTool = TOOL_DELETE;
    }

    public function onNewMapClick(e:haxe.ui.events.MouseEvent):Void {
        tileIndicator.visible = false;
        var dialogPath = Resources.xml("NewMapDialog", "editor/map");
        _newMapDialog = cast(RuntimeComponentBuilder.fromString(Assets.getText(dialogPath)), Dialog);
        _newMapDialog.show();
        
        var createBttn = _newMapDialog.findComponent("ID_CREATEMAP", Button);
        createBttn.onClick = onCreateClick;

        var cancelBttn = _newMapDialog.findComponent("ID_CANCELMAP", Button);
        cancelBttn.onClick = onCancelClick;
    }

    public function onOpenMapClick(e:haxe.ui.events.MouseEvent):Void {
        tileIndicator.visible = false;
        var dialogPath = Resources.xml("OpenMapDialog", "editor/map");
        _openmapDialog = cast(RuntimeComponentBuilder.fromString(Assets.getText(dialogPath)), Dialog);
        _openmapDialog.show();
    }

    public function onCreateClick(e:haxe.ui.events.MouseEvent) {

        var roomField = _newMapDialog.findComponent("ID_ROOMNAME", TextField);

        createMap(roomField.text);

        _newMapDialog.hide();
    }


    public function onCancelClick(e:haxe.ui.events.MouseEvent) {
        _newMapDialog.hide();
        tileIndicator.visible = true;
    }

}