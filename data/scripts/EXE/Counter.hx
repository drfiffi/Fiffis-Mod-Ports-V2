function onCountdown(_) _.cancelled = true;
var introLength = (Conductor.stepCrochet) + 16;

function create(){
    switch(SONG.meta.name){
        case "too-slow": 
            introImage = "TooSlow";
        case "endless": 
            introImage = "Majin";
        case "execution": 
            introImage = "Execution";
    }
    camOther = new FlxCamera();
    camOther.bgColor = 0;
    FlxG.cameras.add(camOther, false);

    blackFuck = new FlxSprite().makeGraphic(1280,720, FlxColor.BLACK);

    startCircle = new FlxSprite();
    startCircle.loadGraphic(Paths.image('EXEAssets/StartScreens/Circle' + introImage));
    startCircle.x += 777;

    startText = new FlxSprite();
    startText.loadGraphic(Paths.image('EXEAssets/StartScreens/Text' + introImage));
    startText.x -= 1200;

    new FlxTimer().start(0.6, function(tmr:FlxTimer){
        FlxTween.tween(startCircle, {x: 0}, 0.5);
        FlxTween.tween(startText, {x: 0}, 0.5);
    });
        
    new FlxTimer().start(1.9, function(tmr:FlxTimer){
        FlxTween.tween(startCircle, {alpha: 0}, 1);
        FlxTween.tween(startText, {alpha: 0}, 1);
        FlxTween.tween(blackFuck, {alpha: 0}, 1);
    });
}

function postCreate(){
        for(i in [blackFuck, startCircle, startText]){
            i.camera = camOther;  add(i);
        }
}