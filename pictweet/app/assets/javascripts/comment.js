$(function() {
  function buildHTML(comment) {
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`;
    return html;
  }

  $("#new_comment").submit(function(e) {
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr("action"); // actionの値をかえす ここでのaction:フォーム送信先のurl
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: "json",
      processData: false, // dataに指定されたオブジェクトを、クエリ文字列に変換しない
      contentType: false // ファイル形式を伝える フォームの情報取得時はfalseにする
    })
      // コメントに成功したとき
      .done(function(data) {
        var html = buildHTML(data);
        $(".comments").append(html);
        $(".textbox").val("");
      })
      // コメントに失敗したとき
      .fail(function() {
        alert("error");
      });
  });
});
