import openfl.geom.Rectangle;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
import flixel.FlxG;

import flixel.util.FlxStringUtil;

public var timeBarBG:FlxSprite;
public var timeBar:FlxBar;
public var timeTxt:FlxText;

public var allowWech:Bool = true;

function postCreate(){
    for(i in [healthBarBG, scoreTxt, missesTxt, accuracyTxt, comboGroup]) remove(i);
    doIconBop = false;

    healthBarBGNew = new FlxSprite(0, 0).loadGraphic(Paths.image('huds/Illegal Instruction/healthBar'));
    healthBarBGNew.camera = camHUD;
    healthBarBGNew.screenCenter();
    healthBarBGNew.y = FlxG.height * 0.89;
    insert(25, healthBarBGNew);

    timeTxt = new FlxText(42 + (FlxG.width / 2) - 248, 14, 400, 'M:SS', 32);
    timeTxt.setFormat(Paths.font('chaotix.ttf'), 32, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    timeTxt.borderSize = 2;
    timeTxt.camera = camHUD;

    timeBarBG = new FlxSprite(timeTxt.x, (timeTxt.y + (timeTxt.height / 4)) - 4).loadGraphic(Paths.image('huds/PsychEngine/timeBar'));
    timeBarBG.color = FlxColor.BLACK;
    timeBarBG.camera = camHUD;
    add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, FlxBar.FILL_LEFT_TO_RIGHT, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
    timeBar.createFilledBar(0xFF000000,0xFFFFFFFF);
    timeBar.numDivisions = 200;
    timeBar.value = Conductor.songPosition / Conductor.songDuration;
    timeBar.camera = camHUD;
    add(timeBar);

    add(timeTxt);

    healthBar.x = healthBarBGNew.x + 4;
    healthBar.y = healthBarBGNew.y + 2.5;

    healthBarOver = new FlxSprite(healthBar.x - 4, healthBar.y - 4.9).loadGraphic(Paths.image('huds/Illegal Instruction/healthBarOver'));
    healthBarOver.camera = camHUD;
    insert(31, healthBarOver);

    songNameHUD = new FlxText(0, healthBarBGNew.y + 36, FlxG.width, SONG.meta.name, 20);
    songNameHUD.setFormat(Paths.font('chaotix.ttf'), 20, 0xFFFFFFFF, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songNameHUD.camera = camHUD;
    songNameHUD.borderSize = 1.25;
    add(songNameHUD);
}

function postUpdate(){
    iconP1.setPosition(850, healthBar.y - 75);
    iconP2.setPosition(250, healthBar.y - 75);
}

function update(elapsed){
    for(icon in [iconP1, iconP2]) icon.scale.set(lerp(icon.scale.x, 0.9, 0.33), lerp(icon.scale.y, 0.9, 0.33));
    if (inst != null && timeBar != null && timeBar.max != inst.length) timeBar.setRange(0, Math.max(1, inst.length));
    timeTxt.text = FlxStringUtil.formatTime((inst.length-inst.time) / 1000, false);
}

function onStrumCreation(_) if(_.player == 0 && allowWech) _.sprite = 'game/notes/NOTE_wech';

function onNoteCreation(_) if(_.note.strumLine == cpuStrums) _.noteSprite = 'game/notes/NOTE_wech';

function onPlayerHit(_){
    _.showSplash = false;
    iconP1.scale.set(1.1, 1.1); 
}

function onDadHit() iconP2.scale.set(1.1, 1.1);

function beatHit() for(icon in [iconP1, iconP2]) icon.scale.set(1.1, 1.1);