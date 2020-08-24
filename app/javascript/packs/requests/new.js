jQuery(function ($) {
  $('#request_plane_id').on('change' , function(e) {
    getDataFromRequest($('#request_plane_id')[0].value)
  })

  function getDataFromRequest(plane_id) {
    window.fetch('http://localhost:3000/requests/' + plane_id, {
     method: 'GET'
      })
      .then(res => res.json())
      .then(response => {
        $('#request_location_id').text('')
        for(let i = 0; i < response.location.length; ++i) {
          $('#request_location_id').append(`<option value="${response.location[i].id}">${response.location[i].id}</option>`)
        }
      })
  }
})
