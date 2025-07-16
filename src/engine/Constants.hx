package engine;

import engine.backend.macro.CustomMacros;

class Constants
{
	public static inline final METER_PIXEL_RATIO:Float = 30;
	public static final BUILD_ID:String = CustomMacros.generateBuildID();

	public static function getBuildID():String
	{
		return BUILD_ID;
	}
}