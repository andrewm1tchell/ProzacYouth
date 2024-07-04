// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./ProzacYouthUtils.sol";

//@developed by andrew mitchell (andrewmitchell.eth)
//This is the engine for creating the animation url's html header and html footer.
contract ProzacYouthEngine_1 {
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

    function getAnimHeader() public view returns (string memory) {
         return 
              string(abi.encodePacked(
    "<!doctypehtml><html lang=en><meta content='text/html; charset=UTF-8'http-equiv=Content-Type><meta content='width=device-width,initial-scale=1'name=viewport><meta content='ie=edge'http-equiv=X-UA-Compatible><meta developer='Andrew Mitchell'><meta artist=Tjo><title>Prozac Youth</title>"
    ,"<style>body{font-family:Helvetica,sans-serif;font-size:10pt;margin:0;padding:5px}.andrews-container{margin:auto;width:100%}@media only screen and (max-width:600px){.andrews-container{width:100%}}.table{margin:20px auto;width:100%;border-collapse:collapse}@media only screen and (max-width:600px){.table{width:100%}}.fade-in{opacity:1;animation-name:fadeInOpacity;animation-iteration-count:1;animation-timing-function:ease-in;animation-duration:2s}@keyframes fadeInOpacity{0%{opacity:0}100%{opacity:1}}#loading-text{font-size:10pt;text-align:right}#loading{width:100%}.header-title{font-size:16pt;font-weight:700;text-align:center;background-color:#28403e;padding:10px 0;border-radius:5px}.breadcrumbs{font-size:9pt;color:#777;margin-bottom:10px}#mode-switch{cursor:pointer;position:fixed;bottom:10px;right:10px}.forum-rules{border-radius:5px;padding:10px;font-size:9pt;margin-bottom:20px}.table-header,.table-row{padding:8px}.table-header{background-color:#28403e;font-weight:700}.table>.light-bg:nth-child(even){background-color:rgba(0,0,0,0)!important}.light-bg{background-color:rgba(0,0,0,0)!important}.light-link{color:#a31414!important}.light-border{border:1px solid #28403e!important}.light-border-2{border:1px solid #627876!important}.light-bg-2{background-color:#c4c0bd!important}.light-text{color:#fafafa!important}.light-text-2{color:#0a0a0f!important}.error-text{color:#f03}.dark-link{color:#a4cbc4!important}.dark-text-2{color:#cdcdcd!important}.light-text-3{color:#0d0d14!important}.dark-text-3{color:#cdcdcd!important}.light-text-4{color:#0d0d14!important}.dark-text-4{color:#cdcdcd!important}.table>.dark-bg:nth-child(even){background-color:rgba(0,0,0,0)!important}.dark-bg{background-color:rgba(0,0,0,0)!important}.dark-border{border:1px solid #555!important}.dark-border-2{border:1px solid #333!important}.dark-bg-2{background-color:#444!important}.dark-text{color:#c8c8c8!important}.post-wrapper{display:none}.small-text{font-size:8pt;color:#555}.current-time{font-size:8pt;color:#777;vertical-align:super;margin-right:2px}#table-body{table-layout:fixed}.time-wrapper{display:inline}.loading-cell{display:flex;border:0;text-align:right}.post-info{display:flex;justify-content:space-between;align-items:center}.post-info span{font-size:10pt;color:#28403e;font-weight:700}.post-message{font-size:10pt;line-height:1.5}.footer{margin-top:20px;text-align:center;font-size:9pt;color:#777}#paper-background{position:absolute;background-size:cover;z-index:-1000;top:0;left:0;width:100%;height:100%}</style><body class='light-text-2 light-bg'><div class='fade-in post-wrapper'id=post-wrapper><div class=base64 id=paper-background></div><div class='light-text-2 andrews-container'><div class=breadcrumbs>Prozac Youth > Forums > TJO > Dear Human</div><div class=post-info><span class=light-text-2>Total Posts: <b id=total-posts>"
    ,ProzacYouthUtils1.getTotalEntries(),
    "</b></span><span class='current-time light-text-2'></span></div><table class=table style=table-layout:fixed><thead><tr class='light-border light-text table-header'><th colspan=1>Author<th colspan=3>Thread<tbody id=table-body><tr class='light-border light-bg table-row'><td colspan=1><td colspan=3>"
    ,ProzacYouthUtils1.getEntriesHTML(),
    "</tbody></table><span id=mode-switch onclick=toggleMode()><svg fill=#000000 height=15px id=Capa_1 version=1.1 viewBox='0 0 207.628 207.628'width=15px xml:space=preserve xmlns=http://www.w3.org/2000/svg xmlns:xlink=http://www.w3.org/1999/xlink><circle cx=103.814 cy=103.814 r=45.868 /><path d='M103.814,157.183c-29.427,0-53.368-23.941-53.368-53.368s23.941-53.368,53.368-53.368s53.368,23.941,53.368,53.368  S133.241,157.183,103.814,157.183z M103.814,65.446c-21.156,0-38.368,17.212-38.368,38.368s17.212,38.368,38.368,38.368  s38.368-17.212,38.368-38.368S124.97,65.446,103.814,65.446z'/><path d='M103.814,39.385c-4.142,0-7.5-3.358-7.5-7.5V7.5c0-4.142,3.358-7.5,7.5-7.5s7.5,3.358,7.5,7.5v24.385  C111.314,36.027,107.956,39.385,103.814,39.385z'/><path d='M103.814,207.628c-4.142,0-7.5-3.358-7.5-7.5v-24.385c0-4.142,3.358-7.5,7.5-7.5s7.5,3.358,7.5,7.5v24.385  C111.314,204.271,107.956,207.628,103.814,207.628z'/><path d='M200.128,111.314h-24.385c-4.142,0-7.5-3.358-7.5-7.5s3.358-7.5,7.5-7.5h24.385c4.142,0,7.5,3.358,7.5,7.5  S204.271,111.314,200.128,111.314z'/><path d='M31.885,111.314H7.5c-4.142,0-7.5-3.358-7.5-7.5s3.358-7.5,7.5-7.5h24.385c4.142,0,7.5,3.358,7.5,7.5  S36.027,111.314,31.885,111.314z'/><path d='M154.676,60.452c-1.919,0-3.839-0.732-5.303-2.197c-2.929-2.929-2.929-7.678,0-10.606l17.243-17.242  c2.929-2.929,7.678-2.93,10.606,0c2.929,2.929,2.929,7.678,0,10.606l-17.243,17.242C158.515,59.72,156.595,60.452,154.676,60.452z'/><path d='M35.709,179.419c-1.919,0-3.839-0.732-5.303-2.197c-2.929-2.929-2.929-7.678,0-10.606l17.243-17.243  c2.929-2.929,7.678-2.929,10.606,0c2.929,2.929,2.929,7.678,0,10.606l-17.243,17.243C39.548,178.687,37.629,179.419,35.709,179.419z  '/><path d='M171.918,179.419c-1.919,0-3.839-0.732-5.303-2.197l-17.243-17.243c-2.929-2.929-2.929-7.678,0-10.606  c2.929-2.929,7.678-2.929,10.606,0l17.243,17.243c2.929,2.929,2.929,7.678,0,10.606  C175.757,178.687,173.838,179.419,171.918,179.419z'/><path d='M52.952,60.452c-1.919,0-3.839-0.732-5.303-2.197L30.406,41.013c-2.929-2.929-2.929-7.677,0-10.606  c2.929-2.929,7.678-2.93,10.606,0l17.243,17.242c2.929,2.929,2.929,7.677,0,10.606C56.791,59.72,54.872,60.452,52.952,60.452z'/></svg></span><div id=andrew style=margin-top:15px;text-align:center;width:100%><span>Designed by <a class=light-link href="
    ,ProzacYouthUtils1.getAndrewUrl(),
    " target=_blank>Andrew Mitchell</a></span></div><div class=footer>&#169; Prozac Youth. All rights reserved.</div><canvas id='notepadCanvas' style='display:none;'></canvas></div></div>"));
    }

    function getAnimFooter() public pure returns (string memory) {
        return "<body></body></html>";
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