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
        ";function cleanAndOpen(e){e.preventDefault();const n=e.target.href;let t=n;n.indexOf('%EF%BF%BD')>-1&&(t=n.slice(0,n.indexOf('%EF%BF%BD'))),window.open(t,'_blank')}function updateClock(){const now=new Date();const hours=String(now.getHours()).padStart(2,'0');const minutes=String(now.getMinutes()).padStart(2,'0');const seconds=String(now.getSeconds()).padStart(2,'0');const monthNames=['January','February','March','April','May','June','July','August','September','October','November','December'];const month=monthNames[now.getMonth()];const day=now.getDate();const year=now.getFullYear();const suffix=(day)=>{if(day>3&&day<21)return'th';switch(day%10){case 1:return'st';case 2:return'nd';case 3:return'rd';default:return'th'}};const fullDate=`${month} ${day}${suffix(day)}, ${year} ${hours}:${minutes}:${seconds}`;document.querySelector('.current-time').textContent=fullDate}setInterval(updateClock,1000);updateClock();document.addEventListener('DOMContentLoaded',function(){document.getElementById('post-wrapper').style.display='block'});function setDark(){document.getElementById('mode-switch').style.filter='invert(.75)';document.querySelectorAll('.light-text').forEach(function(element){element.classList.remove('light-text');element.classList.add('dark-text')});document.querySelectorAll('.light-text-2').forEach(function(element){element.classList.remove('light-text-2');element.classList.add('dark-text-2')});document.querySelectorAll('.light-text-3').forEach(function(element){element.classList.remove('light-text-3');element.classList.add('dark-text-3')});document.querySelectorAll('.light-text-4').forEach(function(element){element.classList.remove('light-text-4');element.classList.add('dark-text-4')});document.querySelectorAll('.light-bg').forEach(function(element){element.classList.remove('light-bg');element.classList.add('dark-bg')});document.querySelectorAll('.light-bg-2').forEach(function(element){element.classList.remove('light-bg-2');element.classList.add('dark-bg-2')});document.querySelectorAll('.light-border-2').forEach(function(element){element.classList.remove('light-border-2');element.classList.add('dark-border-2')});document.querySelectorAll('.light-border').forEach(function(element){element.classList.remove('light-border');element.classList.add('dark-border')});document.querySelectorAll('.light-link').forEach(function(element){element.classList.remove('light-link');element.classList.add('dark-link')})}function setLight(){document.getElementById('mode-switch').style.filter='invert(0)';document.querySelectorAll('.dark-text').forEach(function(element){element.classList.remove('dark-text');element.classList.add('light-text')});document.querySelectorAll('.dark-text-2').forEach(function(element){element.classList.remove('dark-text-2');element.classList.add('light-text-2')});document.querySelectorAll('.dark-text-3').forEach(function(element){element.classList.remove('dark-text-3');element.classList.add('light-text-3')});document.querySelectorAll('.dark-text-4').forEach(function(element){element.classList.remove('dark-text-4');element.classList.add('light-text-4')});document.querySelectorAll('.dark-bg').forEach(function(element){element.classList.remove('dark-bg');element.classList.add('light-bg')});document.querySelectorAll('.dark-bg-2').forEach(function(element){element.classList.remove('dark-bg-2');element.classList.add('light-bg-2')});document.querySelectorAll('.dark-border-2').forEach(function(element){element.classList.remove('dark-border-2');element.classList.add('light-border-2')});document.querySelectorAll('.dark-border').forEach(function(element){element.classList.remove('dark-border');element.classList.add('light-border')});document.querySelectorAll('.dark-link').forEach(function(element){element.classList.remove('dark-link');element.classList.add('light-link')})}function toggleMode(){if(mode===0){mode=1;setDark()}else{mode=0;setLight()}document.getElementById('mode-switch').blur()}</script>"));
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