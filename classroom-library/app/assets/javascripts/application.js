// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function(){

  $('#grouping-selection-form').submit(function(){
    setTimeout(function(){

    var targets = $('[data-draggable="target"]');
    for (i=0; i< targets.length; i++){
      targets[i].setAttribute('aria-dropeffect', 'none');
    }

    var students = $('[data-draggable="student"]');
    for (i = 0; i < students.length; i++){
      students[i].setAttribute('draggable', 'true');
      students[i].setAttribute('aria-grabbed', 'false');
    }

    var selections = {
            students   : [],
            owner      : null,
            droptarget : null
    };

  function addSelection(student){
    if (!selections.owner){
      selections.owner = student.parentNode;
    } else if (selections.owner != student.parentNode) {
      return;
    }

    student.setAttribute('aria-grabbed', 'true');

    selections.students.push(student);
  }

  function removeSelection(student){
    student.setAttribute('aria-grabbed', 'false')

    for (var i = 0; i < selections.students.length; i++){
      if (selections.students[i] == student){
        selections.students.splice(i,1);
        break;
      }
    }
  }

  function clearSelections(){
    if (selections.students.length){
      selections.owner = null;
      for (var i = 0; i < selections.students.length; i++){
        selections.students[i].setAttribute('aria-grabbed', 'false')
      }
      selections.students = [];
    }
  }

  function hasModifier(event){
      return (event.ctrlKey || event.metaKey || event.shiftKey);
  }


  function addDropEffects(){
    for (var i=0; i<targets.length;i++){
      if (targets[i] != selections.owner && targets[i].getAttribute('aria-dropeffect') == 'none'){
        targets[i].setAttribute('aria-dropeffect', 'move');
      }
    }
    for (var i=0; i< students.length;i++){
      if (students[i].parentNode != selections.owner && students[i].getAttribute('aria-grabbed')){
        students[i].removeAttribute('aria-grabbed');
      }
    }
  }

  function clearDropEffects(){
    if(selections.students.length){
      for (var i=0; i<targets.length; i++){
        if(targets[i].getAttribute('aria-dropeffect') != 'none'){
          targets[i].setAttribute('aria-dropeffect', 'none')
        }
      }
      for (var i = 0; i < students.length; i ++){
          if(!students[i].getAttribute('aria-grabbed')) {
               students[i].setAttribute('aria-grabbed', 'false');
           }
      }
    }
  }

  document.getElementById('group-display-area').addEventListener('mousedown', function(event){
    if (event.target.getAttribute('draggable')){
      clearDropEffects();
      if (!hasModifier(event) && event.target.getAttribute('aria-grabbed') == 'false'){
        clearSelections();
        addSelection(event.target);
      }
    } else if(!hasModifier(event)){
      clearDropEffects();
      clearSelections();
    } else {
      clearDropEffects();
    }

  }, false);

  document.getElementById('group-display-area').addEventListener('mouseup', function(event) {
       if (event.target.getAttribute('draggable') && hasModifier(event)) {
           if(event.target.getAttribute('aria-grabbed') == 'true'){
               removeSelection(event.target);
               if(!selections.items.length) {
                   selections.owner = null;
               }
           } else {
               addSelection(event.target);
           }
       }

   }, false);


  document.getElementById('group-display-area').addEventListener('dragstart', function(event){
    if (selections.owner != event.target.parentNode){
      event.preventDefault();
      return;
    }
    if (hasModifier(event) && event.target.getAttribute('aria-grabbed') == 'false'){
      addSelection(event.target);
    }
    event.dataTransfer.setData('text', '');
    addDropEffects();

    student = event.target
    event.dataTransfer.setData('text', '')
  }, false);


  function getContainer(element){
    do {
      if (element.nodeType === 1 && element.getAttribute('aria-dropeffect')){
        return element;
      }
    }
    while(element = element.parentNode);
  };


  var related = null;
  document.getElementById('group-display-area').addEventListener('dragenter', function(event){
    related = event.target
  }, false)


  document.getElementById('group-display-area').addEventListener('dragleave', function(event){
    var droptarget = getContainer(related)
    if (droptarget == selections.owner){
      droptarget = null;
    }
    if (droptarget != selections.droptarget){
      if (selections.droptarget){
        selections.droptarget.className = selections.droptarget.className.replace(/dragover/g,'');
      }
      if (droptarget){
        droptarget.className += ' dragover';
      }
      selections.droptarget = droptarget;
    }
  }, false);

  document.getElementById('group-display-area').addEventListener('dragover', function(event){
    if (selections.students.length){
      event.preventDefault();
    }
  }, false);

  document.getElementById('group-display-area').addEventListener('dragend', function(event){
    if (selections.droptarget){
      for(var i =0; i < selections.students.length; i++){
        selections.droptarget.appendChild(selections.students[i]);
      }
      event.preventDefault();
    }
    if (selections.students.length){
      clearDropEffects();
      if (selections.droptarget){
        clearSelections();
        selections.droptarget.className = selections.droptarget.className.replace(/ dragover/g, '');
        selections.droptarget = null;
      }
    }
  }, false);
  }, 1000);
});




  $('#grouping-selection-form').on("submit", function(event){
    event.preventDefault()
    var requestData = $(this).serialize()
    var path = $(this).attr('action')

    $.ajax({
      url: path,
      type: 'post',
      data: requestData,

    }).done(function(serverData){
      console.log('success')
      console.log(serverData)
      // $('#group-display-area').empty();
      $('#group-display-area').append(serverData);

    }).fail(function(){
      console.log('fail')
    });
  });


  $('#group-display-area').on("click", '#save-group-button', function(event){
    var collectedGroups = []

    $('.g').each(function(){
      groupMembers = []
      $(this).find('.s').each(function(){
        groupMembers.push(this.innerText)
      })
      collectedGroups.push(groupMembers)
    })

    var groupName = $('#save-group-name').val()

    $.ajax({
      url: "/groups/new",
      type: 'post',
      data: {grouping: collectedGroups, name: groupName},

    }).done(function(serverData){
      console.log('success')
      $('#group-display-area').empty()
      $('body').append(serverData)
    }).fail(function(){
      console.log('fail')
    })
  })

  $('.delete-group-form').on("click", function(event){
    event.preventDefault()
    var path = $(this).attr("action")

    var deletedForm = this

    $.ajax({
      url: path,
      type: 'delete',

    }).done(function(serverData){
      console.log('success')
      $(deletedForm).parent().remove()
    }).fail(function(){
      console.log('fail')
    })
  })



  $('#review-delete-form').on("submit", function(event) {
    event.preventDefault()

    var path = $(this).attr('action')
    var requestData = $('#review-delete-form').serialize()
    console.log(requestData)
    var targetedDeleteForm = this

    $.ajax({
      url: path,
      type: 'put',
      data: requestData,

    }).done(function(){
      $(targetedDeleteForm).parent().remove()
      console.log('success')
    }).fail(function(){
      console.log('fail')
    })
  })

  $('.favorite-unfavorite-image-text').on("click", function(event){
    event.preventDefault();

    var baseRoute = $(this).parent().attr("href");
    if (baseRoute[9] == "u") {
      var route = baseRoute.substr(0,8) + "/favorite"
    } else{
      var route = baseRoute.substr(0,8) + "/unfavorite"
    }

    $.ajax({
      url: route,
      type: 'get',

    }).done(function(serverData){
    var baseRoute = $('.favorite-unfavorite-image-text').parent().attr("href")
    if (baseRoute[9] == "u" ) {
      var newRoute = baseRoute.substr(0,8) + "/favorite";
    } else{
      var newRoute = baseRoute.substr(0,8) + "/unfavorite";
    }

      $('.favorite-unfavorite-container > a').attr("href", newRoute);
      $('.favorite-unfavorite-image-text').attr("src", serverData);

    }).fail(function(serverData){
      console.log(serverData)
      console.log('fail');
    });
  });

  $('.favorite-unfavorite-image-genre').on("click", function(event){
    event.preventDefault();

    var baseRoute = $(this).parent().attr("href");
    if (baseRoute[10] == "u") {
      var route = baseRoute.substr(0,9) + "/favorite"
    } else{
      var route = baseRoute.substr(0,9) + "/unfavorite"
    }

    var originalTarget = this;

    $.ajax({
      url: route,
      type: 'get',

    }).done(function(serverData){

      if (baseRoute[10] == "u") {
        var newRoute = baseRoute.substr(0,8) + serverData.genre_id + "/favorite";
      } else {
        var newRoute = baseRoute.substr(0,8) + serverData.genre_id + "/unfavorite";
      }

      $(originalTarget).parent().attr("href", newRoute);
      $(originalTarget).attr("src", serverData.image_location);

    }).fail(function(serverData){
      console.log('fail');
    });
  });


  $('ul.nav > li').on("click", function (e) {
    $(this).addClass('active')
  })

  $('.col-xs-2').mouseover(function(){
    var tabBackgroundColor = $(this).children().css("background-color")
    $("#display-area").css("background-color", tabBackgroundColor)
  })



   var ajaxRequest;

   var searchResults = []

   var typingTimer;
   var doneTypingInterval = 300;

   //on keyup, start the countdown
   $('#search-texts').keyup(function(){
       clearTimeout(typingTimer);
          typingTimer = setTimeout(doneTyping, doneTypingInterval);
   });

   //user is "finished typing," do something
  function doneTyping () {
    var query = $('#search-texts').val();
    console.log(query)

    if(query.length >= 3){
      var resultTitle = $('.new-search-result').children().first().text()
      if (searchResults.indexOf(resultTitle) === -1){

        ajaxRequest = $.ajax({
          url: '/texts/search',
          type: 'get',
          data: {'search_keyword': query},
        });

        ajaxRequest.done(function(serverData){
          console.log('success')
            $('#search-dropdown').append(serverData);
            resultTitle = $('.new-search-result').children().first().text()
            searchResults.push(resultTitle)
            console.log(searchResults)
          $('#search-texts').on("keyup", function(e){
            if (e.keyCode === 8){
              $('#search-texts').siblings().remove()
              searchResults = []
            }
          })
        })

        ajaxRequest.fail(function(serverData){
          console.log('fail')
        })
       }
    };
   }

});



