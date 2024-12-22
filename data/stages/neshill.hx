function create(){
    var dir = 'stages/neshill/';
    sky = new FlxSprite(500, 200).loadGraphic(Paths.image(dir + 'sky'));
    insert(0, sky);

    ground = new FlxSprite(500, 200).loadGraphic(Paths.image(dir + 'tlbg2'));
    ground.frames = Paths.getSparrowAtlas(dir + 'tlbg2');
	ground.animation.addByPrefix('idle', 'tlbg2', 12, true);
    ground.animation.play('idle');
    insert(1, ground);

    for(i in [sky, ground]){
        i.scale.set(8, 8);
        i.antialiasing = false;
    }
}