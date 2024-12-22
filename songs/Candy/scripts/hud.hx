function onStrumCreation(e)
    e.sprite = 'game/notes/heathersStrum';

function onNoteCreation(e) {
    e.noteSprite = 'game/notes/heathersStrum';
    e.note.splash = 'heathersSplashes';
}

function onNoteHit(e){
    if(e.character == strumLines.members[0].characters[0]){
        camGame.zoom += 0.015;
        camHUD.zoom += 0.015;
    }
}