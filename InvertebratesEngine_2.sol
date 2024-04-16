// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract InvertebratesEngine_2 {

function getScriptHeader(string memory tokenId, string memory color, string memory hash, string memory mood) public pure returns (string memory) {
        return string(abi.encodePacked("<script type='application/javascript'>let color=colors[",color,"],mood=",mood,",tokenData={hash:'0x",hash,"',tokenId:'",tokenId,"'};let shouldLoadDrawing=!1;const draw=async function(){requestAnimationFrame((function(){addLoader('')})),await new Promise((e=>setTimeout(e,200))),requestAnimationFrame((function(){updateLoader('Loading variables')})),await new Promise((e=>setTimeout(e,200)));const e=new class{constructor(){this.useA=!1;let e=function(e){let n=parseInt(e.substr(0,8),16),t=parseInt(e.substr(8,8),16),o=parseInt(e.substr(16,8),16),a=parseInt(e.substr(24,8),16);return function(){n|=0,t|=0,o|=0,a|=0;let e=(n+t|0)+a|0;return a=a+1|0,n=t^t>>>9,t=o+(o<<3)|0,o=o<<21|o>>>11,o=o+e|0,(e>>>0)/4294967296}};this.prngA=new e(tokenData.hash.substr(2,32)),this.prngB=new e(tokenData.hash.substr(34,32));for(let e=0;e<1e6;e+=2)this.prngA(),this.prngB()}random_dec(){return this.useA=!this.useA,this.useA?this.prngA():this.prngB()}random_num(e,n){return e+(n-e)*this.random_dec()}random_int(e,n){return Math.floor(this.random_num(e,n+1))}random_bool(e){return this.random_dec()<e}random_choice(e){return e[this.random_int(0,e.length-1)]}},n=[{width:100,height:100},{width:3,height:4},{width:9,height:16},{width:1,height:1}];let t=0;const o=document.createElement('style');o.innerHTML='body { margin-top: 0; display: flex; justify-content: center; align-items: center; background-color: #FFFFE1; } svg { height: 100vh; width: 100vw; padding: 0vmin; box-shadow: .5vmin .5vmin 1vmin rgba(0, 0, 0, 0.5); box-sizing: border-box; }',document.head.appendChild(o);const a=document.createElementNS('http://www.w3.org/2000/svg','svg');a.setAttribute('id','mySvg'),a.setAttribute('viewBox','0 0 100 100'),document.body.appendChild(a),setRatio(n,t);let r,i,s,d,c,l,m,u,h,_,y,f,p,g,b,$,w,k,v,x,A,L,S,C,F,E,B,T,I,q,P,M,R,N,D,G=document.getElementById('mySvg'),z=100,O=!1,V=0,j='',H=function(){},U=function(){},W=function(e){},K='',X=findNameByColor(color[0].sub(1),colorNames);switch(document.getElementsByTagName('body')[0].style.backgroundColor='#'+color[0],requestAnimationFrame((function(){updateLoader('Loading variables')})),function(){switch(d=e.random_choice([0,2,3,4,2,0]),V=e.random_bool(.5)?e.random_num(-60,60):e.random_int(-5,5),b=e.random_bool(.5),x=e.random_choice([1,-1]),A=e.random_choice([1,-1]),W=function(n){return e.random_choice(color)},mood){case 0:i=1,s=8,g=5,D=100,r=.2,$=.03,l=3,c=e.random_int(800,1100),m=c/l,h=m/2,A*=2,x*=2,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 1:i=15,s=10,g=6,D=50,r=.025,$=.03,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/e.random_int(6,15),u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),b=!0;break;case 2:i=3,s=5,g=6,D=50,r=.045,$=.04,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/20,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),b=!0;break;case 3:i=15,s=2,g=6,D=50,r=.03,$=.04,l=3,c=e.random_int(800,1200),m=c/l,h=m/10,u=.06,V=e.random_choice([-45,45]),w=e.random_int(100,800);break;case 4:i=3,s=3,g=5,D=10,r=.06,$=.009,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/3,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 5:i=3,s=3,g=10,D=100,r=.04,$=.04,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 6:i=3,s=1,g=10,D=100,r=.04,$=.04,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 7:i=1,s=2,g=5,D=40,r=e.random_choice([.06,.07,.08,.09,.1]),$=e.random_choice([9e-4,8e-4,.001]),l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=2*m,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),d=e.random_choice([0,1,2,3]);break;case 8:i=1,s=1,g=15,D=80,r=.09,$=.04,l=e.random_num(2,4),c=e.random_int(400,500),m=c/l,h=8*m,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 9:i=9,s=1,g=50,D=e.random_int(50,100),r=.001,$=.06,l=e.random_num(2,4),c=1e3,m=c/l,h=10*m,u=.06,w=e.random_int(300,800),V=e.random_choice([-45,45]);break;case 10:i=5,s=1,g=50,D=e.random_int(80,150),r=.001,$=.09,l=e.random_num(2,4),c=500,m=c/l,h=10*m,u=.06,w=e.random_int(300,800),V=e.random_choice([-45,45]);break;case 11:i=1,s=1,g=5,D=e.random_choice([2,20]),r=.3,$=.09,l=e.random_num(2,4),c=10,m=c/l,h=10*m,u=e.random_dec(),w=e.random_int(300,800),V=e.random_choice([-45,45]),d=e.random_choice([0,1,2]);break;case 12:i=10,s=1,g=20,D=15,r=.1,$=.045,l=e.random_num(2,4),c=e.random_int(800,1100),m=c/l,h=m/10,u=.06,w=e.random_int(100,800);break;case 13:i=3,s=1,g=1,D=e.random_int(50,100),r=.01,$=e.random_num(.06,.09),l=e.random_num(2,4),c=e.random_int(150,200),m=c/l,h=10*m,u=.06,w=e.random_int(300,800),V=e.random_choice([-45,45]);break;case 14:i=3,s=1,g=4,D=40,r=.1,$=.03,l=3,c=e.random_int(700,1100),m=c/l,h=m/e.random_int(2,5),u=.06,w=e.random_int(100,800),V=e.random_choice([-30,30]),A*=3,x*=3,W=function(e){return color[e]};break;case 15:i=3,s=5,g=3,D=30,r=.025,$=.03,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/50,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),b=!0;break;case 16:i=2,s=1,g=3,D=10,r=.015,$=.3,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/100,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),x*=3,A*=3,d=e.random_choice([1,2,3]);break;case 17:i=5,s=2,g=3,D=10,r=.085,$=.5,l=e.random_num(2,4),c=e.random_int(800,1200),m=c/l,h=m/300,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),x*=3,A*=3,d=e.random_choice([1,2,3]);break;case 18:i=1,s=1,g=5,D=100,r=.1,$=.1,l=3,c=e.random_int(800,1100),m=c/l,h=m/2,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 19:i=10,s=1,g=6,D=10,r=.028,$=.02,l=4,c=e.random_int(800,1100),m=c/l,h=m/3,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 20:i=15,s=10,g=6,D=100,r=.03,$=.02,l=e.random_num(2,4),c=e.random_int(800,1100),m=c/l,h=m/10,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 21:i=8,s=1,g=10,D=50,r=.015,$=.02,l=3,c=e.random_int(800,1100),m=c/l,h=m/3,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]);break;case 22:i=3,s=15,B=1,g=6,D=10,r=.02,$=.25,T=.01,l=4,c=e.random_int(500,1100),m=c/l,h=m/80,_=m/30,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),O=!0;break;case 23:i=5,s=1,B=10,g=30,D=100,r=.04,$=.1,T=.01,l=3,c=e.random_int(500,1100),m=c/l,h=3*m,_=m/50,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),O=!0;break;case 24:i=1,s=5,B=10,g=10,D=10,r=.01,$=.09,T=.09,l=4,c=e.random_int(800,1100),m=c/l,h=m/100,_=3*m,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),O=!0,d=e.random_choice([2,0]);break;case 25:i=3,s=3,B=10,g=10,D=30,r=.1,$=.01,T=.1,l=5,c=e.random_int(500,1100),m=c/l,h=m,_=m/10,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),O=!0;break;case 26:i=3,s=3,B=6,g=10,D=30,r=.1,$=.01,T=.1,l=5,c=e.random_int(500,1100),m=c/l,h=m,_=m/50,u=.06,w=e.random_int(100,800),V=e.random_choice([-45,45]),O=!0}V+=4===d?e.random_choice([-45,45]):0,$=$||0,s=s||0,q=!1,P=!0,R=e.random_choice([.994,.995,.996,.997,.998]),N=1-e.random_int(1,2)*R+1,L=-50,S=250,C=-100,F=150,v=(F-C)/4,f=e.random_int(C,F),p=e.random_int(0,z),y=e.random_int(1,1e3),K='',M=(F-C)/2,L=e.random_int(-12.5,12.5),console.log('baseFreq',r,'density',g,'strokeWidth',D,'scale',c,'scale2',m,'scale4',_,'densityIncrement',u,'scale divide',l,'numOctaves',i,'numOctaves2',s,'mood',mood,'type',d,'erosion',w,'isVertical',b,'color',color[0],'colorName',X)}(),await new Promise((e=>setTimeout(e,200))),requestAnimationFrame((function(){updateLoader('Loading filters')})),await new Promise((e=>setTimeout(e,200))),K+=' <defs>',K+='<filter id='f0'>',K+=`<feMorphology operator='erode' radius='${w}' />`,K+='</filter>',K+=`\n      <filter id='f1'>\n        <feTurbulence type='fractalNoise'\n                      baseFrequency='${r}' numOctaves='${i}'\n                      seed='${y}'\n                      result='turbulence' />\n        <feTurbulence type='fractalNoise'\n                      baseFrequency='${$}' numOctaves='${s}'\n                      seed='${y+1}'\n                      result='turbulence2' />\n        <feDisplacementMap in2='turbulence'\n                           in='SourceGraphic' scale='${m}'\n                           result='displacement'\n                           xChannelSelector='A'\n                           yChannelSelector='A' />\n        <feDisplacementMap in2='turbulence'\n                           in='SourceGraphic' scale='${m}'\n                           result='displacementB'\n                           xChannelSelector='A'\n                           yChannelSelector='A' />`,K+=`\n            <feDisplacementMap in2='turbulence2'\n                           in='displacement' scale='${h}'\n                           result='displacement2'\n                           xChannelSelector='A'\n                           yChannelSelector='A' />\n                <feDisplacementMap in2='turbulence2'\n                           in='displacementB' scale='${h}'\n                           result='displacementB2'\n                           xChannelSelector='A'\n                           yChannelSelector='A' />\n                           ;`,O&&(K+=`\n            <feTurbulence type='fractalNoise'\n                      baseFrequency='${T}' numOctaves='${B}'\n                      seed='${y}'\n                      result='turbulence3' />\n            <feDisplacementMap in2='turbulence3'\n                           in='displacement' scale='${_}'\n                           result='displacement3'\n                           xChannelSelector='B'\n                           yChannelSelector='A' />\n                           ;`),K+='\n      <feBlend in='displacement2' in2='displacement2' result='burn' mode='normal'/>\n     ',K+='\n</filter>\n    </defs>\n  ',K+=`\n    \n  <rect fill='#${color[0]}' x='0' y='0' width='100' height='100' />\n`,G.innerHTML+=K,requestAnimationFrame((function(){removeAllLoaders(),addLoader('Loading html')})),await new Promise((e=>setTimeout(e,200))),K='',d){case 2:b?(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}' filter='url(#${e})' stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' y1='${t}' x1='${o}' x2='${10^t}' y2='${o}' />`}):(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}' filter='url(#${e})' stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' x1='${t}' y1='${o}' y2='${10^t}' x2='${o}' />`});break;case 3:b?(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}' filter='url(#${e})' stroke-opacity='.95' stroke='#${n}' style='stroke-width:${a}' y1='${t}' x1='${o}' x2='${2*t}' y2='${2*o}' />`}):(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}' filter='url(#${e})'stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' x1='${t}' y1='${o}' y2='${2*t}' x2='${2*o}' />`});break;case 4:C-=100,b?(j=`translate(50,50) rotate(${V+e.random_choice([-45,45])}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}'  filter='url(#${e})' stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' y1='${t}' x1='${o}' x2='${t+100}' y2='${o}' />`}):(j=`translate(50,50) rotate(${V+e.random_choice([-45,45])}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}'   filter='url(#${e})' stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' x1='${t}' y1='${o}' y2='${t+100}' x2='${o}' />`});break;default:b?(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}'  filter='url(#${e})'stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' y1='${t}' x1='${o}' x2='${t}' y2='${o}' />`}):(j=`translate(50,50) rotate(${V}) scale(${x} ${A}) translate(-50,-50)`,H=function(e,n,t,o,a){return`<line transform='${j}'  filter='url(#${e})'stroke-opacity='.95'  stroke='#${n}' style='stroke-width:${a}' x1='${t}' y1='${o}' y2='${t}' x2='${o}' />`})}e.random_bool(.4)?U=function(e){D*=e<M?-R:-N}:(L=e.random_int(10,z/3.5),N=e.random_int(4,12),U=function(e){D*=R}),E=0,k=0;for(let n=L;n<=S;n+=g){E++,E>=color.length&&(E=0),g+=u,I=W(E);for(let t=0;t<2;t++){let o=n,a=`f${t}`;for(let n=C;n<F;n+=v)k++,U(n),K+=H(a,I,n,o,e.random_num(0,D),color[Math.abs(E-1)])}}K+=`<rect fill='#${color[0]}' x='0' y='${S+g}' width='100' height='100' />`,requestAnimationFrame((function(){updateLoader('Rendering SVG, this can take a few seconds')})),await new Promise((e=>setTimeout(e,200))),requestAnimationFrame((function(){G.innerHTML+=K})),requestAnimationFrame((function(){removeAllLoaders()})),document.addEventListener('keydown',(async function(e){if('s'===e.key||'S'===e.key){requestAnimationFrame((function(){addLoader('Saving SVG')})),await new Promise((e=>setTimeout(e,200)));const e=document.getElementById('mySvg'),n=document.createElement('style');n.textContent=`\n    svg {\n      width: 100vw;\n      height: 100vh;\n      padding: 0vmin;\n      box-shadow: .5vmin .5vmin 1vmin rgba(0, 0, 0, 0.5);\n      box-sizing: border-box;\n    }\n    \x3c!-- If you want to display the SVG as it was in the generator, just put it into the <body> of an html page and add this styling --\x3e\n    body {\n      display: flex;\n      justify-content: center;\n      align-items: center;\n      background-color: #${color[0]};\n    }\n  `,e.prepend(n);const t=new XMLSerializer,o=new Blob([t.serializeToString(e)],{type:'image/svg+xml'}),a=URL.createObjectURL(o);document.write(e);const r=document.createElement('a');r.href=a,r.download='_________.svg',document.body.appendChild(r),r.click(),document.body.removeChild(r),URL.revokeObjectURL(a),removeAllLoaders()}})),document.addEventListener('keydown',(async function(e){requestAnimationFrame((function(){addLoader('Loading new aspect ratio')})),await new Promise((e=>setTimeout(e,200))),'ArrowRight'===e.key?t=(t+1)%n.length:'ArrowLeft'===e.key&&(t=(t-1+n.length)%n.length),setRatio(n,t),removeAllLoaders()})),G.addEventListener('touchend',(async function(e){requestAnimationFrame((function(){addLoader('Loading new aspect ratio')})),await new Promise((e=>setTimeout(e,200))),t=(t+1)%n.length;const o=n[t];document.getElementById('mySvg');doRatio(o,document.getElementById('mySvg')),removeAllLoaders()}))};function doRatio(e,n){100===e.width&&100===e.height?(n.style.width='100vw',n.style.height='100vh'):e.width/e.height>1?(n.style.width='100vw',n.style.height=`calc(100vw * (${e.height} / ${e.width}))`):(n.style.height='100vh',n.style.width=`calc(100vh * (${e.width} / ${e.height}))`)}function findNameByColor(e,n){for(let t=0;t<n.length;t++)if(n[t].color===e)return n[t].name}function setRatio(e,n){doRatio(e[n],document.getElementById('mySvg'))}let isLoaded=!1;function isSafari(){return'undefined'!=typeof navigator&&null!=navigator&&/^((?!chrome|android).)*safari/i.test(navigator?.userAgent)}function removeAllLoaders(){document.querySelectorAll('.loader-container').forEach((e=>{e.parentNode.removeChild(e)}))}function addLoader(e){let n=document.createElement('div');n.className='loader-container',n.style.position='absolute',n.style.left='50%',n.style.top='50%',n.style.transform='translate(-50%, -50%)';const t=document.createElement('div');let o;if(t.innerText=e+'...',t.style.color='#FFFFFF',t.style.border='#000000',t.style.fontFamily='Helvetica, Arial, sans-serif',t.style.fontSize='14px',t.style.width='max-content',t.style.display='inline-block',t.className='loading-text',t.id='loader-text',n.appendChild(t),document.body.appendChild(n),document.styleSheets.length>0)o=document.styleSheets[0];else{const e=document.createElement('style');document.head.appendChild(e),o=e.sheet}o.insertRule('\n    @keyframes spin {\n        0% { transform: rotate(0deg); }\n        100% { transform: rotate(360deg); }\n    }\n    ',o.cssRules.length)}function updateLoader(e){document.querySelectorAll('.loading-text').forEach((n=>{n.innerText=e+'...'}))}function addPotentialPopup(){var e=document.createElement('div');e.id='safari-popup',e.style='display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); background-color: white; padding: 20px; border: 1px solid #ccc; z-index: 1000;',e.innerHTML='<p>We have detected you are using the web broser Safari. Safari currently uses <a target='_blank' href='https://en.wikipedia.org/wiki/Comparison_of_browser_engines'>WebKit</a>, which can have large memory leaks when loading SVGs with filters, making the system unresponsive. This <a target='_blank' href='https://bugs.webkit.org/show_bug.cgi?id=218422'>issue</a> has been reported to WebKit. I recommend <a target='_blank' href='https://en.wikipedia.org/wiki/Comparison_of_browser_engines'>Blink</a> based browsers (as of 2024) like Google Chrome and Microsoft Edge. If you would like to continue, knowing that Safari may have issues, or believing that Safari now correctly supports SVG files, you may.</p><button onclick='closePopup()'>I understand and wish to continue at my own risk.</button>',document.body.appendChild(e)}function closePopup(){var e=document.getElementById('safari-popup'),n=document.getElementById('safari-banner');e&&(shouldLoadDrawing=!0,e.style.display='none',n.style.display='none')}setInterval((function(){if(!isLoaded){isLoaded=!0,requestAnimationFrame(addPotentialPopup),requestAnimationFrame((function(){if(isSafari()){const e=document.createElement('div');e.style.position='fixed',e.style.bottom='0',e.style.left='0',e.style.width='100%',e.style.backgroundColor='red',e.style.color='white',e.style.textAlign='center',e.style.padding='10px',e.style.zIndex='1000',e.className='safari-banner',document.body.appendChild(e),document.getElementById('safari-popup').style.display='block'}else shouldLoadDrawing=!0}));let e=setInterval((function(){shouldLoadDrawing&&async function(){clearInterval(e),await new Promise((e=>setTimeout(e,200))),await draw()}()}),100)}}),1e3);</script></head>"));
    }
}