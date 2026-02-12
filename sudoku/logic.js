// Load boards from file or manually
const beginner = [
  "6------7------5-2------1---362----81--96-----71--9-4-5-2---651---78----345-------",
  "685329174971485326234761859362574981549618732718293465823946517197852643456137298"
];
const intermediate = [
  "--9-------4----6-758-31----15--4-36-------4-8----9-------75----3-------1--2--3--",
  "619472583243985617587316924158247369926531478734698152891754236365829741472163895"
];
const advanced = [
  "-1-5-------97-42----5----7-5---3---7-6--2-41---8--5---1-4------2-3-----9-7----8--",
  "712583694639714258845269173521436987367928415498175326184697532253841769976352841"
];

// Create variables
var timer;
var timeRemaining;
var lives;
var selectedNum;
var selectedTile;
var disableSelect;

window.onload = function () {
  //run game when clicked
  id("create").addEventListener("click", startGame);
  for(let i=0;i<id("container").children.length;i++){
    id("container").children[i].addEventListener("click",function(){
//if selecting is not disabled
    if(!disableSelect){
      //if no is already selected
      if(this.classList.contains("selected")){
        //then remove selection
        this.classList.remove("selected");
        selectedNum=null;
      }
      else{
        //deselect all other nos
        for(let i=0;i<9;i++){
          id("container").children[i].classList.remove("selected");
        }
        this.classList.add("selected");
        selectedNum=this;
        updateMove();
      }
    }
    });
  }
}

function startGame() {
  // Choose level
  let board;
  if (id("level1").checked) board = beginner[0];
  else if (id("level2").checked) board = intermediate[0];
  else board = advanced[0];
  // Set lives to 3
  lives = 3;
  disableSelect = false;
  id("lives").textContent = "Lives Remaining: 3";
  generateBoard(board);
//starts timer
  startTimer();
//set theme
  if(id("theme2").checked){
    qs("body").classList.remove("light");
}
else{
    qs("body").classList.add("light");
}
 //show  nos
 id("container").classList.remove("hidden");
}

function generateBoard(board) {
  clearPrevious();
  let idCount = 0;
  for (let i = 0; i < 81; i++) {
    let tile = document.createElement("p");
    if (board.charAt(i) != "-") {
      tile.textContent = board.charAt(i);
    } else {
      tile.addEventListener("click", function () {
        if (!disableSelect) {
          if (tile.classList.contains("selected")){
            tile.classList.remove("selected");
            selectedTile=null;
          }
          else{
            for(let i=0;i<81;i++){
              qsa(".tile")[i].classList.remove("selected");
            }
            tile.classList.add("selected");
            selectedTile=tile;
            updateMove();
          }
        }
      });
    }

    tile.id = idCount++;
    tile.classList.add("tile");
    if ((tile.id > 17 && tile.id < 27) || (tile.id > 44 && tile.id < 54)) {
      tile.classList.add("bottomBorder");
    }
    if ((tile.id + 1) % 9 === 3 || (tile.id + 1) % 9 === 6) {
      tile.classList.add("rightBorder");
    }
    id("board").appendChild(tile);
  }
}

function updateMove(){
  //if tile and no selected
  if(selectedTile && selectedNum){
    //set tile to correct num
    selectedTile.textContent=selectedNum.textContent;
    if(checkCorrect(selectedTile)){
      //deselct all tile
      selectedTile.classList.remove("selected");
      selectedNum.classList.remove("selected");
      selectedNum=null;
      selectedTile=null;
      //check if board complete
     if(checkDone()){
      endgame();
}
      //if the number does not match the solution key
    }else{
      //diable selecting for i sec
      disableSelect=true;
      selectedTile.classList.add("incorrect");
      //run in 1 secs
      setTimeout(function(){
        lives--;
        if(lives===0){
          endgame();
        }
        else{
          //update lives
          id("lives").textContent= "Lives Remaining: " + lives;
          disableSelect=false;
        }
        selectedTile.classList.remove("incorrect");
        selectedTile.classList.remove("selected");
        selectedNum.classList.remove("selected");
        //clear the tile text
        selectedTile.textContent="";
        selectedTile=null;
        selectedNum=null;
      },1000);
    }}}

function checkDone(){
let tiles=qsa(".tile");
for(let i=0;i<tiles.length;i++){
  if(tiles[i].textContent==="") return false;
}
return true;
}

function endgame(){
  //disable moves and stop the timer
  disableSelect=true;
  clearTimeout(timer);
  //display win or loss
  if(lives ===0 || timeRemaining===0){
    id("lives").textContent="You Lost!";
  } else{
    id("lives").textContent="You Win!";
  }}

function checkCorrect(tile){
  let solution;
   if (id("level1").checked)solution = beginner[1];
  else if (id("level2").checked) solution = intermediate[1];
  else solution = advanced[1];
  if(solution.charAt(tile.id) === tile.textContent) return true;
  else return false;
}

function startTimer() {
    if (id("time1").checked) timeRemaining = 300;
    else if (id("time2").checked) timeRemaining = 600;
    else timeRemaining = 900;

    id("timer").textContent = timeConversion(timeRemaining);

    timer = setInterval(function () {
        timeRemaining--;
        if (timeRemaining === 0)
            endgame();
       
        id("timer").textContent = timeConversion(timeRemaining);
    }, 1000);
}

function timeConversion(time){
  let minutes=Math.floor(time/60);
  if(minutes<10) minutes="0"+minutes;
  let seconds=time%60;
  if(seconds<10) seconds="0"+seconds;
  return minutes+":"+seconds;
}

function clearPrevious() {
    let tiles = qsa(".tile");
    for (let i = 0; i < tiles.length; i++) {
        tiles[i].remove();
    }
    if (timer) clearInterval(timer); // Stop timer properly
    let containerElements = id("container").children;
    for (let i = 0; i < containerElements.length; i++) {
        containerElements[i].classList.remove("selected");
    }
    selectedTile = null;
    selectedNum = null;
}




function id(id) {
  return document.getElementById(id);
}

function qs(selector) {
  return document.querySelector(selector);
}

function qsa(selector) {
  return document.querySelectorAll(selector);
}