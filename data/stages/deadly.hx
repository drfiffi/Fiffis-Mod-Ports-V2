import flixel.text.FlxTextBorderStyle;

var camOther:FlxCamera;
var cameraBopMultiplier:Float = 1.0;
var cameraHUDBopMultiplier:Float = 1.0;

var stepsPerZoom:Int = 4;
var eventPlayedOnce:Bool = false;

var turnOnZoom:Bool = false;

var zoomGameTween:FlxTween;

function onNoteHit(event){
    event.enableCamZooming = false;
}

var defaultZoom:Float = 0;

function create(){
    defaultZoom = defaultCamZoom;

    bg = new FlxSprite(0, 0).makeGraphic(1280 * 1.8, 720 * 1.8, FlxColor.WHITE);
    bg.scrollFactor.set(0, 0);
    bg.screenCenter();
    insert(0, bg);

    fg = new FlxSprite(0, 0);
	fg.makeGraphic(128, 72, 0xff000000);
    fg.scale.set(20, 20);
    fg.scrollFactor.set(0, 0);
    fg.camera = camHUD;
    fg.alpha = 0;
    fg.screenCenter();
    insert(0, fg);

    bot = new FlxText((dad.width / 2) - 100, dad.y - 100, FlxG.width, '[BOT]', 10, true);
    bot.setFormat(Paths.font('Montserrat-Useless.ttf'), 60, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    bot.borderSize = 1;
    add(bot);
}

function postCreate(){
    camOther = new FlxCamera();
    camOther.bgColor = 0;
    FlxG.cameras.add(camOther, false);

    step = new FlxText(0, 0, FlxG.width, 'STEP', 10, true);
    step.setFormat(Paths.font('impact.ttf'), 100, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    step.camera = camOther;
    step.alpha = 0;
    step.borderSize = 4;
    add(step);

    num = new FlxText(0, FlxG.height - 120, FlxG.width, 'ONE', 10, true);
    num.setFormat(Paths.font('impact.ttf'), 100, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    num.camera = camOther;
    num.alpha = 0;
    num.borderSize = 4;
    add(num);
}

function update(){
    cameraBopMultiplier = lerp(cameraBopMultiplier, 1, camGameZoomLerp);
    var zoomPlusBop = defaultCamZoom * cameraBopMultiplier;
    FlxG.camera.zoom = zoomPlusBop;

    cameraHUDBopMultiplier = lerp(cameraHUDBopMultiplier, 1, camHUDZoomLerp);
    var zoomHUDPlusBop = defaultHudZoom * cameraHUDBopMultiplier;
    camHUD.zoom = zoomHUDPlusBop;

    
}

function stepHit(){
    if(turnOnZoom){
        if(curStep % stepsPerZoom == 0) zoomGameTween = FlxTween.tween(this, {defaultCamZoom: defaultZoom * 1.025, defaultHudZoom: 1.025}, (Conductor.stepCrochet / 1000) * 1, {ease: FlxEase.sineInOut});
        if(curStep % stepsPerZoom == 1) zoomGameTween = FlxTween.tween(this, {defaultCamZoom: defaultZoom * 1, defaultHudZoom: 1}, (Conductor.stepCrochet / 1000) * 1, {ease: FlxEase.linear});
    }
}

function onEvent(_){
    switch(_.event.name){
        case 'Deadly Events':
            switch(_.event.params[0]){
                case 'Set Text Alpha (A)':
                    if(_.event.params[1] == "1") step.alpha = _.event.params[2];
                    else if(_.event.params[1] == "2") num.alpha = _.event.params[2];
                    else if(_.event.params[1] == "3"){
                        step.alpha = _.event.params[2];
                        num.alpha = _.event.params[2];
                    }
                case 'Set Bottom Text (B)': num.text = _.event.params[1];

                case 'Access Cam Bop (C)':
                    switch(_.event.params[1].toLowerCase()){
                            case 'on': turnOnZoom = true;
                            case 'off': turnOnZoom = false;
                    }
                    stepsPerZoom = _.event.params[3];

                case 'Transition (D)':
                    switch(_.event.params[1].toLowerCase()){
                        case 'a':
                            switch(_.event.params[3]){
                                case 0: fg.alpha = 1;
                                default: FlxTween.tween(fg, {alpha: 1}, (Conductor.stepCrochet / 250) * _.event.params[3]);
                            }
                        case 'b': 
                            switch(_.event.params[3]){
                                case 0: fg.alpha = 0;
                                default: FlxTween.tween(fg, {alpha: 0}, (Conductor.stepCrochet / 250) * _.event.params[3]);
                            }
                            if(!eventPlayedOnce){
                                eventPlayedOnce = true;
                                bg.color = FlxColor.BLACK;
                                dad.color = 0xFF666666;
                                boyfriend.color = 0xFF666666;
                            }

                    }
            }
    }
}