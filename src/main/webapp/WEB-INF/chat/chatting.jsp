<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
  <meta charset="UTF-8">
  <title>Insert title here</title>
  <style>

    *{
      box-sizing: border-box;
    }

    #chatt{
      width: 800px;
      margin: 20px auto;
    }

    #chatt #talk{
      width: 800px;
      height: 400px;
      overflow: scroll;
      border : 1px solid #aaa;
    }
    #chatt #msg{
      width: 740px;
      height:100px;
      display: inline-block;
    }

    #chatt #sendZone > *{
      vertical-align: top;

    }
    #chatt #btnSend{
      width: 54px;
      height: 100px;
    }

    #chatt #talk div{
      width: 70%;
      display: inline-block;
      padding: 6px;
      border-radius:10px;

    }

    #chatt .me{
      background-color : #ffc;
      margin : 1px 0px 2px 30%;
    }

    #chatt .other{
      background-color : #eee;
      margin : 2px;
    }
  </style>
  <script>
    function getId(id){
      return document.getElementById(id);
    }

    var data = {};//전송 데이터(JSON)

    var ws ;


    function btnLogin(){
      ws = new WebSocket("ws://" + location.host + "/chat");

      ws.onmessage = function(msg){
        var data = JSON.parse(msg.data);
        var css;

        if(data.mid === mid.value){
          css = 'class=me';
        }else{
          css = 'class=other';
        }

        var item = `<div ${css} >
		                <span><b>${data.mid}</b></span> [ ${data.date} ]<br/>
                      <span>${data.msg}</span>
						</div>`;

        talk.innerHTML += item;
        talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
      }
    }

    // msg.onkeyup = function(ev){
    //   if(ev.keyCode === 13){
    //     send();
    //   }
    // }

   function btnSend(){
      send();
    }

    function send(){
      if(msg.value.trim() !== ''){
        data.mid = getId('mid').value;
        data.msg = msg.value;
        data.date = new Date().toLocaleString();
        var temp = JSON.stringify(data);
        ws.send(temp);
      }
      msg.value ='';

    }
  </script>
</head>
<body>
<div id='chatt'>
  <h1>WebSocket Chatting</h1>
  <input type='text' id='mid' value='홍길동'>
  <input type='button' value='로그인' id='btnLogin' onclick="btnLogin()">
  <br/>
  <div id='talk'></div>
  <div id='sendZone'>
    <textarea id='msg' value='hi...' ></textarea>
    <input type='button' value='전송' id='btnSend' onclick="btnSend()">
  </div>
</div>

</body>
</html>