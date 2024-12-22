import flixel.util.FlxTimer;

var camOther:FlxCamera;

introLength = 2.5;
function onCountdown(event) event.cancel();

function create(){
    camOther = new FlxCamera(0, 0, 1280, 720);
    camOther.bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.add(camOther, false);

    titleCard = new FlxSprite(0, 0);
    titleCard.frames = Paths.getSparrowAtlas('huds/Illegal Instruction/titlecard/my-horizon_title_card');
    titleCard.animation.addByPrefix('intro', 'my-horizon_title', 24, false);
    titleCard.camera = camOther;
    titleCard.alpha = 0;
    add(titleCard);

    bg = new FlxSprite(0, 0);
	bg.makeGraphic(1280, 720, 0xFF000000);
    bg.camera = camOther;
    insert(0, bg);

    new FlxTimer().start(1, function(tmr:FlxTimer){
            FlxTween.tween(titleCard, {alpha: 1}, 0.5, {ease: FlxEase.cubeInOut});
    });

        new FlxTimer().start(2.2, function(tmr:FlxTimer)
        {
            FlxTween.tween(bg, {alpha: 0}, 2, {
                onComplete: function(twn:FlxTween)
                {
                    remove(bg);
                    bg.destroy();
                    titleCard.animation.play('intro');
                }
            });
            FlxTween.tween(titleCard, {alpha: 1}, 4, {
                onComplete: function(twn:FlxTween)
                {
                    remove(titleCard);
                    titleCard.destroy();
                }
            });
        });
}