import flixel.text.FlxTextBorderStyle;

var originalX:Float;         var customAccuracy:Float = 0; var finalAccuracy:Float = 0;   var noteHits:Int = 0; 
var sicks:Int = 0;           var goods:Int = 0;            var bads:Int = 0;              var shits:Int = 0;             
var firstHit:Bool = false;   var rankingA:String;          var rankingB:String;           var bfCurSinging:Bool = false; 
var dadCursedTimer:FlxTimer; var lolShit:Bool = false;     var fuckYouDad:Bool;           var helpStep:Int = 0;

var allowDadControl:Bool = true;

function postCreate(){
    dad.holdTime = 4;

    scoreText = new FlxText(FlxG.width / 2 - 235, healthBarBG.y + 50, 0, "", 20);
    scoreText.screenCenter(FlxAxes.X);
    originalX = scoreText.x;
    scoreText.camera = camHUD;
    scoreText.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    insert(members.indexOf(scoreTxt) - 2, scoreText);

    songInfo = new FlxText(4, healthBarBG.y + 50, 0, SONG.meta.name + " - " + PlayState.difficulty + " | KE 1.5.4", 20);
    songInfo.y = scoreText.y;
    songInfo.camera = camHUD;
    songInfo.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, "left", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    insert(members.indexOf(scoreText), songInfo);

    for(i in [accuracyTxt, scoreTxt, missesTxt]) remove(i);

    doIconBop = false;

    comboGroup.x = 560;
    comboGroup.y = 290;

    boyfriend.debugMode = true;
}

function update(){
    if(!firstHit){ 
        finalAccuracy = 0;      rankingA = "";      rankingB = "N/A";
    } else {
        finalAccuracy = (customAccuracy / noteHits);
        if(finalAccuracy >= .999935) rankingB = " AAAAA";
        else if(finalAccuracy >= .99980) rankingB = " AAAA:";
        else if(finalAccuracy >= .99970) rankingB = " AAAA.";
        else if(finalAccuracy >= .99955) rankingB = " AAAA";
        else if(finalAccuracy >= .9990) rankingB = " AAA:";
        else if(finalAccuracy >= .998) rankingB = " AAA.";
        else if(finalAccuracy >= .997) rankingB = " AAA";
        else if(finalAccuracy >= .99) rankingB = " AA:";
        else if(finalAccuracy >= .965) rankingB = " AA.";
        else if(finalAccuracy >= .93) rankingB = " AA";
        else if(finalAccuracy >= .90) rankingB = " A:";
        else if(finalAccuracy >= .85) rankingB = " A.";
        else if(finalAccuracy >= .80) rankingB = " A";
        else if(finalAccuracy >= .70) rankingB = " B";
        else if(finalAccuracy >= .60) rankingB = " C";
        else rankingB = " D";
        if(PlayState.botplay) rankingA = "BotPlay";

        if (misses == 0 && bads == 0 && shits == 0 && goods == 0) rankingA = "(MFC)";
        else if (misses == 0 && bads == 0 && shits == 0 && goods >= 1) rankingA = "(GFC)";
        else if (misses == 0) rankingA = "(FC)";
        else if (misses < 10) rankingA = "(SDCB)";
        else rankingA = "(Clear)";
    }
    scoreText.text = "Score:" + songScore + " | Combo Breaks:" + misses + " | Accuracy:" + CoolUtil.quantize(finalAccuracy * 100, 100) + " % | " + rankingA + "" + rankingB;

    var lengthInPx = scoreText.textField.length * scoreText.frameHeight;
    scoreText.x = (originalX - (lengthInPx / 2)) + 360;

    for(icon in [iconP1, iconP2]){
        icon.setGraphicSize(Std.int(FlxMath.lerp(150, iconP1.width, 0.50))); icon.updateHitbox();
    }

    comboGroup.forEachAlive(function(spr) if (spr.camera != camHUD) spr.camera = camHUD);

    if(playerStrums.members[0].animation.curAnim.name == 'confirm' || playerStrums.members[1].animation.curAnim.name == 'confirm' || playerStrums.members[2].animation.curAnim.name == 'confirm' || playerStrums.members[3].animation.curAnim.name == 'confirm'){
        bfCurSinging = true;
        lolShit = true;
    }
    if(playerStrums.members[0].animation.curAnim.name == 'static' && playerStrums.members[1].animation.curAnim.name == 'static' && playerStrums.members[2].animation.curAnim.name == 'static' && playerStrums.members[3].animation.curAnim.name == 'static') 
        bfCurSinging = false;
    if(bfCurSinging){
        if(playerStrums.members[0].animation.curAnim.name == 'pressed' || playerStrums.members[1].animation.curAnim.name == 'pressed' || playerStrums.members[2].animation.curAnim.name == 'pressed' || playerStrums.members[3].animation.curAnim.name == 'pressed'){
            bfCurSinging = true;
            lolShit = true;
        }
    }
}

function onPostStrumCreation(_){ for(i in 0...4){ cpuStrums.members[i].x = 50 + i * 113; playerStrums.members[i].x = 700 + i * 113; }}

function onPlayerHit(_){
    if (_.note.isSustainNote){
        customAccuracy += 1;        _.healthGain = 0;
    } else if(!_.note.isSustainNote){
        switch(_.rating){
            case 'sick': customAccuracy += 1;    sicks += 1;
            case 'good': customAccuracy += 0.75; goods += 1;
            case 'bad':  customAccuracy += 0.5;  bads  += 1;
            case 'shit': customAccuracy += 0.25; shits += 1;
        }
    }
    _.showSplash = false;
    noteHits += 1;
    if(!finalAccuracy) firstHit = true;
    helpStep = Conductor.curStep + 1;
}

function onPlayerMiss(_){ 
    noteHits += 1;      lolShit = true;         helpStep = Conductor.curStep + 4;
} 

function onDadHit(_) _.strumGlowCancelled = true;

function beatHit(){
    if(SONG.meta.name == 'too-slow'){
        if(curBeat == 326) allowDadControl = false;
        if(curBeat == 358) allowDadControl = true;
    }

    if(curCameraTarget == 1 && allowDadControl){
        if(dad.getAnimName() != 'idle'){
            fuckYouDad = true; dad.playAnim('idle');
        }
            
    }
        
    if(curBeat % 2 == 0) if(!bfCurSinging && !lolShit) boyfriend.playAnim('idle');

    for(icon in [iconP1, iconP2]){
        icon.setGraphicSize(Std.int(iconP1.width + 30)); icon.updateHitbox();
    }
}

function stepHit(){
    if(curStep % 4 == 0){
        if(helpStep <= curStep){
            if(!bfCurSinging && lolShit){
                boyfriend.playAnim('idle');
                lolShit = false;
            }
            
        }
    }
}

function onInputUpdate(_) {
    if (_.strumLine == cpuStrums && fuckYouDad){
        _.cancelled = true;
        dadCursedTimer = new FlxTimer().start(0.2, function(){
            fuckYouDad = false; _.cancelled = false;
        });
    } 
}