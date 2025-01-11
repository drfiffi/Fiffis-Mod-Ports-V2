import flixel.text.FlxTextBorderStyle;
import funkin.game.PlayState;

var option:Int = 0;
var allowControl:Bool = false;
var firstOpened:Bool = true;

var startedCountdown:Bool = false;
var game:PlayState = PlayState.instance;
var offlineChecker:FlxTimer;
var useFailedSettings:Bool = false;

function create(){
    camLoader = new FlxCamera();
    camLoader.bgColor = 0;
    FlxG.cameras.add(camLoader, false);

    loadingScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    loadingScreen.setGraphicSize(Std.int(loadingScreen.width * 10));
    add(loadingScreen);

    loadingTxt = new FlxText(0, 20, FlxG.width, "Song Loading...");
    loadingTxt.screenCenter();
    loadingTxt.y -= 100;
	loadingTxt.setFormat(Paths.font("vcr.ttf"), 50, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	add(loadingTxt);

    loadingFlavorTxt = new FlxText(0, 20, FlxG.width, "Please wait...");
    loadingFlavorTxt.screenCenter();
	loadingFlavorTxt.setFormat(Paths.font("vcr.ttf"), 30, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

    for(i in [loadingScreen, loadingTxt, loadingFlavorTxt]){
        i.camera = camLoader;
        add(i);
    }

    offlineChecker = new FlxTimer().start(60, (tmr:FlxTimer) -> {
        if(!startedCountdown){
            for(i in [loadingTxt, loadingFlavorTxt]){
                FlxTween.tween(i, {alpha: 0}, 1.5, {onComplete: function(){
                    useFailedSettings = true;
                    loadingTxt.text = "Uh oh! An error has occured!";
                    loadingFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again\nTurn off Streaming Mode";
                    FlxTween.tween(i, {alpha: 1}, 1.5, {onComplete: function(){
                        allowControl = true;
                    }});
                }});
            }
            
        }
    });
}

function update(){
    if(!useFailedSettings){
        if(game.SONG.meta.needsVoices ? (game.inst.playing && game.vocals.playing) : (game.inst.playing)){
            if(!startedCountdown){
                startedCountdown = true;
                textEnabler = new FlxTimer().start(2, (tmr:FlxTimer) -> {
                    for(i in [loadingScreen, loadingTxt, loadingFlavorTxt]){
                        FlxTween.tween(i, {alpha: 0}, 1, {onComplete: function(){
                            i.kill();
                            close();
                        }});
                    }
                });
                loadingTxt.text = "Loading Complete!";
                loadingFlavorTxt.text = "Thank you for your patience!";
            }
        }
    } else {
        if(allowControl){
            if(controls.UP_P){
                loadingFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again <\nTurn off Streaming Mode";
                option = 0;
                firstOpened = false;
            }
            if(controls.DOWN_P){
                loadingFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again \nTurn off Streaming Mode <";
                option = 1;
                firstOpened = false;
            }
            if(firstOpened){
                loadingFlavorTxt.text = "Your music was unable to be streamed!\nYou can either:\n\n\nTry Again <\nTurn off Streaming Mode";
            }
            if(controls.ACCEPT){
                if(option == 1) FlxG.save.data.streamableMusic = false;
                FlxG.resetState();
            }
        }
    }
}