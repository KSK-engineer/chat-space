$(function() {
      function buildHTML(message){
        if ( message.image ) {
          var html =
          `<div class="message">
            <div class="upper-message">
              <div class="upper-message__user-name">
                ${message.user_name}
              </div>
              <div class="upper-message__date">
                ${message.created_at}
              </div>
            </div>
            <div class="lower-message">
              <p class="lower-message__content">
                ${message.content}
              </p>
            </div> 
            <img src = ${message.image} >
          </div>`
        return html;
        } 
        else {
        var html =
          `<div class="message">
            <div class="upper-message">
              <div class="upper-message__user-name">
                ${message.user_name}
              </div>
              <div class="upper-message__date">
                ${message.created_at}
              </div>
            </div>
            <div class="lower-message">
              <p class="lower-message__content">
                ${message.content}
              </p>
            </div>
          </div> `
        return html;
        };
      }  
  $('#new_message').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    // onメソッドの内部では、$(this)と書くことでonメソッドを利用しているノードのオブジェクトが参照されます。つまり、今回の場合はform要素自体ということになります。

    // attrメソッドによって、引数に指定した属性の値を取得することができます。
    // 今回は引数に'action'を指定しているので、form要素のaction属性の値が取得できます。
    // 以下の図のように、/groups/:id番号/messagesとなっており、必要なパスとなることがわかります。
   
    $.ajax({
      url: url,  //同期通信でいう『パス』
      type: 'POST',  //同期通信でいう『HTTPメソッド』
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.message_list').append(html);
      $('form')[0].reset();
      $('.message_list').animate({ scrollTop: $('.message_list')[0].scrollHeight});
      $('.submit-btn').attr("disabled", false);
      
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
      $('.submit-btn').removeAttr('data-disable-with')
      $('.submit-btn').attr("disabled", false);
    });
  });
});
