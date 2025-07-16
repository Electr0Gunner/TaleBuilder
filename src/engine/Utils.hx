package engine;

class Utils
{
    public static inline function metersToPixels(m:Float):Float {
        return m * Constants.METER_PIXEL_RATIO;
    }
    public static inline function pixelsToMeters(p:Float):Float {
        return p / Constants.METER_PIXEL_RATIO;
    }
}