package engine;

import engine.backend.macro.CustomMacros;

class Global
{
	public static var DEFAULT_FONT:String = "";
	public static var DEBUG_MODE:Bool =
		#if debug
		true;
		#else
		false;
		#end
}