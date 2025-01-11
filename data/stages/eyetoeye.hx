var healthOn:Bool = false;
var adjustColorBF = new CustomShader('adjustColor');

function create(){
    boyfriend.shader = adjustColorBF;
    dad.alpha = 0;
    boyfriend.alpha = 0;
    camHUD.alpha = 0; 
	adjustColorBF.saturation = -50;

    bfFake = new FlxSprite(-24.5, -10.5).loadGraphic(Paths.image('stages/eyetoeye/asshole'));
	bfFake.scale.set(0.4, 0.4);
    bfFake.scrollFactor.set(0, 0);
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

function postCreate() for(i in 0...4) playerStrums.members[i].alpha = 0.5;

function onStrumCreation(_) _.__doAnimation = false;

function onNoteCreation(_){
    if(_.note.isSustainNote) _.note.alpha = 0.15;
    if(!_.note.isSustainNote) _.note.alpha = 0.5;
} 

function onDadHit(_) if (healthOn && health >= 0.1) health -= 0.03;

function beatHit(curBeat:Int){
    switch(curBeat){
        case 17: 
            FlxTween.tween(camHUD, {alpha: 1}, 5, {ease: FlxEase.linear});
        case 32:
            FlxTween.tween(bfFake.scale, {x: 1, y: 1}, (Conductor.stepCrochet / 250) * 27, {ease: FlxEase.sineInOut});
            FlxTween.tween(bfFake, {alpha: 1}, (Conductor.stepCrochet / 250) * 27, {ease: FlxEase.sineInOut});
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