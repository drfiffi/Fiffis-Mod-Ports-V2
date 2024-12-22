var lockCamera:Bool = false;
var gofun:FlxSprite;
var three:FlxSprite;
var two:FlxSprite;
var one:FlxSprite;

function create(){
    gofun = new FlxSprite().loadGraphic(Paths.image('EXEAssets/goFun'));
    gofun.scrollFactor.set();
    gofun.updateHitbox();
    gofun.alpha = 0;

    three = new FlxSprite().loadGraphic(Paths.image('EXEAssets/three'));
    three.scrollFactor.set();
    three.updateHitbox();
    three.alpha = 0;

    two = new FlxSprite().loadGraphic(Paths.image('EXEAssets/two'));
    two.scrollFactor.set();
    two.alpha = 0;

    one = new FlxSprite().loadGraphic(Paths.image('EXEAssets/one'));
    one.scrollFactor.set();
    one.alpha = 0;

    add(gofun);
    add(three);
    add(two);
    add(one);
}

function stepHit(){
    switch(curStep){
        case 10: FlxG.sound.play(Paths.sound('laugh1'), 1);
        case 272|276|336|340|400|404|464|468|528|532|592|596|656|660|720|724|784|788|848|852|912|916|976|980|1040|1044|1104|1108|1424|1428|1488|1492|1552|1556|1616|1620:
            for(i in 0...cpuStrums.length) {
                cpuStrums.members[i].angle = 0;
                FlxTween.tween(cpuStrums.members[i], {angle: 360}, 0.2, {ease: FlxEase.quintOut});
            }
            for(i in 0...playerStrums.length) {
                playerStrums.members[i].angle = 0;
                FlxTween.tween(playerStrums.members[i], {angle: 360}, 0.2, {ease: FlxEase.quintOut, onComplete: function(){
                }});
            }
        case 909:
            lockCamera = true;
            camFollow.setPosition(FlxG.width / 2 + 200, FlxG.height / 4 * 3 + 100);
            FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
            three.alpha = 0.5;
            three.screenCenter();
            three.y -= 100;
            FlxTween.tween(three, {y: three.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween)
                {
                    three.destroy();
                }
            });
        case 914:
            FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
            two.alpha = 0.5;
            two.screenCenter();
            two.y -= 100;
            FlxTween.tween(two, {y: two.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween)
                {
                    two.destroy();
                }
            });
        case 918:
            FlxTween.tween(FlxG.camera, {zoom: FlxG.camera.zoom + 0.3}, 0.7, {ease: FlxEase.cubeInOut});
            one.alpha = 0.5;
            one.screenCenter();
            one.y -= 100;
            FlxTween.tween(one, {y: one.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween)
                {
                    one.destroy();
                }
            }); 
        case 923:
            lockCamera = false;
            FlxTween.tween(FlxG.camera, {zoom: defaultCamZoom}, 0.7, {ease: FlxEase.cubeInOut});
            gofun.alpha = 0.5;
            gofun.screenCenter();
            gofun.y -= 100;
            FlxTween.tween(gofun, {y: gofun.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                ease: FlxEase.cubeInOut,
                onComplete: function(twn:FlxTween)
                {
                    gofun.destroy();
                }
            }); 
        case 924: changeNoteSkins();
    }
}

function changeNoteSkins() {
    for(strumsForShit in [0, 1]){
        frames = Paths.getSparrowAtlas("EXEAssets/Majin_Notes");
        
        for (strum in strumLines.members[strumsForShit]) {
        strum.frames = frames;
        strum.animation.addByPrefix("static", "arrowUP");
        strum.animation.addByPrefix("blue", "arrowDOWN");
        strum.animation.addByPrefix("purple", "arrowLEFT");
        strum.animation.addByPrefix("red", "arrowRIGHT");
        
        strum.antialiasing = true;
        strum.setGraphicSize(Std.int(frames.width * 0.7));
        
        var animPrefix = strumLines.members[strumsForShit].strumAnimPrefix[strum.ID % strumLines.members[strumsForShit].strumAnimPrefix.length];
        strum.animation.addByPrefix("static", "arrow" + animPrefix.toUpperCase());
        strum.animation.addByPrefix("pressed", animPrefix + " press", 24, false);
        strum.animation.addByPrefix("confirm", animPrefix + " confirm", 24, false);
        
        strum.updateHitbox();
        strum.playAnim("static");
        }
        
        for (note in strumLines.members[strumsForShit].notes) {
        note.frames = frames;
        
        switch (note.noteData % 4) {
        case 0:
        note.animation.addByPrefix("scroll", "purple0");
        note.animation.addByPrefix("hold", "purple hold piece");
        note.animation.addByPrefix("holdend", "pruple end hold");
        case 1:
        note.animation.addByPrefix("scroll", "blue0");
        note.animation.addByPrefix("hold", "blue hold piece");
        note.animation.addByPrefix("holdend", "blue hold end");
        case 2:
        note.animation.addByPrefix("scroll", "green0");
        note.animation.addByPrefix("hold", "green hold piece");
        note.animation.addByPrefix("holdend", "green hold end");
        case 3:
        note.animation.addByPrefix("scroll", "red0");
        note.animation.addByPrefix("hold", "red hold piece");
        note.animation.addByPrefix("holdend", "red hold end");
        }
        
        note.scale.set(0.7, 0.7);
        note.antialiasing = true;
        note.updateHitbox();
        
        if (note.isSustainNote) {
        note.animation.play("holdend");
        note.updateHitbox();
        
        if (note.nextSustain != null)
        note.animation.play('hold');
        } else
        note.animation.play("scroll");
        }
    }
}

function onCameraMove(_){
    if(lockCamera) _.cancelled = true;
    else _.cancelled = false;
}

/*
fixes everything angling and not just the strumLine...
*/

function postUpdate(){
    for(i in 0...cpuStrums.length) cpuStrums.members[i].noteAngle = 0;
    for(i in 0...playerStrums.length) playerStrums.members[i].noteAngle = 0;
}