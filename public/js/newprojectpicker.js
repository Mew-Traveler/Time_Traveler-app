$(function () {
        $('#datetimepickerFrom').datetimepicker();
        $('#datetimepickerTo').datetimepicker();
        $('#datepickerstarttiming').datetimepicker({
          format: 'HH:ii p',
              autoclose: true,
              // todayHighlight: true,
              showMeridian: true,
              startView: 1,
              maxView: 1
         });
         $('#datepickerendtiming').datetimepicker({
           format: 'HH:ii p',
               autoclose: true,
               // todayHighlight: true,
               showMeridian: true,
               startView: 1,
               maxView: 1
          });
          BnbChosen();
          DailySaved();
  });

function BnbChosen(){
  $('.aaf').on("click",function(){
    console.log(".aad");
    var text = $( this ).text();
    $('#destbnb').val(text);
    var id = $(this).attr('data-id');
    $('#bnbid').val(id);
  })
}

function DailySaved(){
  $('#savedaily').on("click",function(){
    console.log(".savedaily");
    console.log($('#destbnb').val());
    console.log($('#oribnb').val());
    console.log($('#starttiming').val());
    console.log($('#nthday').val());

    $.ajax({
  		url: "/daily/basic",
  		type: "POST",
  		contentType: "application/json; charset=utf-8",
  		dataType: "json",
  		data: JSON.stringify({
  			projectId: $('#ids').val(),
  			roomId: $('#bnbid').val(),
        nthday:$('#nthday').val(),
        timeStart:$('#starttiming').val(),
        timeEnd:$('#endtiming').val(),
        locateStart:$('#oribnb').val(),
        locateEnd:$('#destbnb').val(),
  		}),
  		success: function(data){
  			console.log(data);
  			alert('你成功建立新群組『'+newTitle+'』');

  		},
  		error:function (jqXHR, textStatus, errorThrown) {

            console.log(jqXHR.state());
        }
  	});
  })
}
