import flixel.FlxCamera;
import flixel.text.FlxTextBorderStyle;

var option:Int = 0;
var allowControl:Bool = false;
var firstOpened:Bool = true;

function create(){
    camFailed = new FlxCamera();
    camFailed.bgColor = 0;
    FlxG.cameras.add(camFailed, false);

    failedScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    failedScreen.setGraphicSize(Std.int(failedScreen.width * 10));

    failedTxt = new FlxText(0, 20, FlxG.width, "Uh oh! An error has occured!");
    failedTxt.screenCenter();
    failedTxt.y -= 100;
	failedTxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    failedFlavorTxt = new FlxText(0, 20, FlxG.width, "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again\nTurn off Streaming Mode");
    failedFlavorTxt.screenCenter();
	failedFlavorTxt.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    for(i in [failedScreen, failedTxt, failedFlavorTxt]){
        i.alpha = 0;
        i.camera = camFailed;
        add(i);
    }
    FlxTween.tween(failedScreen, {alpha: 0.5}, 1);
    FlxTween.tween(failedTxt, {alpha: 1}, 1);

    optionsSelectorTimer = new FlxTimer().start(2, function(tmr:FlxTimer){
        FlxTween.tween(failedFlavorTxt, {alpha: 1}, 1);
    });
    optionsSelectorTimer2 = new FlxTimer().start(3, function(tmr:FlxTimer){
        allowControl = true;
    });
}

function update(){
    if(allowControl){
        if(controls.UP_P){
            failedFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again <\nTurn off Streaming Mode";
            option = 0;
            firstOpened = false;
        }
        if(controls.DOWN_P){
            failedFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again \nTurn off Streaming Mode <";
            option = 1;
            firstOpened = false;
        }
        if(firstOpened){
            failedFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again <\nTurn off Streaming Mode";
        }
        if(controls.ACCEPT){
            if(option == 1) FlxG.save.data.streamableMusic = false;
            FlxG.resetState();
        }
    }
}