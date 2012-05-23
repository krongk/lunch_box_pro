 $(document).ready(function() {
    load_editors();
  });

  function load_editors(){
    tinyMCE.init({
      mode: 'textareas',
      language : "zh-cn",
      theme: 'simple'
      //theme: 'advanced'

    });
  }

