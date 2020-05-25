function crawlData() {
    $.ajax({
        url: "http://localhost:8080/NLPWeiBo/crawlData",
        type: "POST",
        success: function(data) {
            if (data.status == "1") {
                alert(data.message);
            }
        }
    });
}