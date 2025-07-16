package engine.backend.macro;

import haxe.macro.Context;
import haxe.macro.Expr;

class CustomMacros
{
  public static macro function addZToFlxObject():Array<Field>
  {
    var pos:Position = Context.currentPos();
    var fields:Array<Field> = Context.getBuildFields();

    fields = fields.concat([
      {
        name: "z",
        access: [Access.APublic], 
        kind: FieldType.FVar(macro :Int, macro $v{0}),
        pos: pos,
      }
    ]);

    return fields;
  }

  //Generates a build ID based on the date (year month day hour minute second)
  public static macro function generateBuildID():ExprOf<String>
  {
    var date = Date.now();
    var id =  
    Std.string(date.getFullYear()) + "." +
    Std.string(date.getMonth() + 1) + "." +
    Std.string(date.getDate()) + "." +
    Std.string(date.getHours()) + "." +
    Std.string(date.getMinutes()) + "." +
    Std.string(date.getSeconds());

    return macro $v{id};
  }

  public static macro function getBuildDate():ExprOf<Date> {
    var date = Date.now();
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDay() + 1;
    var hour = date.getHours();
    var minute = date.getMinutes();
    var second = date.getSeconds();

    return macro new Date(year, month, day, hour, minute, second);
  }

}
