var oneShotMisses:Int = 0;
var countLastNote:Bool = false;

function onCameraMove(_){
    _.cancelled = true;
    if(curCameraTarget == 0){
        boyfriend.alpha = 0;
        gf.alpha = 0;
        dad.alpha = 1;
    } else if(curCameraTarget == 1){
        boyfriend.alpha = 1;
        gf.alpha = 1;
        dad.alpha = 0;
    }

    camFollow.setPosition(620, 450);
    FlxG.camera.focusOn(camFollow.getPosition());
}

function create(){
    var dir = 'stages/beatus/';
    bg = new FlxSprite().loadGraphic(Paths.image(dir + 'bars'));
    bg.scale.set(3, 3);
    bg.screenCenter();
    bg.scrollFactor.set(0, 0);
    insert(0, bg);

    duckbg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, 0xFF5595DA);
    duckbg.setGraphicSize(Std.int(duckbg.width * 10));
    duckbg.alpha = 0;
    insert(0, duckbg);

    ducktree = new FlxSprite(-600, -100).loadGraphic(Paths.image(dir + 'tree'));
    ducktree.scrollFactor.set(0.6, 0.6);
    ducktree.scale.set(6.5, 6.5);
    ducktree.updateHitbox();
    ducktree.antialiasing = false;
    ducktree.visible = false;
    insert(0, ducktree);

    duckleafs = new FlxSprite(1600, 400).loadGraphic(Paths.image(dir + 'arbust'));
    duckleafs.scrollFactor.set(0.8, 0.8);
    duckleafs.scale.set(6.5, 6.5);
    duckleafs.updateHitbox();
    duckleafs.antialiasing = false;
    duckleafs.visible = false;
    insert(0, duckleafs);

    duckfloor = new FlxSprite(0, 550).loadGraphic(Paths.image(dir + 'grass'));
    duckfloor.scale.set(6.5, 6.5);
    duckfloor.updateHitbox();
    duckfloor.antialiasing = false;
    duckfloor.screenCenter(FlxAxes.X);
    duckfloor.alpha = 0;
    insert(0, duckfloor);

    bowbg = new FlxSprite(-700, -200).loadGraphic(Paths.image(dir + 'castle'));
    bowbg.scrollFactor.set(0.4, 0.4);
    bowbg.scale.set(5, 5);
    bowbg.updateHitbox();
    bowbg.antialiasing = false;
    bowbg.visible = false;
    insert(0, bowbg);

    bowbg2 = new FlxSprite(-700, -200).loadGraphic(Paths.image(dir + 'castle2'));
    bowbg2.scrollFactor.set(0.4, 0.4);
    bowbg2.scale.set(5, 5);
    bowbg2.updateHitbox();
    bowbg2.antialiasing = false;
    bowbg2.visible = false;
    insert(0, bowbg2);


    bowplat = new FlxSprite(800, 300).loadGraphic(Paths.image(dir + 'platnes'));
    bowplat.scrollFactor.set(0.5, 0.5);
    bowplat.scale.set(5, 5);
    bowplat.updateHitbox();
    bowplat.visible = false;
    bowplat.antialiasing = false;
    insert(0, bowplat);

    bowlava = new FlxSprite(-300, 900);
    bowlava.frames = Paths.getSparrowAtlas(dir + 'neslava');
    bowlava.scrollFactor.set(0.5, 0.5);
    bowlava.scale.set(5, 5);
    bowlava.updateHitbox();
    bowlava.animation.addByPrefix('idle', "lava hot ow ow its too hot aaa", 5, true);
    bowlava.animation.play('idle');
    bowlava.visible = false;
    bowlava.antialiasing = false;
    insert(0, bowlava);

    blackinfrontobowser = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackinfrontobowser.setGraphicSize(Std.int(blackinfrontobowser.width * 10));
    blackinfrontobowser.alpha = 1;
    insert(0, blackinfrontobowser);

    /*

    cutbg = new BGSprite(dir + 'staticbg', 800, 300, 0.2, 0.2, ['staticbg duck'], true);
    cutbg.scale.set(2.61, 2.61);
    cutbg.updateHitbox();
    cutbg.animation.addByPrefix('duck', "staticbg duck", 15, true);
    cutbg.animation.addByPrefix('bowser', "staticbg castle", 15, true);
    cutbg.visible = false;
    cutbg.screenCenter(XY);
    cutbg.antialiasing = ClientPrefs.globalAntialiasing;
    add(cutbg);

    cutskyline = new BGSprite(dir + 'staticbg', 800, 300, 0.2, 0.2, ['staticbg duck'], true);
    cutskyline.scale.set(2.61, 2.61);
    cutskyline.updateHitbox();
    cutskyline.animation.addByPrefix('duck', "staticbg duck", 15, true);
    cutskyline.animation.addByPrefix('bowser', "staticbg castle", 15, true);
    cutskyline.visible = false;
    cutskyline.screenCenter(XY);
    cutskyline.antialiasing = ClientPrefs.globalAntialiasing;
    add(cutskyline);

    cutstatic = new BGSprite(dir + 'static', 800, 300, 0.2, 0.2, ['static idle'], true);
    cutstatic.scale.set(1.3, 1.3);
    cutstatic.updateHitbox();
    cutstatic.visible = false;
    cutstatic.screenCenter(XY);
    cutstatic.antialiasing = ClientPrefs.globalAntialiasing;
    add(cutstatic);

    screencolor = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.RED);
    screencolor.setGraphicSize(Std.int(screencolor.width * 10));
    screencolor.alpha = 0;
    screencolor.scrollFactor.set(0, 0);
    add(screencolor);

    blackBarThingie = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
    blackBarThingie.setGraphicSize(Std.int(blackBarThingie.width * 10));
    blackBarThingie.alpha = 0;
    blackBarThingie.scrollFactor.set(0, 0);
    add(blackBarThingie);

    beatText = new FlxText(-230, 150, 1818, '', 24);
    beatText.setFormat(Paths.font("mariones.ttf"), 130, FlxColor.WHITE, CENTER);
    beatText.scrollFactor.set(0, 0);
    beatText.scale.set(1, 1.5);
    beatText.updateHitbox();
    beatText.screenCenter();
    add(beatText);

    ycbuLightningL = new BGSprite(dir + 'ycbu_lightning', 0, 0, 1, 1, ['lightning'], true);
    ycbuLightningL.animation.addByPrefix('idle', "lightning", 15, true);
    ycbuLightningL.animation.play('idle', true);
    ycbuLightningL.screenCenter(XY);
    ycbuLightningL.x -= 440;
    ycbuLightningL.antialiasing = ClientPrefs.globalAntialiasing;
    ycbuLightningL.visible = false;
    ycbuLightningL.cameras = [camEst];
    add(ycbuLightningL);

    ycbuLightningR = new BGSprite(dir + 'ycbu_lightning', 0, 0, 1, 1, ['lightning'], true);
    ycbuLightningR.animation.addByPrefix('idle', "lightning", 15, true);
    ycbuLightningR.flipY = true;
    ycbuLightningR.animation.play('idle', true);
    ycbuLightningR.screenCenter(XY);
    ycbuLightningR.x += 455;
    ycbuLightningR.antialiasing = ClientPrefs.globalAntialiasing;
    ycbuLightningR.visible = false;
    ycbuLightningR.cameras = [camEst];
    add(ycbuLightningR);

    ycbuHeadL = new FlxBackdrop(Y);
    ycbuHeadL.frames = Paths.getSparrowAtlas(dir + 'YouCannotBeatUS_Fellas_Assets');
    ycbuHeadL.animation.addByPrefix('LOL', "Rotat e", 24, true);
    ycbuHeadL.animation.addByPrefix('gyromite', "Bird Up", 24, false);
    ycbuHeadL.animation.addByPrefix('lakitu', "Lakitu", 24, false);
    ycbuHeadL.animation.play('LOL', true);
    ycbuHeadL.updateHitbox();
    ycbuHeadL.scale.set(0.6, 0.6);
    ycbuHeadL.screenCenter(X);
    ycbuHeadL.x -= 450;
    ycbuHeadL.flipX = true;
    ycbuHeadL.antialiasing = ClientPrefs.globalAntialiasing;
    ycbuHeadL.velocity.set(0, 600);
    ycbuHeadL.visible = false;
    ycbuHeadL.cameras = [camEst];
    add(ycbuHeadL);

    ycbuHeadR = new FlxBackdrop(Y);
    ycbuHeadR.frames = Paths.getSparrowAtlas(dir + 'YouCannotBeatUS_Fellas_Assets');
    ycbuHeadR.animation.addByPrefix('LOL', "Rotat e", 24, true);
    ycbuHeadR.animation.addByPrefix('gyromite', "Bird Up", 24, false);
    ycbuHeadR.animation.addByPrefix('lakitu', "Lakitu", 24, false);
    ycbuHeadR.animation.play('LOL', true);
    ycbuHeadR.updateHitbox();
    ycbuHeadR.scale.set(0.6, 0.6);
    ycbuHeadR.screenCenter(X);
    ycbuHeadR.x += 445;
    ycbuHeadR.antialiasing = ClientPrefs.globalAntialiasing;
    ycbuHeadR.velocity.set(0, -600);
    ycbuHeadR.visible = false;
    ycbuHeadR.cameras = [camEst];
    add(ycbuHeadR);

    ycbuCrosshair = new FlxSprite().loadGraphic(Paths.image(dir + 'duckCrosshair'));
    ycbuCrosshair.scale.set(28, 28);
    ycbuCrosshair.screenCenter(XY);
    ycbuCrosshair.cameras = [camEst];
    ycbuCrosshair.visible = false;
    add(ycbuCrosshair);

    estatica = new FlxSprite();
    if (ClientPrefs.lowQuality)
    {
        estatica.frames = Paths.getSparrowAtlas('modstuff/static');
        estatica.setGraphicSize(Std.int(estatica.width * 10));
    }
    else
    {
        estatica.frames = Paths.getSparrowAtlas('modstuff/Mario_static');
    }
    estatica.animation.addByPrefix('idle', "static play", 15);
    estatica.animation.play('idle');
    estatica.antialiasing = false;
    estatica.cameras = [camEst];
    estatica.alpha = 0.05;
    estatica.updateHitbox();
    estatica.screenCenter();
    add(estatica);

    ycbuWhite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
    ycbuWhite.setGraphicSize(Std.int(ycbuWhite.width * 10));
    ycbuWhite.alpha = 0;

    otherBeatText = new FlxText(-230, 150, 1818, '', 24);
    otherBeatText.setFormat(Paths.font("mariones.ttf"), 130, FlxColor.BLACK, CENTER);
    otherBeatText.scrollFactor.set(0, 0);
    otherBeatText.scale.set(1, 1.5);
    otherBeatText.updateHitbox();
    otherBeatText.screenCenter();
    // 21.5

    ycbuGyromite = new BGSprite(dir + 'YouCannotBeatUS_Fellas_Assets', 800, 1000, 1.1, 1.1, ['Bird Up'], false);
    ycbuGyromite.animation.addByPrefix('idle', "Bird Up", 24, false);
    ycbuGyromite.animation.play('idle', true);
    ycbuGyromite.antialiasing = ClientPrefs.globalAntialiasing;

    ycbuLakitu = new BGSprite(dir + 'YouCannotBeatUS_Fellas_Assets', 0, 1000, 1.1, 1.1, ['Lakitu'], false);
    ycbuLakitu.animation.addByPrefix('idle', "Lakitu", 24, false);
    ycbuLakitu.animation.play('idle', true);
    ycbuLakitu.antialiasing = ClientPrefs.globalAntialiasing;

    ycbuGyromite.visible = false;
    ycbuLakitu.visible = false;
    add(ycbuGyromite);
    add(ycbuLakitu);

    clownCar = new BGSprite(dir + 'Clown_Car', 0, 0, 1, 1, ['clown car anim'], true);
    clownCar.scale.set(55, 55);
    clownCar.antialiasing = false;
    clownCar.visible = false;
    add(clownCar);

    //funnylayer0 ycbu bowser
    funnylayer0 = new BGSprite('characters/YouCannotBeatUS_Bowser_Asset', 600, 100, 1, 1, ['Left']);
    funnylayer0.animation.addByPrefix('idle', 'Idle', 24, false);
    funnylayer0.animation.addByPrefix('singUP', 'Up', 24, false);
    funnylayer0.animation.addByPrefix('singDOWN', 'Down', 24, false);
    funnylayer0.animation.addByPrefix('singLEFT', 'Left', 24, false);
    funnylayer0.animation.addByPrefix('singRIGHT', 'Right', 24, false);
    funnylayer0.antialiasing = ClientPrefs.globalAntialiasing;
    funnylayer0.animation.play('idle');

    starmanGF = new BGSprite('characters/YouCannotBeatUS_GF_Assets', 400, 250, 1, 1, ["GF Dancing Beat"], false);
    starmanGF.animation.addByIndices('danceRight', 'GF Dancing Beat', [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14], "", 24, false);
    starmanGF.animation.addByIndices('danceLeft', 'GF Dancing Beat', [15,16,17,18,19,20,21,22,23,24,25,28,29], "", 24, false);
    starmanGF.animation.addByPrefix('hey', 'GF Cheer', 24, false);
    starmanGF.antialiasing = ClientPrefs.globalAntialiasing;
    add(starmanGF);

    //ycbu mrsys icon finale
    iconLG = new FlxSprite().loadGraphic(Paths.image('icons/icon-sys'));
    iconLG.width = iconLG.width / 2;
    iconLG.loadGraphic(Paths.image('icons/icon-sys'), true, Math.floor(iconLG.width), Math.floor(iconLG.height));
    iconLG.animation.add("win", [0], 10, true);
    iconLG.animation.add("lose", [1], 10, true);
    iconLG.cameras = [camHUD];
    iconLG.visible = false;
    iconLG.antialiasing = ClientPrefs.globalAntialiasing;
    
    //ycbu bowser icon finale
    iconW4 = new FlxSprite().loadGraphic(Paths.image('icons/icon-hunt'));
    iconW4.width = iconW4.width / 2;
    iconW4.loadGraphic(Paths.image('icons/icon-hunt'), true, Math.floor(iconW4.width), Math.floor(iconW4.height));
    iconW4.animation.add("win", [0], 10, true);
    iconW4.animation.add("lose", [1], 10, true);
    iconW4.cameras = [camHUD];
    iconW4.antialiasing = ClientPrefs.globalAntialiasing;
    iconW4.visible = false;

    //ycbu duck hunt icon finale
    iconY0 = new FlxSprite().loadGraphic(Paths.image('icons/icon-bowser'));
    iconY0.width = iconY0.width / 2;
    iconY0.loadGraphic(Paths.image('icons/icon-bowser'), true, Math.floor(iconY0.width), Math.floor(iconY0.height));
    iconY0.animation.add("win", [0], 10, true);
    iconY0.animation.add("lose", [1], 10, true);
    iconY0.cameras = [camHUD];
    iconY0.antialiasing = ClientPrefs.globalAntialiasing;
    iconY0.visible = false;

    ycbuIconPos1 = new FlxPoint(0, 0);
    ycbuIconPos2 = new FlxPoint(-85, 50);
    ycbuIconPos3 = new FlxPoint(-85, -50);

    lofiTweensToBeCreepyTo(bg);
    nesTimers.push(new FlxTimer().start(21.5, function(timer:FlxTimer)
    {
        lofiTweensToBeCreepyTo(bg);
    }, 0));

    */
}

function onPlayerMiss(_){
    if(!countLastNote) oneShotMisses += 1;
    if(countLastNote && oneShotMisses <= misses) health = 0;
    trace(oneShotMisses + ' | ' + misses);
}

function beatHit(){
    switch(curBeat){
        case 344: countLastNote = true;
        case 424: countLastNote = false;
    }
}