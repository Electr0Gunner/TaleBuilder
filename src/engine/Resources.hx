package engine;

import flixel.FlxG;
import sys.FileSystem;

class Resources {
	public static var BASE_FOLDER = "base";
	public static var DATA_FOLDER = "data";

	public static var CURRENT_FOLDER = "data";
	public static var CURRENT_GAME = "";
    public static inline var DEFAULT_KEY:String = "_default";

	public static function txt(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		return getPath('$key.txt', game, library);
    }      
    
	public static function xml(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		return getPath('$key.xml', game, library);
    }
  
	public static function json(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		return getPath('$key.json', game, library);
    }

	public static function file(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
	{
		return getPath('$key', game, library);
	}

	public static function audioRandom(key:String, min:Int, max:Int, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		var randIndex = FlxG.random.int(min, max);
		return audio(key + randIndex, library);
    }
  
	public static function audio(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		return getPath('$key.ogg', game, library);
    }

	public static function image(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		return getPath('$key.png', game, library);
    }
  
	public static function font(key:String, library:String = DEFAULT_KEY, game:String = DEFAULT_KEY):String
    {
		if (FileSystem.exists(getAbsolutePath(getPath('$key.otf', game, library)))) // Check for OpenType Font first
			return getPath('$key.otf', game, library);

		return getPath('$key.ttf', game, library); // fallback on TrueType Font
    }

	static function getPath(file:String, game:String, library:String):String
    {
		var lib:String = library == DEFAULT_KEY ? CURRENT_FOLDER : library;
		var gameFolder = game == DEFAULT_KEY ? CURRENT_GAME : game;

		// Try to find it in the data folder/aka mods/games
		var gamePath = '$DATA_FOLDER/$gameFolder/$file';
		if (FileSystem.exists(getAbsolutePath(gamePath)))
			return gamePath;

		// Try to find it in the base/engine folder
		var engineRoot = '$BASE_FOLDER/$file';
		if (FileSystem.exists(getAbsolutePath(engineRoot)))
			return engineRoot;

		// return
		return '$lib/$file';
    }

	public static function getAbsolutePath(path:String)
	{
		var absolute = FileSystem.absolutePath(path);
		return absolute;
    }
}