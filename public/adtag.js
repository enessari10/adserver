(function(){
  var scriptUrl;
  try { scriptUrl = new URL(document.currentScript && document.currentScript.src); } catch(e) { scriptUrl = null; }
  var baseOrigin = window.AD_SERVER_BASE || (scriptUrl ? scriptUrl.origin : window.location.origin);
  var API_BASE = baseOrigin + '/api';
  function uuid(){return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g,function(c){var r=Math.random()*16|0,v=c==='x'?r:(r&0x3|0x8);return v.toString(16)})}
  function post(path, payload){
    try {
      navigator.sendBeacon(API_BASE + path, new Blob([JSON.stringify(payload)], { type: 'application/json' }));
    } catch (e) {
      fetch(API_BASE + path, { method: 'POST', headers: { 'Content-Type':'application/json' }, body: JSON.stringify(payload), keepalive: true, mode: 'cors', credentials: 'omit' }).catch(function(){})
    }
  }

  function pixel(path, params){
    try {
      var url = API_BASE + path + '?' + new URLSearchParams(params).toString();
      var img = new Image(1,1);
      img.src = url;
    } catch(e){}
  }

  function trackImpression(cfg){
    var rid = cfg.requestId || uuid();
    var payload = {
      ad_id: cfg.adId || null,
      campaign_id: cfg.campaignId || null,
      request_id: rid,
      user_agent: navigator.userAgent,
      referer: document.referrer || location.href
    };
    post('/stats/impression', payload);
    pixel('/stats/impression.gif', payload);
    return rid;
  }

  function trackClick(cfg){
    var payload = {
      ad_id: cfg.adId || null,
      campaign_id: cfg.campaignId || null,
      request_id: cfg.requestId || null,
      user_agent: navigator.userAgent,
      referer: document.referrer || location.href
    };
    post('/stats/click', payload);
    pixel('/stats/click.gif', payload);
  }

  // Auto-binding: elements with data-ad-id trigger impression when in view once, click on anchor
  function autoBind(){
    var nodes = document.querySelectorAll('[data-ad-id]');
    var seen = new WeakSet();
    var io = null;
    if ('IntersectionObserver' in window) {
      io = new IntersectionObserver(function(entries){
        entries.forEach(function(entry){
          if (entry.isIntersecting && entry.intersectionRatio >= 0.5 && !seen.has(entry.target)) {
            seen.add(entry.target);
            var rid = trackImpression({ adId: entry.target.getAttribute('data-ad-id'), campaignId: entry.target.getAttribute('data-campaign-id') });
            entry.target.setAttribute('data-request-id', rid);
          }
        });
      }, { threshold: [0.5] });
    }

    nodes.forEach(function(node){
      if (io) {
        io.observe(node);
      } else {
        if (!seen.has(node)) {
          seen.add(node);
          var ridFallback = trackImpression({ adId: node.getAttribute('data-ad-id'), campaignId: node.getAttribute('data-campaign-id') });
          node.setAttribute('data-request-id', ridFallback);
        }
      }
      var link = node.querySelector('a');
      // Optional: custom click selector
      var sel = node.getAttribute('data-click-selector');
      if (!link && sel) {
        try { link = node.querySelector(sel); } catch(e){}
      }
      if (link) {
        link.addEventListener('click', function(evt){
          try { evt.preventDefault(); } catch(e){}
          var reqId = node.getAttribute('data-request-id');
          trackClick({ adId: node.getAttribute('data-ad-id'), campaignId: node.getAttribute('data-campaign-id'), requestId: reqId });
          var target = link.getAttribute('href');
          if (!target || target === '#' || target === 'javascript:void(0)') {
            var dataTarget = node.getAttribute('data-target-url');
            if (dataTarget) target = dataTarget;
          }
          if (target) {
            var openInNew = link.getAttribute('target') === '_self' ? false : true;
            setTimeout(function(){
              if (openInNew) window.open(target, '_blank');
              else window.location.href = target;
            }, 50);
          }
        });
      } else {
        // No anchor element; track clicks on container without redirect
        node.addEventListener('click', function(){
          var reqId = node.getAttribute('data-request-id');
          trackClick({ adId: node.getAttribute('data-ad-id'), campaignId: node.getAttribute('data-campaign-id'), requestId: reqId });
        });
      }
    });
  }

  if (document.readyState === 'complete' || document.readyState === 'interactive') {
    setTimeout(autoBind, 0);
  } else {
    document.addEventListener('DOMContentLoaded', autoBind);
  }

  window.AdServer = { trackImpression: trackImpression, trackClick: trackClick };
})();


