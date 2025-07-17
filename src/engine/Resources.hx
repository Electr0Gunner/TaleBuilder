package engine;

import sys.FileSystem;

class Resources {

    public static var DEFAULT_LIBRARY = "game";
    public static inline var DEFAULT_KEY:String = "_default";

    public static function txt(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('$key.txt', library);
    }      
    
    public static function xml(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('$key.xml', library);
    }
  
    public static function json(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('$key.json', library);
    }

	public static function file(key:String, library:String = DEFAULT_KEY):String
	{
		return getPath('$key', library);
	}
  
    public static function sound(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('sounds/$key.ogg', library);
    }
  
    public static function soundRandom(key:String, min:Int, max:Int, library:String = DEFAULT_KEY):String
    {
        return sound(key + 0, library);
    }
  
    public static function music(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('music/$key.ogg', library);
    }
  
    public static function videos(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('videos/$key.png', library);
    }
  
    public static function image(key:String, library:String = DEFAULT_KEY):String
    {
        return getPath('images/$key.png', library);
    }
  
    public static function font(key:String, library:String = DEFAULT_KEY):String
    {
        if (FileSystem.exists(FileSystem.absolutePath(getPath('fonts/$key.otf', library)))) //Check for OpenType Font first
            return getPath('fonts/$key.otf', library);

        return getPath('fonts/$key.ttf', library); //fallback on TrueType Font
    }

    static function getPath(file:String, library:String):String
    {
        var lib:String = library;
        if (library == DEFAULT_KEY)
            lib = DEFAULT_LIBRARY;

        return 'data/$lib/$file';
    }
}