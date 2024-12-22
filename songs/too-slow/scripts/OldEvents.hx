var daJumpscare:FlxSprite;
var loadedStaticA:Bool = false;
var loadedStaticB:Bool = false;
var simpleTimer:FlxTimer;
var staticTimer:FlxTimer;

function create(){
    daJumpscare = new FlxSprite(0, 0);
    daJumpscare.frames = Paths.getSparrowAtlas('EXEAssets/sonicJUMPSCARE');
    daJumpscare.animation.addByPrefix('jump','sonicSPOOK',24, false);
    
    daJumpscare.screenCenter();

    daJumpscare.scale.x = 1.1;
    daJumpscare.scale.y = 1.1;

    daJumpscare.y += 370;

    daJumpscare.camera = camHUD;
    daJumpscare.alpha = 0;

    add(daJumpscare);
}

function stepHit(){
    switch (curStep){
            case 27 | 130 | 265 | 450 | 645 | 800 | 855 | 889 | 938 | 981 | 1030 | 1065 | 1105 | 1123 | 1245 | 1345 | 1432 | 1454 | 1495 | 1521 | 1558 | 1578 | 1599 | 1618 | 1647 | 1657 | 1692 | 1713 | 1738 | 1747 | 1761 | 1785 | 1806 | 1816 | 1832 | 1849 | 1868 | 1887 | 1909 : doStaticSign();
            case 921 | 1178 | 1337: doSimpleJump();
            case 1723: doJumpscare();
        }
}

function doSimpleJump(){
    var simplejump:FlxSprite = new FlxSprite().loadGraphic(Paths.image('EXEAssets/simplejump'));
    simplejump.setGraphicSize(FlxG.width, FlxG.height);
    simplejump.screenCenter();
    simplejump.camera = camHUD;
    FlxG.camera.shake(0.0025, 0.50);
    add(simplejump);

    FlxG.sound.play(Paths.sound('sppok'), 1);
    new FlxTimer().start(0.2, function(tmr:FlxTimer){
        remove(simplejump);
    });
    //now for static (edit from fiffi: FUCK YOU OG EXE DEVS!!! JUST PUT THE DAMN FUNCTION AGAIN B<
    doStaticSign();
}

function doStaticSign(){
    var daStatic:FlxSprite = new FlxSprite(0, 0);
    daStatic.frames = Paths.getSparrowAtlas('EXEAssets/daSTAT');
    daStatic.setGraphicSize(FlxG.width, FlxG.height);
    daStatic.screenCenter();
    daStatic.camera = camHUD;
    daStatic.animation.addByPrefix('static','staticFLASH',24, false);
    add(daStatic);

    FlxG.sound.play(Paths.sound('staticBUZZ'));

    if (daStatic.alpha != 0) daStatic.alpha = FlxG.random.float(0.1, 0.5);

    daStatic.animation.play('static');

    daStatic.animation.finishCallback = function(pog:String){
        remove(daStatic);
    }
}

function doJumpscare(){
    daJumpscare.alpha = 1;
    daJumpscare.animation.play('jump');

    daJumpscare.animation.finishCallback = function(pog:String){
        remove(daJumpscare);
        daJumpscare.kill();
    }

    FlxG.sound.play(Paths.sound('jumpscare'), 1);
    FlxG.sound.play(Paths.sound('datOneSound'), 1);
}