function onStrumCreation(e) {
    e.sprite = 'game/notes/MM_assets';
}

function onNoteCreation(e) {
    e.noteSprite = 'game/notes/MM_assets';
}

function postCreate(){
    newHud = new FlxSprite(0, 0).loadGraphic(Paths.image("huds/Mario's Madness/healthBarNEW"));
    newHud.scale.set(1.01, 1);
    newHud.screenCenter();
    newHud.y = 642;
    newHud.cameras = [camHUD];
    insert(members.indexOf(iconP1), newHud);

    remove(scoreTxt);
    remove(missesTxt);
    remove(accuracyTxt);
    remove(healthBarBG);
}

function onPlayerHit(event:NoteHitEvent) event.ratingSuffix = "MM";