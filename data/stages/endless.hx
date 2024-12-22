function stepHit(){
    if(curStep % 4 == 0) majinPillar.animation.play("sonicboppers", true);
}

function postUpdate(){
    iconP2.animation.curAnim.curFrame = 0;
}