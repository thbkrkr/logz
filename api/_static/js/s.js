(function(){

  /* $param(name) */
  this.$param = function $param(name) {
      var url = window.location.href
      name = name.replace(/[\[\]]/g, "\\$&")
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
          results = regex.exec(url)
      if (!results) return null
      if (!results[2]) return ''
      return decodeURIComponent(results[2].replace(/\+/g, " "))
  }

  /* $tpl(templateId, dataObject) */
  var cache = {};
  this.$tpl = function $tpl(str, data) {
    // Figure out if we're getting a template, or if we need to
    // load the template - and be sure to cache the result.
    var fn = !/\W/.test(str) ?
      cache[str] = cache[str] ||
        $tpl(document.getElementById(str).innerHTML) :

      // Generate a reusable function that will serve as a template
      // generator (and which will be cached).
      new Function("obj",
        "var p=[],print=function(){p.push.apply(p,arguments);};" +

        // Introduce the data as local variables using with(){}
        "with(obj){p.push('" +

        // Convert the template into pure JavaScript
        str
          .replace(/[\r\t\n]/g, " ")
          .split("<%").join("\t")
          .replace(/((^|%>)[^\t]*)'/g, "$1\r")
          .replace(/\t=(.*?)%>/g, "',$1,'")
          .split("\t").join("');")
          .split("%>").join("p.push('")
          .split("\r").join("\\'")
      + "');}return p.join('');")

    // Provide some basic currying to the user
    return data ? fn( data ) : fn
  }

  /* $get(url, onSuccess, onFailure) */
  this.$get = function $get(url, onSuccess, onFailure) {

    var headers = {}
    var auth = localStorage.getItem('auth')
    if (auth) {
      headers['X-Qaas-Auth'] = auth
    }
    $.ajax({
      type: 'GET',
      url: url,
      headers: headers,
      success: function(response) {
        if (typeof response === 'object') {
          onSuccess(response)
        } else {
          onSuccess(JSON.parse(response))
        }
      },
      error: function(xhr, errorType, error) {
        // Redirect to home if authentication error
        if (xhr.status === 401) {
          window.location = '/'
        }
        if (!onFailure) {
          console.error("error on " + xhr.responseURL + " status="+ xhr.status)
          return
        }
        onFailure(error)
      }
    })
  }

  this.$round = function $round(val) {
    if (isNaN(val)) return val
    //return Number((val).toFixed(2));
    return numeral(val).format('0 0.00 a');
  }

  this.$lsSet = function $lsSet(key, value) {
    localStorage.setItem(key, value)
  }

  this.$lsGet = function $lsGet(key) {
    return localStorage.getItem(key)
  }

  this.$lsRm = function $lsRm(key) {
    localStorage.removeItem(key)
  }

})();

