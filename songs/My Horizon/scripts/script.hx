import flixel.util.FlxTimer;
import flixel.text.FlxTextBorderStyle;

import funkin.backend.assets.IModsAssetLibrary;

import sys.FileSystem;

var camOther:FlxCamera;

var hitMTimer:FlxTimer;
var turnOnMech:Bool = false;

var practice:Bool = true;

var allowRain:Bool = false;
var rainShit:NumTween;
var rain:CustomShader;
var lightingTween:FlxTween;

var weird:Int = 7;
var weird2:Int = 6;

public var lightningStrike:Bool = true;
public var lightningStrikeBeat:Int = 0;
public var lightningOffset:Int = 8;

introLength = 2.5;
function onCountdown(event) event.cancel();

function create(){
    camOther = new FlxCamera(0, 0, 1280, 720);
    camOther.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camOther, false);

    heartMech = new FlxSprite(0, 0);
    heartMech.frames = Paths.getSparrowAtlas('stages/horizon/myhorizonheart');
    heartMech.animation.addByPrefix('heart', 'myhorizonheart', 24, false);
    heartMech.camera = camOther;
	heartMech.screenCenter();
	heartMech.alpha = 0;
    add(heartMech);

	titleCard = new FlxSprite(731, 470);
    titleCard.frames = Paths.getSparrowAtlas('stages/horizon/my horizon credits');
    titleCard.animation.addByPrefix('credits', 'my horizon credits', 24, false);
    titleCard.camera = camOther;
	titleCard.scale.set(0.7, 0.7);
	titleCard.updateHitbox();
    add(titleCard);

	instTxt1 = new FlxText(1400, 0, 1280, 'This is your heart.\nPress Space when you\nsee the heart beat!', 60);
	instTxt2 = new FlxText(1400, 0, 1280, "Let's practice a bit!\nShall we?" , 60);
	instTxt3 = new FlxText(250, 0, 1280, "" , 60);

	for(i in [instTxt1, instTxt2]){
		i.setFormat(Paths.font("vcr.ttf"), 30, 0xFFFFFFFF, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	}

	instTxt3.setFormat(Paths.font("vcr.ttf"), 40, 0xFFFFFFFF, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

	for(i in [instTxt1, instTxt2, instTxt3]){
		i.camera = camOther;
		i.screenCenter(FlxAxes.Y);
		i.borderSize = 3;
		insert(4, i);
	}

	instTxt1.y -= 50;
	instTxt2.y += 50;
	instTxt3.alpha = 0;

    bg = new FlxSprite(0, 0);
	bg.makeGraphic(1280, 720, 0xFF000000);
    bg.camera = camOther;
    insert(0, bg);
}

function postCreate(){
    rain = new CustomShader("rain");
    camGame.addShader(rain);

    rain.intensity = 0;
	rain.iIntensity = 0;
    rain.iTimescale = 0.8;
}

function camoffsetshit(lol:String) {
	switch (lol) {
		case 'a':
			FlxTween.tween(camHUD, {alpha: 0}, 1, {ease: FlxEase.quadOut});
			FlxTween.tween(boyfriend, {alpha: 0}, 1, {ease: FlxEase.quadOut});
			for (tag => sprite in stage.stageSprites) {
				if (!StringTools.startsWith(tag, 'spooky')) FlxTween.tween(sprite, {alpha: 0}, 1, {ease: FlxEase.quadOut});
			}
			case 'c':
			camHUD.alpha = 1;
			boyfriend.alpha = 1;
			for (tag => sprite in stage.stageSprites) {
				if (StringTools.startsWith(tag, 'spooky') || tag == 'fg1' || tag == 'fg2') sprite.alpha = 1;
			}
	}
}

function stepHit(){
	for (tag => sprite in stage.stageSprites) {
		switch(curStep){
			case 80: 
				practice = false;
				titleCard.animation.play('credits');
			case 592:
				weird = 6;
				weird2 = 5;
			case 1588: FlxTween.color(sprite, (Conductor.stepCrochet / 1000) * 4, 0xFFFFFFFF, 0xFFFFA9A9);
			case 1600: FlxTween.color(sprite, (Conductor.stepCrochet / 1000) * 1, 0xFFFFA9A9, 0xFFFFFFFF);
			case 1728: 
				for(i in [boyfriend, dad, sprite]) FlxTween.color(i, (Conductor.stepCrochet / 1000) * 9, 0xFFFFFFFF, 0xFF777777);
				allowRain = true;
				rainShit = FlxTween.num(0.0, 0.3, 10, {onUpdate: (_) -> {
					rain.iIntensity = rainShit.value;
				}});
		}
	}

	if(curStep >= 16 && curStep < 720){
		switch(curStep % 16){
			case 0 | weird | 10: 
				heartMech.animation.play('heart', true);
				camHUD.zoom += 0.03;
				if(practice){
					instTxt3.scale.set(1.1, 1.1);
					FlxTween.tween(instTxt3.scale, {x: 1, y: 1}, 0.1);
				}
			case 15 | weird2 | 9:
				turnOnMech = true;
				hitMTimer = new FlxTimer().start((Conductor.stepCrochet / 1000) * 2, function(timer){
					if(turnOnMech){
						switch(practice){
							case false:
								if(health > 0.5) health -= 0.15;
								else if(health <= 0.5) health -= 0.075;
							case true:
								instTxt3.text = 'Bad...';
								instTxt3.color = FlxColor.RED;
						}
						turnOnMech = false;
					}
				});
		}
	}

	if(curStep >= 592 && curStep < 720){
		switch(curStep % 16){
			case 0 | 6 | 10: 
				heartMech.animation.play('heart', true);
				camHUD.zoom += 0.03;
			case 15 | 5 | 9:
				turnOnMech = true;
				hitMTimer = new FlxTimer().start((Conductor.stepCrochet / 1000) * 2, function(timer){
					if(turnOnMech){
						if(health > 0.5) health -= 0.15;
						else if(health <= 0.5) health -= 0.075;
						turnOnMech = false;
					}
				});
		}
	}

	if(curStep >= 960){
		camHUD.alpha = 1;
		bg.alpha = 0;
		heartMech.alpha = 0;
		boyfriend.alpha = 1;
	}
}

function onStrumCreation(_) if(_.player == 0) _.sprite = 'game/notes/NOTE_wech';
function onNoteCreation(_) if(_.note.strumLine == cpuStrums) _.noteSprite = 'game/notes/NOTE_wech';

function onSongStart(){
	heartMech.animation.play('heart');
	FlxTween.tween(heartMech, {alpha: 0.5}, (Conductor.stepCrochet / 250) * 3.8);
}

function beatHit(){
    if(curBeat < 4) heartMech.animation.play('heart', true);
	switch(curBeat){
		case 4:
			bg.alpha = 0.3;
			heartMech.alpha = 1;
			camOther.flash(FlxColor.WHITE, (Conductor.stepCrochet / 1000) * 8);
		case 6: FlxTween.tween(instTxt1, {x: 760}, 1, {ease: FlxEase.expoOut});
		case 8: 
			instTxt3.alpha = 1;
			FlxTween.tween(instTxt2, {x: 760}, 1, {ease: FlxEase.expoOut});
		case 12: 
			instTxt1.text = "The real game\nbegins in...";
			instTxt1.color = FlxColor.RED;
		case 16:
			for(i in [instTxt1, instTxt3, bg]) FlxTween.tween(i, {alpha: 0}, (Conductor.stepCrochet / 250) * 4);
			FlxTween.tween(instTxt2.scale, {x: 2, y: 2}, 0.3, {ease: FlxEase.expoOut});
			FlxTween.tween(heartMech, {x: 20, y: 500}, 1, {ease: FlxEase.expoOut});
			FlxTween.tween(heartMech.scale, {x: 0.6, y: 0.6}, 1, {ease: FlxEase.expoOut});
			
			instTxt2.text = "3...";
		case 17: instTxt2.text = "3, 2...";
		case 18: instTxt2.text = "3, 2, 1...";
		case 19: 
			instTxt2.text = "GO!";
			FlxTween.tween(instTxt2, {alpha: 0}, 1, {ease: FlxEase.expoOut});
		case 180: FlxTween.tween(heartMech, {alpha: 0}, (Conductor.stepCrochet / 1000) * 8, {ease: FlxEase.expoOut});
	}
	if (allowRain && lightningStrike && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset) {
		lightningStrikeShit();
	}
}

var localTime:Float = 0;
function update(elapsed:Float){
	instTxt2.updateHitbox();
	instTxt3.updateHitbox();
	heartMech.updateHitbox();

	if(allowRain){
		localTime += elapsed;
		rain.iTime = localTime;
		rain.iTimescale = 0.7;
	}

	if(turnOnMech){
		if(FlxG.keys.justPressed.SPACE){
			hitMTimer.cancel();
			turnOnMech = false;
			if(practice){
				instTxt3.text = 'Good!!';
				instTxt3.color = FlxColor.GREEN;
			}
		}
	}
}

public function lightningStrikeShit(){
	FlxG.camera.flash(FlxColor.WHITE, 0.3);
	for (tag => sprite in stage.stageSprites) {
		for(i in [boyfriend, dad, sprite]){
			i.color = 0xFFFFFFFF;
			lightingTween = FlxTween.color(i, 1, 0xFFFFFFFF, 0xFF777777);
		} 
	}

	lightningStrikeBeat = curBeat;
	lightningOffset = FlxG.random.int(8, 24);
}