package engine;

import engine.backend.macro.CustomMacros;

class Global
{
    public static var DEFAULT_FONT:String = "";
    public static final BUILD_ID:String = CustomMacros.generateBuildID();

    public static function getBuildID():String
    {
        return BUILD_ID;
    }
}