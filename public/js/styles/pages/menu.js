// Compiled by Polvo, using Stylus
define('styles/pages/menu', ['require', 'exports', 'module'], function(require, exports, module){

  var head = document.getElementsByTagName('head')[0];
  var style = module.exports = document.createElement('style');
  var content = '.menu {  height: 50px;  position: absolute;  overflow: hidden;  width: 1150px;}.menu .open {  position: absolute;  width: 100%;}.menu .open .arrow {  width: 22px;  height: 15px;  background: url(\"img/arrow-down.png\") no-repeat top left;  left: 50%;  margin-left: -11px;  position: absolute;  top: 10px;  cursor: pointer;}.menu ul.nav {  display: block;  position: absolute;}.menu ul li {  float: left;  margin-right: 10px;}.menu ul li a {  font-family: Arial;  font-weight: bold;  font-size: 12px;  height: 19px;  background-color: #fff;  -webkit-border-radius: 20px;  border-radius: 20px;  text-align: center;  padding-top: 6px;  text-decoration: none;  color: #000;  width: 25px;  display: block;  position: relative;  top: 100px;}.menu ul li a .dot {  width: 1px;  height: 1px;  background-color: #000;  position: absolute;  top: 50%;  left: 50%;  margin-left: -1px;}'

  style.setAttribute('id', 'styles/pages/menu');
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