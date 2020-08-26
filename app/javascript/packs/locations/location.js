$("#select").change(function(){
  $(".table-content").remove()
  if($("#select option:selected")[0].value == "1"){
    $("#table-content-body").html("<%= j render @locations %>");
  }else if($("#select option:selected")[0].value == "2"){
    $("#table-content-body").html("<%= j render @radars %>");
  }else if($("#select option:selected")[0].value == "3"){
    $("#table-content-body").html("<%= j render @readys %>");
  }
})
