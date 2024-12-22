import flixel.text.FlxTextBorderStyle;

var songArrayNum:Int = 1;
var extraSongArrayNum:Int = 0;
var extrasEnabled:Bool = false;
var allowUppies:Bool = false;
var allowControl:Bool = true;

var songListForNormal = ["endless", "too-slow", "execution"];
var songListForExtar  = ["testicles", "Eye To Eye", "My Horizon", "REROY"];

function create(){
	bg = new FlxSprite(0, 0);
	bg.frames = Paths.getSparrowAtlas('EXEAssets/fpstuff/SMMStatic');
	bg.animation.addByPrefix('idlexd', "damfstatic", 24);
	bg.animation.play('idlexd');
	bg.setGraphicSize(bg.width);
	bg.updateHitbox();
	add(bg);

	greyBOXMajin = new FlxSprite(0,0).loadGraphic(Paths.image('EXEAssets/fpstuff/greybox'));
	greyBOX = new FlxSprite(0,0).loadGraphic(Paths.image('EXEAssets/fpstuff/greybox'));
	greyBOXLord = new FlxSprite(0,0).loadGraphic(Paths.image('EXEAssets/fpstuff/greybox'));

	yellowBOXMajin = new FlxSprite(-400,0).loadGraphic(Paths.image('EXEAssets/fpstuff/yellowbox'));
	yellowBOX = new FlxSprite(0,0).loadGraphic(Paths.image('EXEAssets/fpstuff/yellowbox'));
	yellowBOXLord = new FlxSprite(-400,0).loadGraphic(Paths.image('EXEAssets/fpstuff/yellowbox'));
	

	for(i in [greyBOXMajin, greyBOX, greyBOXLord]){
		i.setGraphicSize(bg.width * 0.9);
		i.updateHitbox();
		i.screenCenter();
		add(i);
	}

	TooSlowFreeplay = new FlxSprite(0, 0).loadGraphic(Paths.image('EXEAssets/fpstuff/too-slow'));
	EndlessFreeplay = new FlxSprite(0, 0).loadGraphic(Paths.image('EXEAssets/fpstuff/endless'));
	ExecutionFreeplay = new FlxSprite(0, 0).loadGraphic(Paths.image('EXEAssets/fpstuff/cycles'));

	for(i in [TooSlowFreeplay, EndlessFreeplay, ExecutionFreeplay]){
		i.setGraphicSize(i.width * 0.24);
		i.updateHitbox();
		i.screenCenter();
		i.setPosition(i.x - 8, i.y - 165);
		add(i);
	}

	staticscreenTS = new FlxSprite(450, 0);
	staticscreenEN = new FlxSprite(450, 0);
	staticscreenEX = new FlxSprite(450, 0);

	for(i in [staticscreenTS, staticscreenEN, staticscreenEX]){
		i.frames = Paths.getSparrowAtlas('EXEAssets/screenstatic');
		i.animation.addByPrefix('screenstaticANIM', "screenSTATIC", 24);
		i.animation.play('screenstaticANIM');
		i.alpha = 0.3;
		i.setGraphicSize(i.width * 0.24);
		i.updateHitbox();
		i.setPosition(478.5, 108.65625);
		add(i);
	}


	for(i in [yellowBOXMajin, yellowBOX, yellowBOXLord]){
		i.setGraphicSize(bg.width * 0.9);
		i.updateHitbox();
		i.screenCenter();
		add(i);
	}

	for(i in [greyBOXMajin, yellowBOXMajin, EndlessFreeplay, staticscreenEN]) i.x -= 430;
	for(i in [greyBOXLord, yellowBOXLord, ExecutionFreeplay, staticscreenEX]) i.x += 430;

	redBOX = new FlxSprite(0,0).loadGraphic(Paths.image('EXEAssets/fpstuff/redbox'));
	redBOX.setGraphicSize(bg.width * 0.9);
	redBOX.updateHitbox();
	redBOX.screenCenter();

	extrasArrow = new FlxSprite(230, 0);
	extrasArrow.frames = Paths.getSparrowAtlas('EXEAssets/fpstuff/exeFreeplayUI');
	extrasArrow.angle = 90;
	extrasArrow.screenCenter();
	extrasArrow.y += 300;
	extrasArrow.setGraphicSize(extrasArrow.width * 0.8);
	extrasArrow.animation.addByPrefix('idle', "arrow right");
	extrasArrow.animation.addByPrefix('press', "arrow push right");
	extrasArrow.animation.play('idle');

	extraSongsBG = new FlxSprite(0, 730).makeGraphic(720, 480, FlxColor.BLACK);
	extraSongsBG.screenCenter(FlxAxes.X);

	yellowBOXEExtras = new FlxSprite(-400, 740).loadGraphic(Paths.image('EXEAssets/fpstuff/yellowbox'));
	yellowBOXEExtras.screenCenter(FlxAxes.X);
	yellowBOXEExtras.x += 20;
	yellowBOXEExtras.scale.set(1.3, 1.3);

	extrasTopperTxt = new FlxText(0, 760, 1280, "Extra Songs", 20);
    extrasTopperTxt.setFormat(Paths.font("NiseSegaSonic.ttf"), 40, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    extrasTopperTxt.borderSize = 1.25;

	songsForExtra = new FlxText(0, 850, 1280, "Eye To Eye\n\nMy Horizon\n\nREROY???", 20);
    songsForExtra.setFormat(Paths.font("NiseSegaSonic.ttf"), 25, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songsForExtra.borderSize = 1.25;

	for(i in [redBOX, extrasArrow, extraSongsBG, yellowBOXEExtras, extrasTopperTxt, songsForExtra]){
		add(i);
	}
}

function update(){
	if(allowControl){
		if(!extrasEnabled){
			if(controls.LEFT_P){
				if(songArrayNum < 1) songArrayNum = 2;
				else songArrayNum -= 1;
			}
			if(controls.RIGHT_P){
				if(songArrayNum > 1) songArrayNum = 0;
				else  songArrayNum += 1;
			}
			if(controls.ACCEPT){
				allowControl = false;
				PlayState.loadSong(songListForNormal[songArrayNum], "hard");
				FlxG.switchState(new PlayState());
			}
		} else {
			if(controls.ACCEPT){
				allowControl = false;
				PlayState.loadSong(songListForExtar[extraSongArrayNum], "hard");
				FlxG.switchState(new PlayState());
			}
		}

		if(controls.UP_P){
			if(extraSongArrayNum < 1){
				extraSongArrayNum = 0;
				allowUppies = false;
			} else {
				extraSongArrayNum -= 1;
			}
			if(extraSongArrayNum == 0 && allowUppies){
				allowControl = false;
				for(i in [extrasArrow, extraSongsBG, yellowBOXEExtras, extrasTopperTxt, songsForExtra]){
					FlxTween.tween(i, {y: i.y + 300}, 0.2, {ease: FlxEase.quadInOut, onComplete: function(){
						allowControl = true;
					}});
				}
				FlxTween.tween(extrasArrow, {angle: extrasArrow.angle + 180}, 0.2, {ease: FlxEase.quadInOut});
				FlxTween.tween(redBOX, {alpha: 1}, 0.2, {ease: FlxEase.quadInOut});
			}
		}
		if(controls.DOWN_P){
			if(extraSongArrayNum > 2) extraSongArrayNum = 3;
			else  extraSongArrayNum += 1;
		
			if(extraSongArrayNum == 1){
				allowUppies = true;
				allowControl = false;
				for(i in [extrasArrow, extraSongsBG, yellowBOXEExtras, extrasTopperTxt, songsForExtra]){
					FlxTween.tween(i, {y: i.y - 300}, 0.2, {ease: FlxEase.quadInOut, onComplete: function(){
						allowControl = true;
					}});
				}
				FlxTween.tween(extrasArrow, {angle: extrasArrow.angle - 180}, 0.2, {ease: FlxEase.quadInOut});
				FlxTween.tween(redBOX, {alpha: 0}, 0.2, {ease: FlxEase.quadInOut});
			}
		}

		switch(songArrayNum){
			case 0: redBOX.x = 64 - 430;
			case 1: redBOX.x = 64;
			case 2: redBOX.x = 64 + 430;
		}

		switch(extraSongArrayNum){
			case 0: songsForExtra.text = "Eye To Eye\n\nMy Horizon\n\nREROY???";
			case 1: songsForExtra.text = "Eye To Eye <\n\nMy Horizon\n\nREROY???";
			case 2: songsForExtra.text = "Eye To Eye\n\nMy Horizon <\n\nREROY???";
			case 3: songsForExtra.text = "Eye To Eye\n\nMy Horizon\n\nREROY??? <";
		}
		if(controls.BACK) FlxG.switchState(new MainMenuState());
	}

	if(extraSongArrayNum != 0) extrasEnabled = true;
	else extrasEnabled = false;
}