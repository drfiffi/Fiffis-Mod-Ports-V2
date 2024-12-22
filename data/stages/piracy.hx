import flixel.addons.display.FlxBackdrop;

var rate = 20;

import flixel.camera.FlxCameraFollowStyle;
import openfl.geom.Rectangle;

import flixel.util.FlxSpriteUtil;
public var lastPosition = new FlxPoint(9999, 9999);

var dadPosition = [0, 0];

var timeAmmount:Float = 0.35;
var lockOnSpeed:Float = 0.075;

var returnTimer = new FlxTimer();

var allowReturn:Bool = false;


function create(){
    camEst = new FlxCamera(0, 0, 1280, 1280, 0.93);
    FlxG.cameras.remove(camHUD, false);
    FlxG.cameras.add(camEst);
    FlxG.cameras.add(camHUD, false);
    dad.setPosition(-70, 250);

    if(Options.downscroll){
        camHUD.y = -239;
    }

    remove(boyfriend);

    bgH0 = new FlxSprite(0, 360.5).loadGraphic(Paths.image('stages/piracy/HallyBG2'));
    insert(0, bgH0);

    bgH1 = new FlxBackdrop(Paths.image('stages/piracy/HallyBG4'), FlxAxes.Y);
	bgH1.x = 240;
	bgH1.velocity.set(0, 40);
	add(bgH1);

    bgH3 = new FlxSprite(240, 360.5).loadGraphic(Paths.image('stages/piracy/HallyBG3'));
    bgH3.alpha = 0.8;
    add(bgH3);

    add(boyfriend);
    boyfriend.camera = camEst;
    boyfriend.setPosition(278, -10);

    defaultCamZoom = 0.6;

    bgH4 = new FlxSprite(0, 360.5).loadGraphic(Paths.image('stages/piracy/HallyBG1'));
    add(bgH4);

    bgbottom = new FlxBackdrop(Paths.image('stages/piracy/bgbottom'), FlxAxes.X);
    bgbottom.velocity.set(40, 0);
    bgbottom.scrollFactor.set(0, 0);
    bgbottom.setGraphicSize(Std.int(bgbottom.width * 2.5));
    bgbottom.updateHitbox();
    bgbottom.x = 600;
    bgbottom.y = Options.downscroll ? 360 : -120;
    bgbottom.antialiasing = false;
    bgbottom.camera = camEst;
    add(bgbottom);

    lifebar = new FlxSprite(11, 290).loadGraphic(Paths.image('stages/piracy/bar')); //BGSprite('stages/piracy/bar', -263, 400, 0, 0);
	lifebar.setGraphicSize(lifebar.width * 1.75);
	lifebar.updateHitbox();
	lifebar.antialiasing = false;
	lifebar.camera = camHUD;
	add(lifebar);

    backing = new FlxSprite(7, 7).loadGraphic(Paths.image('stages/piracy/paper'));
    backing.setGraphicSize(Std.int(backing.width * 1.9));
    backing.updateHitbox();
    backing.antialiasing = false;
    backing.cameras = [camEst];
    add(backing);

    thetext = new FlxText(backing.x + 30, backing.y + 40, 416, "sorry", 95);
    thetext.setFormat(Paths.font("arial-rounded-mt-bold.ttf"), 95, 0xBA888888, 'center');
    thetext.cameras = [camEst];
    add(thetext);
    thetext.y = backing.y + 30;

    canvas = new FlxSprite(backing.x, backing.y).makeGraphic(Std.int(backing.width), Std.int(backing.height), 0x00000000, true);
    canvas.cameras = [camHUD];
    canvas.updateHitbox();
    canvas.visible = false;
    add(canvas);

    writeText = new FlxText(30, 500, 416, "00", 16);
    writeText.cameras = [camEst];
    writeText.color = FlxColor.BLACK;
    writeText.setFormat(Paths.font("BIOSNormal.ttf"), 28, FlxColor.BLACK, 'center');
    writeText.visible = false;
    writeText.y = backing.y - 680;
    add(writeText);

    for(i in [bgH0, bgH1, bgH3, bgH4]){
        i.scale.set(1.3, 1.3);
	    i.updateHitbox();
	    i.scrollFactor.set(0, 0);
        i.antialiasing = false;
    }
}

function postCreate(){
    for(i in [iconP1, iconP2, healthBar, healthBarBG, scoreTxt, missesTxt, accuracyTxt])
            remove(i);

    dadPosition[0] = dad.getCameraPosition().x;
    dadPosition[1] = dad.getCameraPosition().y;
    camFollow.camera = camEst;
}

function onDadHit(e) {
        if(allowReturn) allowReturn = false;
        if(returnTimer != null) returnTimer.cancel();
        returnTimer = new FlxTimer().start(timeAmmount, function(timer){
            allowReturn = true;
        });

        moveCameraOnNotes(dad, e.direction, dadPosition, rate);
}

function update(){
    if (FlxG.mouse.pressed){
        FlxSpriteUtil.drawCircle(canvas, FlxG.mouse.x - canvas.x, FlxG.mouse.y - canvas.x, 5, 0xFF0000FF);
        if (lastPosition.x != 9999 && lastPosition.y != 9999 && FlxG.mouse.justMoved){
            var tanSlope:Float = (-(FlxG.mouse.y - lastPosition.y)) / (FlxG.mouse.x - lastPosition.x);
            var secSlope:Float = -(1 / tanSlope);
            var angle:Float = Math.atan(secSlope);
            var circlePos:FlxPoint = new FlxPoint(5 * Math.cos(angle), 5 * Math.sin(angle));
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


function moveCameraOnNotes(character, noteDirection, createdPosition, rates) {
      switch (noteDirection) {
            case 0:
                  camFollow.setPosition(character.getCameraPosition().x - rates, createdPosition[1]);
            case 1:
                  camFollow.setPosition(createdPosition[0], character.getCameraPosition().y + rates);
            case 2:
                 camFollow.setPosition(createdPosition[0], character.getCameraPosition().y - rates);
            case 3:
                  camFollow.setPosition(character.getCameraPosition().x + rates, createdPosition[1]);

      }
}

function beatHit(){
    if(curBeat == 0){
        FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, lockOnSpeed);
    }
    if(curBeat % 2 == 0 && allowReturn){
            camFollow.setPosition(dad.getCameraPosition().x, dad.getCameraPosition().y);
            allowReturn = false;
    }
}

function onCameraMove(e){
      e.cancel();
}