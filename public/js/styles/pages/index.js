// Compiled by Polvo, using Stylus
define('styles/pages/index', ['require', 'exports', 'module'], function(require, exports, module){

  var head = document.getElementsByTagName('head')[0];
  var style = module.exports = document.createElement('style');
  var content = 'html,body,div,span,applet,object,iframe,h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,acronym,address,big,cite,code,del,dfn,em,img,ins,kbd,q,s,samp,small,strike,strong,sub,sup,tt,var,b,u,i,center,dl,dt,dd,ol,ul,li,fieldset,form,label,legend,table,caption,tbody,tfoot,thead,tr,th,td,article,aside,canvas,details,embed,figure,figcaption,footer,header,hgroup,menu,nav,output,ruby,section,summary,time,mark,audio,video {  margin: 0;  padding: 0;  border: 0;  font-size: 100%;  font: inherit;  vertical-align: baseline;}article,aside,details,figcaption,figure,footer,header,hgroup,menu,nav,section {  display: block;}body {  line-height: 1;}ol,ul {  list-style: none;}blockquote,q {  quotes: none;}blockquote:before,blockquote:after,q:before,q:after {  content: "";  content: none;}table {  border-collapse: collapse;  border-spacing: 0;}@font-face {  font-family: "MetaCondBookRoman";  src: url("fonts/metacondbook-roman-webfont.eot");  src: url("fonts/metacondbook-roman-webfont.eot?#iefix") format("embedded-opentype"), url("fonts/metacondbook-roman-webfont.woff") format("woff"), url("fonts/metacondbook-roman-webfont.ttf") format("truetype"), url("fonts/metacondbook-roman-webfont.svg#metacondbookroman") format("svg");  font-weight: normal;  font-style: normal;}@font-face {  font-family: "MetaNormalRoman";  src: url("fonts/metanormal-roman-webfont.eot");  src: url("fonts/metanormal-roman-webfont.eot?#iefix") format("embedded-opentype"), url("fonts/metanormal-roman-webfont.woff") format("woff"), url("fonts/metanormal-roman-webfont.ttf") format("truetype"), url("fonts/metanormal-roman-webfont.svg#meta_normalroman") format("svg");  font-weight: normal;  font-style: normal;}@font-face {  font-family: "MetaBookRoman";  src: url("fonts/metabook-roman-webfont.eot");  src: url("fonts/metabook-roman-webfont.eot?#iefix") format("embedded-opentype"), url("fonts/metabook-roman-webfont.woff") format("woff"), url("fonts/metabook-roman-webfont.ttf") format("truetype"), url("fonts/metabook-roman-webfont.svg#meta_bookroman") format("svg");  font-weight: normal;  font-style: normal;}@font-face {  font-family: "MetaBookItalic";  src: url("fonts/metabook-italic-webfont.eot");  src: url("fonts/metabook-italic-webfont.eot?#iefix") format("embedded-opentype"), url("fonts/metabook-italic-webfont.woff") format("woff"), url("fonts/metabook-italic-webfont.ttf") format("truetype"), url("fonts/metabook-italic-webfont.svg#meta_bookitalic") format("svg");  font-weight: normal;  font-style: normal;}@font-face {  font-family: "MetaRomanBold";  src: url("fonts/metaboldlf-roman-webfont.eot");  src: url("fonts/metaboldlf-roman-webfont.eot?#iefix") format("embedded-opentype"), url("fonts/metaboldlf-roman-webfont.woff") format("woff"), url("fonts/metaboldlf-roman-webfont.ttf") format("truetype"), url("fonts/metaboldlf-roman-webfont.svg#meta_lfroman_bold") format("svg");  font-weight: normal;  font-style: normal;}body {  background-color: #000;}h2 {  font-size: 17px;  letter-spacing: 10px;}.wrapper {  width: 1150px;  position: relative;  margin: 0 auto;}.pages .logo {  width: 77px;  height: 77px;  position: absolute;  top: 20px;  left: 50%;  margin-left: -38.5px;}.pages .bold_line,.pages .thin_line {  width: 50px;  height: 4px;  position: absolute;  top: 117px;  left: 50%;  margin-left: -25px;  background-color: #fff;}.pages .thin_line {  height: 1px;  top: 165px;}.pages .title {  font-family: "MetaCondBookRoman", sans-serif;  color: #fff;  text-transform: uppercase;  top: 135px;  position: absolute;  display: block;  left: 50%;}'

  style.setAttribute('id', 'styles/pages/index');
  style.setAttribute('type', 'text/css');

  // MODERN BROWSERS?
  try
  { 
    style.appendChild(document.createTextNode(content));

  // IE8? (weird things happens without this on IEs)
  } catch( e )
  {
    style.styleSheet.cssText = content; // IE8
  }

  head.insertBefore(style, head.lastChild);
  return style;
});