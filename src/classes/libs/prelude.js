(function(root){
var require=function(n,r,t){function e(t,i){if(!r[t]){if(!n[t]){var o=typeof require=="function"&&require;if(!i&&o)return o(t,!0);if(u)return u(t,!0);throw new Error("Cannot find module '"+t+"'")}var a=r[t]={exports:{}};n[t][0].call(a.exports,function(r){var u=n[t][1][r];return e(u?u:r)},a,a.exports)}return r[t].exports}var u=typeof require=="function"&&require;for(var i=0;i<t.length;i++)e(t[i]);return e}({"prelude-ls":[function(n,r,t){r.exports=n("bcmc1g")},{}],bcmc1g:[function(n,r,t){var e,u,i,o,a,c,f,l,s,p={}.toString;e=n("./Func.js");u=n("./List.js");i=n("./Obj.js");o=n("./Str.js");a=n("./Num.js");c=function(n){return n};f=h(function(n,r){return p.call(r).slice(8,-1)===n});l=h(function(n,r){var t,e=[];for(t=0;t<n;++t){e.push(r)}return e});o.empty=u.empty;o.slice=u.slice;o.take=u.take;o.drop=u.drop;o.splitAt=u.splitAt;o.takeWhile=u.takeWhile;o.dropWhile=u.dropWhile;o.span=u.span;o.breakStr=u.breakList;s={Func:e,List:u,Obj:i,Str:o,Num:a,id:c,isType:f,replicate:l};s.each=u.each;s.map=u.map;s.filter=u.filter;s.compact=u.compact;s.reject=u.reject;s.partition=u.partition;s.find=u.find;s.head=u.head;s.first=u.first;s.tail=u.tail;s.last=u.last;s.initial=u.initial;s.empty=u.empty;s.reverse=u.reverse;s.difference=u.difference;s.intersection=u.intersection;s.union=u.union;s.countBy=u.countBy;s.groupBy=u.groupBy;s.fold=u.fold;s.foldl=u.foldl;s.fold1=u.fold1;s.foldl1=u.foldl1;s.foldr=u.foldr;s.foldr1=u.foldr1;s.unfoldr=u.unfoldr;s.andList=u.andList;s.orList=u.orList;s.any=u.any;s.all=u.all;s.unique=u.unique;s.sort=u.sort;s.sortWith=u.sortWith;s.sortBy=u.sortBy;s.sum=u.sum;s.product=u.product;s.mean=u.mean;s.average=u.average;s.concat=u.concat;s.concatMap=u.concatMap;s.flatten=u.flatten;s.maximum=u.maximum;s.minimum=u.minimum;s.scan=u.scan;s.scanl=u.scanl;s.scan1=u.scan1;s.scanl1=u.scanl1;s.scanr=u.scanr;s.scanr1=u.scanr1;s.slice=u.slice;s.take=u.take;s.drop=u.drop;s.splitAt=u.splitAt;s.takeWhile=u.takeWhile;s.dropWhile=u.dropWhile;s.span=u.span;s.breakList=u.breakList;s.zip=u.zip;s.zipWith=u.zipWith;s.zipAll=u.zipAll;s.zipAllWith=u.zipAllWith;s.apply=e.apply;s.curry=e.curry;s.flip=e.flip;s.fix=e.fix;s.split=o.split;s.join=o.join;s.lines=o.lines;s.unlines=o.unlines;s.words=o.words;s.unwords=o.unwords;s.chars=o.chars;s.unchars=o.unchars;s.values=i.values;s.keys=i.keys;s.pairsToObj=i.pairsToObj;s.objToPairs=i.objToPairs;s.listsToObj=i.listsToObj;s.objToLists=i.objToLists;s.max=a.max;s.min=a.min;s.negate=a.negate;s.abs=a.abs;s.signum=a.signum;s.quot=a.quot;s.rem=a.rem;s.div=a.div;s.mod=a.mod;s.recip=a.recip;s.pi=a.pi;s.tau=a.tau;s.exp=a.exp;s.sqrt=a.sqrt;s.ln=a.ln;s.pow=a.pow;s.sin=a.sin;s.tan=a.tan;s.cos=a.cos;s.acos=a.acos;s.asin=a.asin;s.atan=a.atan;s.atan2=a.atan2;s.truncate=a.truncate;s.round=a.round;s.ceiling=a.ceiling;s.floor=a.floor;s.isItNaN=a.isItNaN;s.even=a.even;s.odd=a.odd;s.gcd=a.gcd;s.lcm=a.lcm;s.VERSION="1.0.0";r.exports=s;function h(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}},{"./Func.js":1,"./Obj.js":2,"./Num.js":3,"./List.js":4,"./Str.js":5}],1:[function(n,r,t){var e,u,i,o;e=function(n){return a(n)};u=a(function(n,r,t){return n(t,r)});i=function(n){return function(r,t){return function(){return n(r(r)).apply(null,arguments)}}(function(r,t){return function(){return n(r(r)).apply(null,arguments)}})};o=a(function(n,r){return n.apply(null,r)});r.exports={curry:e,flip:u,fix:i,apply:o};function a(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}},{}],2:[function(n,r,t){var e,u,i,o,a,c,f,l,s,p,h,g,v,m;e=function(n){var r,t,e=[];for(r in n){t=n[r];e.push(t)}return e};u=function(n){var r,t=[];for(r in n){t.push(r)}return t};i=function(n){var r,t,e,u={};for(r=0,t=n.length;r<t;++r){e=n[r];u[e[0]]=e[1]}return u};o=function(n){var r,t,e=[];for(r in n){t=n[r];e.push([r,t])}return e};a=d(function(n,r){var t,e,u,i,o={};for(t=0,e=n.length;t<e;++t){u=t;i=n[t];o[i]=r[u]}return o});c=function(n){var r,t,e,u;r=[];t=[];for(e in n){u=n[e];r.push(e);t.push(u)}return[r,t]};f=function(n){var r;for(r in n){return false}return true};l=d(function(n,r){var t,e;for(t in r){e=r[t];n(e)}return r});s=d(function(n,r){var t,e,u={};for(t in r){e=r[t];u[t]=n(e)}return u});p=d(function(n){var r,t,e={};for(r in n){t=n[r];if(t){e[r]=t}}return e});h=d(function(n,r){var t,e,u={};for(t in r){e=r[t];if(n(e)){u[t]=e}}return u});g=d(function(n,r){var t,e,u={};for(t in r){e=r[t];if(!n(e)){u[t]=e}}return u});v=d(function(n,r){var t,e,u,i;t={};e={};for(u in r){i=r[u];(n(i)?t:e)[u]=i}return[t,e]});m=d(function(n,r){var t,e;for(t in r){e=r[t];if(n(e)){return e}}});r.exports={values:e,keys:u,pairsToObj:i,objToPairs:o,listsToObj:a,objToLists:c,empty:f,each:l,map:s,filter:h,compact:p,reject:g,partition:v,find:m};function d(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}},{}],3:[function(n,r,t){var e,u,i,o,a,c,f,l,s,p,h,g,v,m,d,y,j,b,x,M,k,W,L,q,w,T,z,A,N,O,B,S;e=I(function(n,r){return n>r?n:r});u=I(function(n,r){return n<r?n:r});i=function(n){return-n};o=Math.abs;a=function(n){if(n<0){return-1}else if(n>0){return 1}else{return 0}};c=I(function(n,r){return~~(n/r)});f=I(function(n,r){return n%r});l=I(function(n,r){return Math.floor(n/r)});s=I(function(n,r){var t;return(n%(t=r)+t)%t});p=function(n){return 1/n};h=Math.PI;g=h*2;v=Math.exp;m=Math.sqrt;d=Math.log;y=I(function(n,r){return Math.pow(n,r)});j=Math.sin;b=Math.tan;x=Math.cos;M=Math.asin;k=Math.acos;W=Math.atan;L=I(function(n,r){return Math.atan2(n,r)});q=function(n){return~~n};w=Math.round;T=Math.ceil;z=Math.floor;A=function(n){return n!==n};N=function(n){return n%2===0};O=function(n){return n%2!==0};B=I(function(n,r){var t;n=Math.abs(n);r=Math.abs(r);while(r!==0){t=n%r;n=r;r=t}return n});S=I(function(n,r){return Math.abs(Math.floor(n/B(n,r)*r))});r.exports={max:e,min:u,negate:i,abs:o,signum:a,quot:c,rem:f,div:l,mod:s,recip:p,pi:h,tau:g,exp:v,sqrt:m,ln:d,pow:y,sin:j,tan:b,cos:x,acos:k,asin:M,atan:W,atan2:L,truncate:q,round:w,ceiling:T,floor:z,isItNaN:A,even:N,odd:O,gcd:B,lcm:S};function I(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}},{}],4:[function(n,r,t){var e,u,i,o,a,c,f,l,s,p,h,g,v,m,d,y,j,b,x,M,k,W,L,q,w,T,z,A,N,O,B,S,I,P,F,E,C,R,V,D,G,H,J,K,Q,U,X,Y,Z,$,_,nr,rr,tr,er,ur,ir,or,ar,cr,fr,lr=[].slice;e=sr(function(n,r){var t,e,u;for(t=0,e=r.length;t<e;++t){u=r[t];n(u)}return r});u=sr(function(n,r){var t,e,u,i=[];for(t=0,e=r.length;t<e;++t){u=r[t];i.push(n(u))}return i});i=sr(function(n){var r,t,e,u=[];for(r=0,t=n.length;r<t;++r){e=n[r];if(e){u.push(e)}}return u});o=sr(function(n,r){var t,e,u,i=[];for(t=0,e=r.length;t<e;++t){u=r[t];if(n(u)){i.push(u)}}return i});a=sr(function(n,r){var t,e,u,i=[];for(t=0,e=r.length;t<e;++t){u=r[t];if(!n(u)){i.push(u)}}return i});c=sr(function(n,r){var t,e,u,i,o;t=[];e=[];for(u=0,i=r.length;u<i;++u){o=r[u];(n(o)?t:e).push(o)}return[t,e]});f=sr(function(n,r){var t,e,u;for(t=0,e=r.length;t<e;++t){u=r[t];if(n(u)){return u}}});l=s=function(n){if(!n.length){return}return n[0]};p=function(n){if(!n.length){return}return n.slice(1)};h=function(n){if(!n.length){return}return n[n.length-1]};g=function(n){var r;r=n.length;if(!r){return}return n.slice(0,r-1)};v=function(n){return!n.length};m=function(n){return n.concat().reverse()};d=function(n){var r,t,e,u;r=[];for(t=0,e=n.length;t<e;++t){u=n[t];if(!pr(u,r)){r.push(u)}}return r};y=j=sr(function(n,r,t){var e,u,i;for(e=0,u=t.length;e<u;++e){i=t[e];r=n(r,i)}return r});b=x=sr(function(n,r){return y(n,r[0],r.slice(1))});M=sr(function(n,r,t){return y(n,r,t.concat().reverse())});k=sr(function(n,r){var t;t=r.concat().reverse();return y(n,t[0],t.slice(1))});W=sr(function(n,r){var t,e,u;t=[];e=r;while((u=n(e))!=null){t.push(u[0]);e=u[1]}return t});L=function(n){return[].concat.apply([],n)};q=sr(function(n,r){var t;return[].concat.apply([],function(){var e,u,i,o=[];for(e=0,i=(u=r).length;e<i;++e){t=u[e];o.push(n(t))}return o}())});w=sr(function(n){var r;return[].concat.apply([],function(){var t,e,u,i=[];for(t=0,u=(e=n).length;t<u;++t){r=e[t];if(r.length!=null){i.push(w(r))}else{i.push(r)}}return i}())});T=function(n){var r,t,e,u,i,o,a,c;r=lr.call(arguments,1);t=[];n:for(e=0,u=n.length;e<u;++e){i=n[e];for(o=0,a=r.length;o<a;++o){c=r[o];if(pr(i,c)){continue n}}t.push(i)}return t};z=function(n){var r,t,e,u,i,o,a,c;r=lr.call(arguments,1);t=[];n:for(e=0,u=n.length;e<u;++e){i=n[e];for(o=0,a=r.length;o<a;++o){c=r[o];if(!pr(i,c)){continue n}}t.push(i)}return t};A=function(){var n,r,t,e,u,i,o,a;n=lr.call(arguments);r=[];for(t=0,e=n.length;t<e;++t){u=n[t];for(i=0,o=u.length;i<o;++i){a=u[i];if(!pr(a,r)){r.push(a)}}}return r};N=sr(function(n,r){var t,e,u,i,o;t={};for(e=0,u=r.length;e<u;++e){i=r[e];o=n(i);if(o in t){t[o]+=1}else{t[o]=1}}return t});O=sr(function(n,r){var t,e,u,i,o;t={};for(e=0,u=r.length;e<u;++e){i=r[e];o=n(i);if(o in t){t[o].push(i)}else{t[o]=[i]}}return t});B=function(n){var r,t,e;for(r=0,t=n.length;r<t;++r){e=n[r];if(!e){return false}}return true};S=function(n){var r,t,e;for(r=0,t=n.length;r<t;++r){e=n[r];if(e){return true}}return false};I=sr(function(n,r){var t,e,u;for(t=0,e=r.length;t<e;++t){u=r[t];if(n(u)){return true}}return false});P=sr(function(n,r){var t,e,u;for(t=0,e=r.length;t<e;++t){u=r[t];if(!n(u)){return false}}return true});F=function(n){return n.concat().sort(function(n,r){if(n>r){return 1}else if(n<r){return-1}else{return 0}})};E=sr(function(n,r){if(!r.length){return[]}return r.concat().sort(n)});C=sr(function(n,r){if(!r.length){return[]}return r.concat().sort(function(r,t){if(n(r)>n(t)){return 1}else if(n(r)<n(t)){return-1}else{return 0}})});R=function(n){var r,t,e,u;r=0;for(t=0,e=n.length;t<e;++t){u=n[t];r+=u}return r};V=function(n){var r,t,e,u;r=1;for(t=0,e=n.length;t<e;++t){u=n[t];r*=u}return r};D=G=function(n){var r,t,e,u;r=0;t=n.length;for(e=0;e<t;++e){u=e;r+=n[u]}return r/t};H=function(n){var r,t,e,u,i;r=n[0];for(t=0,u=(e=n.slice(1)).length;t<u;++t){i=e[t];if(i>r){r=i}}return r};J=function(n){var r,t,e,u,i;r=n[0];for(t=0,u=(e=n.slice(1)).length;t<u;++t){i=e[t];if(i<r){r=i}}return r};K=Q=sr(function(n,r,t){var e,u;e=r;return[r].concat(function(){var r,i,o,a=[];for(r=0,o=(i=t).length;r<o;++r){u=i[r];a.push(e=n(e,u))}return a}())});U=X=sr(function(n,r){if(!r.length){return}return K(n,r[0],r.slice(1))});Y=sr(function(n,r,t){t=t.concat().reverse();return K(n,r,t).reverse()});Z=sr(function(n,r){if(!r.length){return}r=r.concat().reverse();return K(n,r[0],r.slice(1)).reverse()});$=sr(function(n,r,t){return t.slice(n,r)});_=sr(function(n,r){if(n<=0){return r.slice(0,0)}else if(!r.length){return r}else{return r.slice(0,n)}});nr=sr(function(n,r){if(n<=0||!r.length){return r}else{return r.slice(n)}});rr=sr(function(n,r){return[_(n,r),nr(n,r)]});tr=sr(function(n,r){var t,e,u;t=r.length;if(!t){return r}for(e=0;e<t;++e){u=e;if(!n(r[u])){break}}return r.slice(0,u)});er=sr(function(n,r){var t,e,u;t=r.length;if(!t){return r}for(e=0;e<t;++e){u=e;if(!n(r[u])){break}}return r.slice(u)});ur=sr(function(n,r){return[tr(n,r),er(n,r)]});ir=sr(function(n,r){return ur(hr([gr,n]),r)});or=sr(function(n,r){var t,e,u,i,o,a;t=[];e=r.length;for(u=0,i=n.length;u<i;++u){o=u;a=n[u];if(o===e){break}t.push([a,r[o]])}return t});ar=sr(function(n,r,t){var e,u,i,o,a,c;e=[];u=t.length;for(i=0,o=r.length;i<o;++i){a=i;c=r[i];if(a===u){break}e.push(n(c,t[a]))}return e});cr=function(){var n,r,t,e,u,i,o,a,c,f=[];n=lr.call(arguments);r=9e9;for(t=0,e=n.length;t<e;++t){u=n[t];r<=(i=u.length)||(r=i)}for(t=0;t<r;++t){o=t;a=[];for(c=0,e=n.length;c<e;++c){u=n[c];a.push(u[o])}f.push(a)}return f};fr=function(n){var r,t,e,u,i,o,a,c=[];r=lr.call(arguments,1);t=9e9;for(e=0,u=r.length;e<u;++e){i=r[e];t<=(o=i.length)||(t=o)}for(e=0;e<t;++e){a=e;c.push(n.apply(null,f()))}return c;function f(){var n,t,e,u=[];for(n=0,e=(t=r).length;n<e;++n){i=t[n];u.push(i[a])}return u}};r.exports={each:e,map:u,filter:o,compact:i,reject:a,partition:c,find:f,head:l,first:s,tail:p,last:h,initial:g,empty:v,reverse:m,difference:T,intersection:z,union:A,countBy:N,groupBy:O,fold:y,fold1:b,foldl:j,foldl1:x,foldr:M,foldr1:k,unfoldr:W,andList:B,orList:S,any:I,all:P,unique:d,sort:F,sortWith:E,sortBy:C,sum:R,product:V,mean:D,average:G,concat:L,concatMap:q,flatten:w,maximum:H,minimum:J,scan:K,scan1:U,scanl:Q,scanl1:X,scanr:Y,scanr1:Z,slice:$,take:_,drop:nr,splitAt:rr,takeWhile:tr,dropWhile:er,span:ur,breakList:ir,zip:or,zipWith:ar,zipAll:cr,zipAllWith:fr};function sr(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}function pr(n,r){var t=-1,e=r.length>>>0;while(++t<e)if(n===r[t]&&t in r)return true;return false}function hr(n){return function(){var r,t=arguments;for(r=n.length;r>0;--r){t=[n[r-1].apply(this,t)]}return t[0]}}function gr(n){return!n}},{}],5:[function(n,r,t){var e,u,i,o,a,c,f,l,s,p;e=h(function(n,r){return r.split(n)});u=h(function(n,r){return r.join(n)});i=function(n){if(!n.length){return[]}return n.split("\n")};o=function(n){return n.join("\n")};a=function(n){if(!n.length){return[]}return n.split(/[ ]+/)};c=function(n){return n.join(" ")};f=function(n){return n.split("")};l=function(n){return n.join("")};s=function(n){return n.split("").reverse().join("")};p=h(function(n,r){var t,e,u;e=[];for(u=0;u<n;++u){e.push(r)}t=e;return t.join("")});r.exports={split:e,join:u,lines:i,unlines:o,words:a,unwords:c,chars:f,unchars:l,reverse:s,repeat:p};function h(n,r){var t,e=function(u){return n.length>1?function(){var i=u?u.concat():[];t=r?t||this:this;return i.push.apply(i,arguments)<n.length&&arguments.length?e.call(t,i):n.apply(t,i)}:n};return e()}},{}]},{},[]);
prelude = root.prelude = require( "prelude-ls" );
return prelude;
})(window)
