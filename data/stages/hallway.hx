import openfl.display.BlendMode;
import flixel.camera.FlxCameraFollowStyle;
var neutral:Bool = true;
var dick:Bool = false;
var watch:Bool = false;
var movementShit:Bool = false;

introLength = 0;
function onCountdown(event) event.cancel();

function create(){
    for(i in [strumLines.members[0].characters[0], strumLines.members[0].characters[1], strumLines.members[2].characters[0], shadow3, shadow4]){
        i.alpha = 0;
    }
    remove(strumLines.members[2].characters[0]);
    insert(members.indexOf(strumLines.members[0].characters[0]) + 10, strumLines.members[2].characters[0]);

    remove(strumLines.members[1].characters[0]);
    insert(members.indexOf(strumLines.members[2].characters[0]) + 1, strumLines.members[1].characters[0]);

    strumLines.members[2].characters[0].setPosition(832, 129);
    strumLines.members[0].characters[0].setPosition(134, 118);
    strumLines.members[0].characters[1].setPosition(-66, 74);
    strumLines.members[1].characters[0].setPosition(427, 151);

    shadow3.setPosition(strumLines.members[0].characters[1].x - 16, strumLines.members[0].characters[1].y + 605);
    shadow4.setPosition(strumLines.members[0].characters[0].x, strumLines.members[0].characters[0].y + 560);

    spotlight = new FlxSprite(-502, -327).loadGraphic(Paths.image('stages/hallway/spotlight'));
    spotlight.blend = BlendMode.MULTIPLY;
	insert(members.indexOf(strumLines.members[1].characters[0]) + 1, spotlight);
}

function postCreate(){
    for(i in [comboGroup, healthBarBG, healthBar, iconP1, iconP2, scoreTxt, missesTxt, accuracyTxt]){
        remove(i, true); 
    }

    FlxG.camera.follow(camFollow, FlxCameraFollowStyle.LOCKON, 0.1);

    for (i in 0...strumLines.members[0].length){
        strumLines.members[1].members[i].visible = false;
        strumLines.members[2].members[i].y -= 210;
        strumLines.members[0].members[i].visible = true;
    }
}

function postUpdate(){
    if(neutral){
        camFollow.x = 600;
        camFollow.y = 300;
    }
    if(movementShit){
        shadow3.setPosition(strumLines.members[0].characters[1].x - 16, strumLines.members[0].characters[1].y + 605);
        shadow4.setPosition(strumLines.members[0].characters[0].x, strumLines.members[0].characters[0].y + 560);
    }
}

function stepHit(curStep:Int){
    switch(curStep){
        case 50: neutral = false;
        case 124:
            for(i in [strumLines.members[0].characters[0], strumLines.members[0].characters[1], strumLines.members[2].characters[0], shadow3, shadow4]) i.alpha = 1;
            spotlight.alpha = 0;
            spotlight2.alpha = 0;
        case 126: neutral = false;
        case 784: spotlight.alpha = 1;
        case 852: spotlight.flipX = true;
        case 936: FlxTween.tween(spotlight, {alpha: 0}, 0.3, {ease: FlxEase.linear});
        case 944:
            movementShit = true;
            FlxTween.tween(strumLines.members[0].characters[1], {x: 261, y:117}, 3, {ease: FlxEase.linear});
            FlxTween.tween(strumLines.members[0].characters[0], {x: 625, y:148}, 3, {ease: FlxEase.linear});
        case 976: movementShit = false;
    }
}