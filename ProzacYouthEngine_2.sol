// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./ProzacYouthUtils.sol";

//@developed by andrew mitchell (andrewmitchell.eth)
//This is the engine for creating the animation url's script tag.
contract ProzacYouthEngine_2 {
    ProzacYouthUtils ProzacYouthUtils1;
    address public owner;
    mapping(address => bool) public accessList;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    modifier onlyAuthorized() {
        require(msg.sender == owner || accessList[msg.sender], "Not authorized");
        _;
    }

    constructor(address ProzacYouthUtils_addr) {
        owner = msg.sender;
        ProzacYouthUtils1 = ProzacYouthUtils(ProzacYouthUtils_addr);
        accessList[0xF1Da6E2d387e9DA611dAc8a7FC587Eaa4B010013] = true; // Adding default wallet to accessList
    }

    function getScript() public view returns (string memory) {
        return string(abi.encodePacked("<script type='text/javascript'>let mode="
        ,ProzacYouthUtils1.getModeRaw(),
        ";function updateClock(){const now=new Date();const hours=String(now.getHours()).padStart(2,'0');const minutes=String(now.getMinutes()).padStart(2,'0');const seconds=String(now.getSeconds()).padStart(2,'0');const monthNames=['January','February','March','April','May','June','July','August','September','October','November','December'];const month=monthNames[now.getMonth()];const day=now.getDate();const year=now.getFullYear();const suffix=(day)=>{if(day>3&&day<21)return'th';switch(day%10){case 1:return'st';case 2:return'nd';case 3:return'rd';default:return'th'}};const fullDate=`${month} ${day}${suffix(day)}, ${year} ${hours}:${minutes}:${seconds}`;document.querySelector('.current-time').textContent=fullDate}setInterval(updateClock,1000);updateClock();document.addEventListener('DOMContentLoaded',function(){document.getElementById('post-wrapper').style.display='block'});function setDark(){document.getElementById('paper-background').style.filter='invert(1)';document.getElementById('mode-switch').style.filter='invert(.75)';document.querySelectorAll('.light-text').forEach(function(element){element.classList.remove('light-text');element.classList.add('dark-text')});document.querySelectorAll('.light-text-2').forEach(function(element){element.classList.remove('light-text-2');element.classList.add('dark-text-2')});document.querySelectorAll('.light-text-3').forEach(function(element){element.classList.remove('light-text-3');element.classList.add('dark-text-3')});document.querySelectorAll('.light-text-4').forEach(function(element){element.classList.remove('light-text-4');element.classList.add('dark-text-4')});document.querySelectorAll('.light-bg').forEach(function(element){element.classList.remove('light-bg');element.classList.add('dark-bg')});document.querySelectorAll('.light-bg-2').forEach(function(element){element.classList.remove('light-bg-2');element.classList.add('dark-bg-2')});document.querySelectorAll('.light-border-2').forEach(function(element){element.classList.remove('light-border-2');element.classList.add('dark-border-2')});document.querySelectorAll('.light-border').forEach(function(element){element.classList.remove('light-border');element.classList.add('dark-border')});document.querySelectorAll('.light-link').forEach(function(element){element.classList.remove('light-link');element.classList.add('dark-link')})}function setLight(){document.getElementById('paper-background').style.filter='invert(0)';document.getElementById('mode-switch').style.filter='invert(0)';document.querySelectorAll('.dark-text').forEach(function(element){element.classList.remove('dark-text');element.classList.add('light-text')});document.querySelectorAll('.dark-text-2').forEach(function(element){element.classList.remove('dark-text-2');element.classList.add('light-text-2')});document.querySelectorAll('.dark-text-3').forEach(function(element){element.classList.remove('dark-text-3');element.classList.add('light-text-3')});document.querySelectorAll('.dark-text-4').forEach(function(element){element.classList.remove('dark-text-4');element.classList.add('light-text-4')});document.querySelectorAll('.dark-bg').forEach(function(element){element.classList.remove('dark-bg');element.classList.add('light-bg')});document.querySelectorAll('.dark-bg-2').forEach(function(element){element.classList.remove('dark-bg-2');element.classList.add('light-bg-2')});document.querySelectorAll('.dark-border-2').forEach(function(element){element.classList.remove('dark-border-2');element.classList.add('light-border-2')});document.querySelectorAll('.dark-border').forEach(function(element){element.classList.remove('dark-border');element.classList.add('light-border')});document.querySelectorAll('.dark-link').forEach(function(element){element.classList.remove('dark-link');element.classList.add('light-link')})}window.onresize=function(){location.reload()}function toggleMode(){if(mode===0){mode=1;setDark()}else{mode=0;setLight()}document.getElementById('mode-switch').blur()}window.onload=function(){const canvas=document.getElementById('notepadCanvas');const ctx=canvas.getContext('2d');const paperBackgroundDiv=document.getElementById('paper-background');canvas.width=window.innerWidth;canvas.height=window.innerHeight;const lineSpacing=24;const lineColor='#d3d3d3';function drawLines(){ctx.lineWidth=1;ctx.strokeStyle=lineColor;for(let y=lineSpacing;y<canvas.height;y+=lineSpacing){ctx.beginPath();ctx.moveTo(0,y);ctx.lineTo(canvas.width,y);ctx.stroke()}}function addNoise(){const imageData=ctx.getImageData(0,0,canvas.width,canvas.height);const pixels=imageData.data;for(let i=0;i<pixels.length;i+=4){const noise=Math.random()*30-15;pixels[i]+=noise;pixels[i+1]+=noise;pixels[i+2]+=noise}ctx.putImageData(imageData,0,0)}function fade(t){return t*t*t*(t*(t*6-15)+10)}function lerp(t,a,b){return a+t*(b-a)}function grad(hash,x,y){const h=hash&3;const u=h<2?x:y;const v=h<2?y:x;return((h&1)===0?u:-u)+((h&2)===0?v:-v)}function perlinNoise(x,y){const X=Math.floor(x)&255;const Y=Math.floor(y)&255;x-=Math.floor(x);y-=Math.floor(y);const u=fade(x);const v=fade(y);const a=p[X]+Y;const aa=p[a];const ab=p[a+1];const b=p[X+1]+Y;const ba=p[b];const bb=p[b+1];return lerp(v,lerp(u,grad(p[aa],x,y),grad(p[ba],x-1,y)),lerp(u,grad(p[ab],x,y-1),grad(p[bb],x-1,y-1)))}function generatePerlinNoise(width,height,ctx){const imageData=ctx.createImageData(width,height);const pixels=imageData.data;for(let y=0;y<height;y++){for(let x=0;x<width;x++){const value=Math.abs(perlinNoise(x*0.01,y*.03)*255);const index=(y*width+x)*8;pixels[index]=value;pixels[index+1]=0;pixels[index+2]=0;pixels[index+3]=196}}ctx.putImageData(imageData,0,0)}const p=[];for(let i=0;i<256;i++){p[i]=i}for(let i=0;i<256;i++){const j=Math.floor(Math.random()*256);[p[i],p[j]]=[p[j],p[i]]}for(let i=0;i<256;i++){p[256+i]=p[i]}ctx.fillStyle='#fff8dc';ctx.fillRect(0,0,canvas.width,canvas.height);drawLines();addNoise();drawLines();const tempCanvas=document.createElement('canvas');tempCanvas.width=canvas.width;tempCanvas.height=canvas.height;const tempContext=tempCanvas.getContext('2d');tempContext.filter='blur(15px)';generatePerlinNoise(canvas.width,canvas.height,tempContext);ctx.globalAlpha=.2;ctx.drawImage(tempCanvas,0,0);const dataURL=canvas.toDataURL('image/png');paperBackgroundDiv.style.backgroundImage=`url(${dataURL})`;paperBackgroundDiv.style.backgroundRepeat='repeat';paperBackgroundDiv.style.backgroundSize='auto';document.getElementById('paper-background').style.height=getComputedStyle(document.getElementsByTagName('html')[0]).height;document.getElementById('paper-background').style.width=getComputedStyle(document.getElementsByTagName('html')[0]).width;toggleMode()};</script>"));
    }

        function setProzacYouthUtils_1(address addr) public onlyAuthorized {
        ProzacYouthUtils1 = ProzacYouthUtils(addr);
    }

    function grantAccess(address _address) external onlyOwner {
        accessList[_address] = true;
    }

    function revokeAccess(address _address) external onlyOwner {
        accessList[_address] = false;
    }
}