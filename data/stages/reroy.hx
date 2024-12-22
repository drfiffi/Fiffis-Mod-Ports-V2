import openfl.display.BlendMode;

function create(){
    camOther = new FlxCamera();
    camOther.bgColor = 0;
    FlxG.cameras.add(camOther, false);

    bg = new FlxSprite(-500, -100).loadGraphic(Paths.image('stages/REROY!!!!!/bg'));
    bg.setGraphicSize(2560);
    bg.updateHitbox();
    insert(0, bg);
    
    floor = new FlxSprite(-500, -100).loadGraphic(Paths.image('stages/REROY!!!!!/floor'));
    floor.setGraphicSize(2560);
    floor.updateHitbox();
    insert(1, floor);

    smoke = new FlxSprite(-500, -100).loadGraphic(Paths.image('stages/REROY!!!!!/smoke'));
    smoke.setGraphicSize(2560);
    smoke.updateHitbox();
    smoke.blend = BlendMode.ADD;				
    add(smoke);

    reroyexplodes = new FlxSprite().loadGraphic(Paths.image('stages/REROY!!!!!/bl'),true,90,125);
    reroyexplodes.animation.add('explode',[0,1,2,3,4,5,6,7,8,9,10,11,12,12,12,12,12,12,12,12],12,false);
    reroyexplodes.setGraphicSize(2560);
    reroyexplodes.screenCenter();
    insert(100, reroyexplodes);
    reroyexplodes.camera = camOther;

    FlxG.mouse.visible = false;
}

function stepHit(){
    if(curStep == 1338) reroyexplodes.animation.play('explode');
}