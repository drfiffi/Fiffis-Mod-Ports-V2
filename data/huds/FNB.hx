import flixel.text.FlxTextBorderStyle;
import funkin.backend.utils.DiscordUtil;
import flixel.util.FlxStringUtil;

import flixel.ui.FlxBar;
import haxe.ds.StringMap;

var camScore:FlxCamera;
var camOther:FlxCamera;
var scaleSize:Float = 0.5;

var useDiscordPFP:Bool = false;

var zoomIconTween:FlxTween;
var zoomIcon2Tween:FlxTween;
var zoomScoreTween:FlxTween;

var dadScore:Int = 0;

function create(){
    camOther = new FlxCamera();
    camOther.bgColor = 0;
    FlxG.cameras.add(camOther, false);

    camScore = new FlxCamera(0, 670, 1280, 120);
    camScore.bgColor = 0;
    FlxG.cameras.add(camScore, false);

    authers = 'Ion, Sumii, RookieMoney, MPranger, Robotic_Developer, Cheez and Buck';
    thetext = new FlxText(0, -2, FlxG.width, SONG.meta.name + '\nBy: ' + authers, 10, true);
    thetext.setFormat(Paths.font('Montserrat-Bold.ttf'), 16, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    thetext.borderSize = 1.25;
    add(thetext);

    timeTxt = new FlxText(0, 40, FlxG.width, 'X:XX', 10, true);
    timeTxt.setFormat(Paths.font('Montserrat-Bold.ttf'), 16, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.borderSize = 1.25;
    add(timeTxt);
}

function postCreate(){
    if(DiscordUtil.user == null) useDiscordPFP = false;
    if(DiscordUtil.user != null) useDiscordPFP = true;

    healthBarNew = new FlxBar(91, 505, FlxBar.LEFT_TO_RIGHT, 800, 19, this, 'health', 0, maxHealth);
    healthBarNew.createImageBar(Paths.image('huds/Bloxxin/healthBarL'), Paths.image('huds/Bloxxin/healthBarR'));
    healthBarNew.flipX = true;
    healthBarNew.numDivisions = 200;
    healthBarNew.screenCenter();
    healthBarNew.y += 300;
    healthBarNew.updateHitbox();
    insert(1, healthBarNew);

    healthBarBGNew = new FlxSprite(healthBarNew.x, healthBarNew.y).loadGraphic(Paths.image('huds/Bloxxin/healthBarBG'));
    insert(2, healthBarBGNew);

    if(useDiscordPFP){
        var userBitmap = DiscordUtil.user.getAvatar();
        playerIcon = new FlxSprite(80, healthBarNew.y - 54).loadGraphic(userBitmap);
    } else {
        playerIcon = new FlxSprite(80, healthBarNew.y - 54).loadGraphic(Paths.image('huds/Bloxxin/defaultPFP'));
    }

    playerIcon.scale.set(scaleSize, scaleSize);
    playerIcon.updateHitbox();
    add(playerIcon);

    opponentIcon = new FlxSprite(80, healthBarNew.y - 50).loadGraphic(Paths.image('huds/Bloxxin/trollIcon'));
    opponentIcon.scale.set(scaleSize, scaleSize);
    opponentIcon.updateHitbox();
    add(opponentIcon);

    for (i in 0...strumLines.members[0].length){
        strumLines.members[1].members[i].scale.set(0.6, 0.6);
        strumLines.members[0].members[i].scale.set(0.6, 0.6);

        strumLines.members[1].members[i].y = 75;
        strumLines.members[0].members[i].y = 75;
    }
    for(i in [scoreTxt, missesTxt, accuracyTxt, iconP1, healthBar, healthBarBG, iconP1, iconP2]) remove(i);

    infoTxtAccuracy = new FlxText(-200, 20, FlxG.width, 'Accuracy: 100%', 10, true);
    infoTxtMisses = new FlxText(0, 20, FlxG.width, 'Misses: 0', 10, true);
    infoTxtCombo = new FlxText(200, 20, FlxG.width, 'Combo: 0', 10, true);

    playerScore = new FlxText(520, healthBarBGNew.y - 20, FlxG.width, '0', 10, true);
    playerScore.setFormat(Paths.font('Montserrat-Bold.ttf'), 60, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    playerScore.borderSize = 1.25;
    insert(31, playerScore);

    dadScoreTxt = new FlxText(-520, healthBarNew.y - 20, FlxG.width, '0', 10, true);
    dadScoreTxt.setFormat(Paths.font('Montserrat-Bold.ttf'), 60, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    dadScoreTxt.borderSize = 1.25;
    insert(32, dadScoreTxt);

    for(i in [infoTxtAccuracy, infoTxtCombo, infoTxtMisses]){
        i.setFormat(Paths.font('vcr.ttf'), 20, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        i.borderSize = 1.25;
        insert(30, i);
    }

    for(i in [thetext, timeTxt, healthBarNew, healthBarBGNew, playerIcon, opponentIcon, playerScore, dadScoreTxt]){
        i.camera = camOther;
        i.antialiasing = true;
    }

    for(o in [infoTxtAccuracy, infoTxtCombo, infoTxtMisses]){
        o.camera = camScore;
        o.antialiasing = true;
    }
}

function onRatingUpdate(){
    infoTxtAccuracy.text = 'Accuracy: ' + CoolUtil.quantize(accuracy * 100, 100) + '%';
    infoTxtMisses.text = 'Misses: ' + misses;
}

function postUpdate(){
    timeTxt.text = FlxStringUtil.formatTime((inst.length-inst.time) / 1000, false);

    infoTxtCombo.text = 'Combo: ' + combo;

    updateIconPositions();

    playerScore.text = songScore;
    dadScoreTxt.text = dadScore;
}

function onStrumCreation(_) _.__doAnimation = false;

function onNoteCreation(_) _.noteScale = 0.6;

function stepHit(){
    for(i in [zoomIconTween, zoomIcon2Tween]) if(i != null) i.cancel();

    if(curStep % 4 == 0){
        zoomIconTween = FlxTween.tween(playerIcon.scale, {x: scaleSize * 0.6, y: scaleSize * 0.6}, 0.05, {ease: FlxEase.sineInOut});
        zoomIcon2Tween = FlxTween.tween(opponentIcon.scale, {x: scaleSize * 0.6, y: scaleSize * 0.6}, 0.05, {ease: FlxEase.sineInOut});
    }
    if(curStep % 4 == 1){
        zoomIconTween = FlxTween.tween(playerIcon.scale, {x: scaleSize * 0.4, y: scaleSize * 0.4}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.linear});
        zoomIcon2Tween = FlxTween.tween(opponentIcon.scale, {x: scaleSize * 0.4, y: scaleSize * 0.4}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.linear});
    }
}

function onNoteHit(_){
    if(_.player){
        if(!_.note.isSustainNote){
            camScore.zoom = 1.07;
            if(zoomScoreTween != null) zoomScoreTween.cancel();
            zoomScoreTween = FlxTween.tween(camScore, {zoom: 1}, 0.1, {ease: FlxEase.linear});
        }
    }
    if(!_.player){
        if(!_.note.isSustainNote){
            luckyScore = FlxG.random.int(0, 50);
            switch(luckyScore){
                case 0: dadScore += 50;
                case 1 | 2: dadScore += 100;
                case 3 | 4 | 5 | 6: dadScore += 200;
                default: dadScore += 300;
            }
        }
    }
}

function updateIconPositions() {
    var iconOffset:Int = 26;

    var center:Float = healthBarNew.x + healthBarNew.width * FlxMath.remapToRange(healthBarNew.percent, 0, 100, 1, 0);

    playerIcon.x = center - iconOffset;
    opponentIcon.x = center - (opponentIcon.width - iconOffset);

    health = FlxMath.bound(health, 0, maxHealth);

    playerIcon.health = healthBar.percent / 100;
    opponentIcon.health = 1 - (healthBar.percent / 100);
}