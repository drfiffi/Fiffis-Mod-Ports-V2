import flixel.FlxG;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxFrame;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;

import openfl.geom.Rectangle;

import flixel.util.FlxSpriteUtil;

public var backing:FlxSprite;
public var canvas:FlxSprite;
public var text:FlxText;
public var lastPosition = new FlxPoint(9999, 9999);

function create(){
    backing = new FlxSprite(200, 200).makeGraphic(600, 250, 0xFFFFFFFF, true);
    backing.updateHitbox();
    add(backing);

    text = new FlxText(200, 269, 600, "snooPINGAS", 95);
    text.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xDD888888, 'center');
    add(text);
    text.y = 250 + 125 - text.pixels.rect.height / 2;

    canvas = new FlxSprite(200, 200).makeGraphic(600, 250, 0x00000000, true);
    canvas.updateHitbox();
    add(canvas);

    FlxG.mouse.visible = true;
}

function update(elapsed){
    if (controls.BACK){
        FlxG.sound.play(Paths.sound('cancelMenu'));
        FlxG.switchState(new MainMenuState());
    }

    if (FlxG.mouse.pressed){
        FlxSpriteUtil.drawCircle(canvas, FlxG.mouse.x - canvas.x, FlxG.mouse.y - canvas.x, 5, 0xFF0000FF);
        if (lastPosition.x != 9999 && lastPosition.y != 9999 && FlxG.mouse.justMoved){
            var tanSlope:Float = (-(FlxG.mouse.y - lastPosition.y)) / (FlxG.mouse.x - lastPosition.x);
            var secSlope:Float = -(1 / tanSlope);
            var angle:Float = Math.atan(secSlope);
            var circlePos:FlxPoint = new FlxPoint(5 * Math.cos(angle), 5 * Math.sin(angle));
            /*var vertices:Array<FlxPoint> = [];
            vertices[0] = new FlxPoint(FlxG.mouse.x - canvas.x + circlePos.x, FlxG.mouse.y - canvas.y - circlePos.y);
            vertices[1] = new FlxPoint(lastPosition.x - canvas.x + circlePos.x, lastPosition.y - canvas.y - circlePos.y);
            vertices[2] = new FlxPoint(lastPosition.x - canvas.x - circlePos.x, lastPosition.y - canvas.y + circlePos.y);
            vertices[3] = new FlxPoint(FlxG.mouse.x - canvas.x - circlePos.x, FlxG.mouse.y - canvas.y + circlePos.y);
            FlxSpriteUtil.drawPolygon(canvas, vertices, 0xFF0000FF);*/
        }
        lastPosition = new FlxPoint(FlxG.mouse.x, FlxG.mouse.y);
    }
    else if (FlxG.mouse.justReleased){
        lastPosition = new FlxPoint(9999, 9999);
    }
    else if (FlxG.keys.justPressed.R){
        FlxSpriteUtil.fill(canvas, FlxColor.TRANSPARENT);
    }
    else if (FlxG.keys.justPressed.Q){
        var stamp1:Float = Timer.stamp();
        var acc:Float = accuracy();
        var stamp2:Float = Timer.stamp();
        var time:Float = stamp2 - stamp1;
        trace('Accuracy: ' + acc);
        trace('Time to get: ' + time + ' seconds');
    }
}

function accuracy():Float {
    text.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 85, 0xFF888888, 'center');
    var whiteBad:Int = 0;
    var whiteTotal:Int = 0;
    var grayBad:Int = 0;
    var grayTotal:Int = 0;
    var bounds:flash.geom.Rectangle = text.pixels.rect;
    var bounds2:flash.geom.Rectangle = canvas.pixels.rect;
    for (y in 0...Std.int(bounds2.bottom)){
        for (x in 0...Std.int(bounds2.right)){
            var blue:Bool = false;
            var shouldBe:Bool = false;
            var color:Int = canvas.pixels.getPixel32(x, y);
            if (color == -16776961)
                blue = true;
            
            var convertedX:Int = x - Std.int(text.x - canvas.x);
            var convertedY:Int = y - Std.int(text.y - canvas.y);
            if (bounds.contains(convertedX, convertedY)){
                var color2:Int = text.pixels.getPixel32(convertedX, convertedY);
                if (color2 == -7829368){
                    shouldBe = true;
                    grayTotal += 1;
                } else {
                    whiteTotal += 1;
                }
            } else {
                whiteTotal += 1;
            }
            if (blue && !shouldBe) {
                whiteBad += 1;
            } else if (!blue && shouldBe) {
                grayBad += 1;
            }
        }
    }
    text.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xDD888888, 'center');
    var accuracy:Float = (1 - (grayBad / grayTotal)) - (whiteBad / whiteTotal);
    if (accuracy < 0)
        return 0;
    else
        return accuracy * 100;
}
