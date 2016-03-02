/* global chrome*/
// background.jsから変数urlを取得
var image_url_from_extension = chrome.extension.getBackgroundPage();
// タグを取得
var img_url = document.getElementById("img_url");
// テキストノードの作成
var text_url = document.createTextNode(image_url_from_extension.url);
// タグの位置にテキストノードを追加
img_url.appendChild(text_url);