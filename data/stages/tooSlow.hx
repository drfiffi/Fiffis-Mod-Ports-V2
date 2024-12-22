function postCreate(){
	for(i in [dad, boyfriend, gf]) remove(i);
	sSKY = new FlxSprite(-222, -16 + 150).loadGraphic(Paths.image('stages/SonicStages/SKY'));
	sSKY.antialiasing = true;
	sSKY.scrollFactor.set(1, 1);
	sSKY.active = false;
	add(sSKY);

	hills = new FlxSprite(-264, -156 + 150).loadGraphic(Paths.image('stages/SonicStages/HILLS'));
	hills.antialiasing = true;
	hills.scrollFactor.set(1.1, 1);
	hills.active = false;
	add(hills);

	bg2 = new FlxSprite(-345, -289 + 170).loadGraphic(Paths.image('stages/SonicStages/FLOOR2'));
	bg2.updateHitbox();
	bg2.antialiasing = true;
	bg2.scrollFactor.set(1.2, 1);
	bg2.active = false;
	add(bg2);

	bg = new FlxSprite(-297, -246 + 150).loadGraphic(Paths.image('stages/SonicStages/FLOOR1'));
	bg.antialiasing = true;
	bg.scrollFactor.set(1.3, 1);
	bg.active = false;
	add(bg);

	eggman = new FlxSprite(-218, -219 + 150).loadGraphic(Paths.image('stages/SonicStages/EGGMAN'));
	eggman.updateHitbox();
	eggman.antialiasing = true;
	eggman.scrollFactor.set(1.32, 1);
	eggman.active = false;

	add(eggman);

	tail = new FlxSprite(-199 - 150, -259 + 150).loadGraphic(Paths.image('stages/SonicStages/TAIL'));
	tail.updateHitbox();
	tail.antialiasing = true;
	tail.scrollFactor.set(1.34, 1);
	tail.active = false;

	add(tail);

	knuckle = new FlxSprite(185 + 100, -350 + 150).loadGraphic(Paths.image('stages/SonicStages/KNUCKLE'));
	knuckle.updateHitbox();
	knuckle.antialiasing = true;
	knuckle.scrollFactor.set(1.36, 1);
	knuckle.active = false;

	add(knuckle);

	sticklol = new FlxSprite(-100, 50);
	sticklol.frames = Paths.getSparrowAtlas('stages/SonicStages/TailsSpikeAnimated');
	sticklol.animation.addByPrefix('a', 'Tails Spike Animated instance 1', 4, true);
	sticklol.setGraphicSize(Std.int(sticklol.width * 1.2));
	sticklol.updateHitbox();
	sticklol.antialiasing = true;
	sticklol.scrollFactor.set(1.37, 1);

	add(sticklol);

	sticklol.animation.play('a', true);

	for(i in [gf, dad, boyfriend]){
		add(i);
		i.scrollFactor.set(1.37, 1);
	}
}