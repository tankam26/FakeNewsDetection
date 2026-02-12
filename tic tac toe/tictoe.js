let boxes=document.querySelectorAll(".box");
let reset=document.querySelector("#reset-btn");
let newGamebtn=document.querySelector("#new-btn");
let msgbox=document.querySelector(".msg-box");
let msg=document.querySelector("#msg");

let turn0=true;//player 1&2
let cnt=0;

const winPat=[
    [0,1,2],
    [0,3,6],
    [0,4,8],
    [1,4,7],
    [2,5,8],
    [2,4,6],
    [3,4,5],
    [6,7,8],
];


const resetGame=()=>{
   for (let box of boxes) {
        box.disabled = false;
        box.innerText = "";
        box.style.backgroundColor = "#FFFFFF"; // Reset background to white
    }
    msgbox.classList.add("hide");
    cnt=0;

}

boxes.forEach((box)=>{
    box.addEventListener("click",()=>{
        box.style.backgroundColor="#F4F8D3";
        if(turn0==true){
            box.innerText='O';
            turn0=false;
        }
        else{
            box.innerText='X';
            turn0=true;
        }
        box.disabled=true;
        cnt++;
        let iswin=checkWin();
        if(cnt===9 && !iswin){
            gameDraw();
        }
    });

});


const gameDraw=()=>{
  msg.innerText='Its a draw!';
  msgbox.classList.remove("hide");
  disableboxes();

            }



const disableboxes=()=>{
    for(let box of boxes){
        box.disabled=true;
    }
}

const enablebox=()=>{
    for(let box of boxes){
        box.disabled=false;
        box.innerText="";
    }
    

}

const showWinner = (winner) => {
    msg.innerText = `Congratulations, Winner is ${winner}`;
    msgbox.classList.remove("hide");
    disableboxes();
};


const checkWin=()=>{
    for(let pat of winPat){
        let pos1=boxes[pat[0]].innerText;
        let pos2=boxes[pat[1]].innerText;
        let pos3=boxes[pat[2]].innerText;
        if(pos1!="" && pos2!="" && pos3!=""){
            if(pos1===pos2 && pos3===pos2){
                console.log("winner",pos1);
                showWinner(pos1);
            }
           
        }
       

    }
     

}

newGamebtn.addEventListener("click",resetGame);
reset.addEventListener("click",resetGame);



