var healthOn:Bool = false;

import openfl.display.BlendMode;

var adjustColorBF = new CustomShader('adjustColor');

function create(){
    
    boyfriend.shader = adjustColorBF;
    dad.alpha = 0;
    camHUD.alpha = 0; 
	adjustColorBF.saturation = -50;

    bfFake = new FlxSprite(600, -250).loadGraphic(Paths.image('stages/eyetoeye/asshole'));
	bfFake.scale.set(0.6, 0.6);
    bfFake.alpha = 0;
    bfFake.frames = Paths.getSparrowAtlas("stages/eyetoeye/asshole");
	bfFake.animation.addByPrefix('idle', "motherfucker instance 1", 12, true);

    blackVoid = new FlxSprite(-200, -200);
	blackVoid.makeGraphic(1700, 1500, 0xFF000000);
    blackVoid.scrollFactor.set(0, 0);
    insert(6, blackVoid);

	bfFake.animation.play('idle');
	add(bfFake);
}

function postCreate(){
    boyfriend.alpha = 0;
}

/*function postUpdate(){
    playerStrums.forEach(function(strums) strums.alpha = 0.5);
    playerStrums.notes.forEach(function(notes) notes.alpha = 0.5);
}*/

function onDadHit(e){
    if (healthOn && health >= 0.1)
    health -= 0.03;
}

function beatHit(curBeat:Int){
    switch(curBeat){
        case 17: FlxTween.tween(camHUD, {alpha: 1}, 5, {ease: FlxEase.linear});
        case 42:
            FlxTween.tween(bfFake.scale, {x: 0.9, y: 0.9}, 5, {ease: FlxEase.quadOut});
            FlxTween.tween(bfFake, {alpha: 1}, 5, {ease: FlxEase.quadOut});
        case 98:
            FlxTween.tween(bfFake.scale, {x: 0.6, y: 0.6}, 3, {ease: FlxEase.quadIn});
            FlxTween.tween(bfFake, {alpha: 0}, 3, {ease: FlxEase.quadIn, onComplete: function(twn:FlxTween){
                remove(bfFake);
                bfFake.destroy();
            }});
        case 101: FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.linear});

        case 110:  FlxTween.tween(dad, {alpha: 1}, 1, {ease: FlxEase.linear});

        case 112:
            camHUD.alpha = 1;
            camHUD.zoom = 2;
        case 176:
            boyfriend.alpha = 1;
            blackVoid.alpha = 0;
            healthOn = true;
        case 336:
            boyfriend.alpha = 0;
            blackVoid.alpha = 1;
        case 440:
            boyfriend.alpha = 1;
            blackVoid.alpha = 0;
            defaultCamZoom = 0.5;
        case 576: camHUD.alpha = 0;
    }
    if(curBeat >= 112 && bfFake != null){
        remove(bfFake);
        bfFake.destroy();
    }
}

function stepHit(curStep:Int){
    switch(curStep){
        case 2305: for(a in [dad, boyfriend]) a.alpha = 0;

        case 2306: camGame.alpha = 0;
    }
}