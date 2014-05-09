




<!DOCTYPE html>
<html class="   ">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    
    
    <title>octopress-tagcloud/plugins/tag_cloud.rb at master · tokkonopapa/octopress-tagcloud</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub" />
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub" />
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114.png" />
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-144.png" />
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144.png" />
    <meta property="fb:app_id" content="1401488693436528"/>

      <meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="tokkonopapa/octopress-tagcloud" name="twitter:title" /><meta content="octopress-tagcloud - Tag cloud plugin for Octopress" name="twitter:description" /><meta content="https://avatars3.githubusercontent.com/u/828814?s=400" name="twitter:image:src" />
<meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="https://avatars3.githubusercontent.com/u/828814?s=400" property="og:image" /><meta content="tokkonopapa/octopress-tagcloud" property="og:title" /><meta content="https://github.com/tokkonopapa/octopress-tagcloud" property="og:url" /><meta content="octopress-tagcloud - Tag cloud plugin for Octopress" property="og:description" />

    <link rel="assets" href="https://github.global.ssl.fastly.net/">
    <link rel="conduit-xhr" href="https://ghconduit.com:25035/">
    <link rel="xhr-socket" href="/_sockets" />

    <meta name="msapplication-TileImage" content="/windows-tile.png" />
    <meta name="msapplication-TileColor" content="#ffffff" />
    <meta name="selected-link" value="repo_source" data-pjax-transient />
    <meta content="collector.githubapp.com" name="octolytics-host" /><meta content="collector-cdn.github.com" name="octolytics-script-host" /><meta content="github" name="octolytics-app-id" /><meta content="72F73202:2000:394F9F9:536CB4CD" name="octolytics-dimension-request_id" /><meta content="2884882" name="octolytics-actor-id" /><meta content="wangzz" name="octolytics-actor-login" /><meta content="b3672186737998de8abdf9d1f2e059f39598df96cb59efeeb3d750dbec79d38b" name="octolytics-actor-hash" />
    

    
    
    <link rel="icon" type="image/x-icon" href="https://github.global.ssl.fastly.net/favicon.ico" />

    <meta content="authenticity_token" name="csrf-param" />
<meta content="rx81Gi4j7/m/feaCcbSW+Wa5jJyS6oq+qmSvFaFTYl9qGBgRyrpvCwJY92heb/jP+DQk77yRbaOHc6lu5zQ4jA==" name="csrf-token" />

    <link href="https://github.global.ssl.fastly.net/assets/github-342dc1ceccdbd5139c1adebf91586840a05f4b28.css" media="all" rel="stylesheet" type="text/css" />
    <link href="https://github.global.ssl.fastly.net/assets/github2-f50c09aa92f8858777f3f33225ec6b65051ac3de.css" media="all" rel="stylesheet" type="text/css" />
    


        <script crossorigin="anonymous" src="https://github.global.ssl.fastly.net/assets/frameworks-a6f92b4988ace11684156397e69ddb85024b3d5a.js" type="text/javascript"></script>
        <script async="async" crossorigin="anonymous" src="https://github.global.ssl.fastly.net/assets/github-8ba98a93c8c6f7686da7767bdb27adc5b608c884.js" type="text/javascript"></script>
        
        
      <meta http-equiv="x-pjax-version" content="72f4c9204803f08f3f34ddcfc0127854">

      
  <meta name="description" content="octopress-tagcloud - Tag cloud plugin for Octopress" />

  <meta content="828814" name="octolytics-dimension-user_id" /><meta content="tokkonopapa" name="octolytics-dimension-user_login" /><meta content="3107909" name="octolytics-dimension-repository_id" /><meta content="tokkonopapa/octopress-tagcloud" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="3107909" name="octolytics-dimension-repository_network_root_id" /><meta content="tokkonopapa/octopress-tagcloud" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/tokkonopapa/octopress-tagcloud/commits/master.atom" rel="alternate" title="Recent Commits to octopress-tagcloud:master" type="application/atom+xml" />

  </head>


  <body class="logged_in  env-production macintosh vis-public page-blob">
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>
    <div class="wrapper">
      
      
      
      


      <div class="header header-logged-in true">
  <div class="container clearfix">

    <a class="header-logo-invertocat" href="https://github.com/">
  <span class="mega-octicon octicon-mark-github"></span>
</a>

    
    <a href="/notifications" aria-label="You have no unread notifications" class="notification-indicator tooltipped tooltipped-s" data-hotkey="g n">
        <span class="mail-status all-read"></span>
</a>

      <div class="command-bar js-command-bar  in-repository">
          <form accept-charset="UTF-8" action="/search" class="command-bar-form" id="top_search_form" method="get">

<div class="commandbar">
  <span class="message"></span>
  <input type="text" data-hotkey="s, /" name="q" id="js-command-bar-field" placeholder="Search or type a command" tabindex="1" autocapitalize="off"
    
    data-username="wangzz"
      data-repo="tokkonopapa/octopress-tagcloud"
      data-branch="master"
      data-sha="f3f508fb96323a1771944ad4d4681406add5ee14"
  >
  <div class="display hidden"></div>
</div>

    <input type="hidden" name="nwo" value="tokkonopapa/octopress-tagcloud" />

    <div class="select-menu js-menu-container js-select-menu search-context-select-menu">
      <span class="minibutton select-menu-button js-menu-target" role="button" aria-haspopup="true">
        <span class="js-select-button">This repository</span>
      </span>

      <div class="select-menu-modal-holder js-menu-content js-navigation-container" aria-hidden="true">
        <div class="select-menu-modal">

          <div class="select-menu-item js-navigation-item js-this-repository-navigation-item selected">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" class="js-search-this-repository" name="search_target" value="repository" checked="checked" />
            <div class="select-menu-item-text js-select-button-text">This repository</div>
          </div> <!-- /.select-menu-item -->

          <div class="select-menu-item js-navigation-item js-all-repositories-navigation-item">
            <span class="select-menu-item-icon octicon octicon-check"></span>
            <input type="radio" name="search_target" value="global" />
            <div class="select-menu-item-text js-select-button-text">All repositories</div>
          </div> <!-- /.select-menu-item -->

        </div>
      </div>
    </div>

  <span class="help tooltipped tooltipped-s" aria-label="Show command bar help">
    <span class="octicon octicon-question"></span>
  </span>


  <input type="hidden" name="ref" value="cmdform">

</form>
        <ul class="top-nav">
          <li class="explore"><a href="/explore">Explore</a></li>
            <li><a href="https://gist.github.com">Gist</a></li>
            <li><a href="/blog">Blog</a></li>
          <li><a href="https://help.github.com">Help</a></li>
        </ul>
      </div>

    


  <ul id="user-links">
    <li>
      <a href="/wangzz" class="name">
        <img alt="王中周" class=" js-avatar" data-user="2884882" height="20" src="https://avatars0.githubusercontent.com/u/2884882?s=140" width="20" /> wangzz
      </a>
    </li>

    <li class="new-menu dropdown-toggle js-menu-container">
      <a href="#" class="js-menu-target tooltipped tooltipped-s" aria-label="Create new...">
        <span class="octicon octicon-plus"></span>
        <span class="dropdown-arrow"></span>
      </a>

      <div class="new-menu-content js-menu-content">
      </div>
    </li>

    <li>
      <a href="/settings/profile" id="account_settings"
        class="tooltipped tooltipped-s"
        aria-label="Account settings ">
        <span class="octicon octicon-tools"></span>
      </a>
    </li>
    <li>
      <form class="logout-form" action="/logout" method="post">
        <button class="sign-out-button tooltipped tooltipped-s" aria-label="Sign out">
          <span class="octicon octicon-log-out"></span>
        </button>
      </form>
    </li>

  </ul>

<div class="js-new-dropdown-contents hidden">
  

<ul class="dropdown-menu">
  <li>
    <a href="/new"><span class="octicon octicon-repo-create"></span> New repository</a>
  </li>
  <li>
    <a href="/organizations/new"><span class="octicon octicon-organization"></span> New organization</a>
  </li>


    <li class="section-title">
      <span title="tokkonopapa/octopress-tagcloud">This repository</span>
    </li>
      <li>
        <a href="/tokkonopapa/octopress-tagcloud/issues/new"><span class="octicon octicon-issue-opened"></span> New issue</a>
      </li>
</ul>

</div>


    
  </div>
</div>

      

        



      <div id="start-of-content" class="accessibility-aid"></div>
          <div class="site" itemscope itemtype="http://schema.org/WebPage">
    <div id="js-flash-container">
      
    </div>
    <div class="pagehead repohead instapaper_ignore readability-menu">
      <div class="container">
        

<ul class="pagehead-actions">

    <li class="subscription">
      <form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="aLA4/ov4mG6jsB12ZrUkgvOl6s09SUTEo9WlM0xjrwp6GyXExvudXMMO/0+JevW1ls+TI1oi6hMawMRhcFv9dg==" /></div>  <input id="repository_id" name="repository_id" type="hidden" value="3107909" />

    <div class="select-menu js-menu-container js-select-menu">
      <a class="social-count js-social-count" href="/tokkonopapa/octopress-tagcloud/watchers">
        6
      </a>
      <span class="minibutton select-menu-button with-count js-menu-target" role="button" tabindex="0" aria-haspopup="true">
        <span class="js-select-button">
          <span class="octicon octicon-eye-watch"></span>
          Watch
        </span>
      </span>

      <div class="select-menu-modal-holder">
        <div class="select-menu-modal subscription-menu-modal js-menu-content" aria-hidden="true">
          <div class="select-menu-header">
            <span class="select-menu-title">Notification status</span>
            <span class="octicon octicon-remove-close js-menu-close"></span>
          </div> <!-- /.select-menu-header -->

          <div class="select-menu-list js-navigation-container" role="menu">

            <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input checked="checked" id="do_included" name="do" type="radio" value="included" />
                <h4>Not watching</h4>
                <span class="description">You only receive notifications for conversations in which you participate or are @mentioned.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye-watch"></span>
                  Watch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_subscribed" name="do" type="radio" value="subscribed" />
                <h4>Watching</h4>
                <span class="description">You receive notifications for all conversations in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-eye-unwatch"></span>
                  Unwatch
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

            <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <div class="select-menu-item-text">
                <input id="do_ignore" name="do" type="radio" value="ignore" />
                <h4>Ignoring</h4>
                <span class="description">You do not receive any notifications for conversations in this repository.</span>
                <span class="js-select-button-text hidden-select-button-text">
                  <span class="octicon octicon-mute"></span>
                  Stop ignoring
                </span>
              </div>
            </div> <!-- /.select-menu-item -->

          </div> <!-- /.select-menu-list -->

        </div> <!-- /.select-menu-modal -->
      </div> <!-- /.select-menu-modal-holder -->
    </div> <!-- /.select-menu -->

</form>
    </li>

  <li>
  

  <div class="js-toggler-container js-social-container starring-container ">

    <form accept-charset="UTF-8" action="/tokkonopapa/octopress-tagcloud/unstar" class="js-toggler-form starred" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="IQd9dck5agWtLOxjVvBUtVU77dZIpd7hntGZUD1nlUvQ+8RWeFAYrp9Sze+CHdXYBcGLDMVeyuvqHfxZkG28cQ==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Unstar this repository" title="Unstar tokkonopapa/octopress-tagcloud">
        <span class="octicon octicon-star-delete"></span><span class="text">Unstar</span>
      </button>
        <a class="social-count js-social-count" href="/tokkonopapa/octopress-tagcloud/stargazers">
          76
        </a>
</form>
    <form accept-charset="UTF-8" action="/tokkonopapa/octopress-tagcloud/star" class="js-toggler-form unstarred" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="authenticity_token" type="hidden" value="Wr16e3EUhbLSzytt0A5dpyZiFrXre9ZDvaafhkmORKzGtc1a/t9o3ldeD1Cdm6ly4aHI66RIX2+Lv7DHLlve+w==" /></div>
      <button
        class="minibutton with-count js-toggler-target star-button"
        aria-label="Star this repository" title="Star tokkonopapa/octopress-tagcloud">
        <span class="octicon octicon-star"></span><span class="text">Star</span>
      </button>
        <a class="social-count js-social-count" href="/tokkonopapa/octopress-tagcloud/stargazers">
          76
        </a>
</form>  </div>

  </li>


        <li>
          <a href="/tokkonopapa/octopress-tagcloud/fork" class="minibutton with-count js-toggler-target fork-button lighter tooltipped-n" title="Fork your own copy of tokkonopapa/octopress-tagcloud to your account" aria-label="Fork your own copy of tokkonopapa/octopress-tagcloud to your account" rel="nofollow" data-method="post">
            <span class="octicon octicon-git-branch-create"></span><span class="text">Fork</span>
          </a>
          <a href="/tokkonopapa/octopress-tagcloud/network" class="social-count">55</a>
        </li>


</ul>

        <h1 itemscope itemtype="http://data-vocabulary.org/Breadcrumb" class="entry-title public">
          <span class="repo-label"><span>public</span></span>
          <span class="mega-octicon octicon-repo"></span>
          <span class="author"><a href="/tokkonopapa" class="url fn" itemprop="url" rel="author"><span itemprop="title">tokkonopapa</span></a></span><!--
       --><span class="path-divider">/</span><!--
       --><strong><a href="/tokkonopapa/octopress-tagcloud" class="js-current-repository js-repo-home-link">octopress-tagcloud</a></strong>

          <span class="page-context-loader">
            <img alt="Octocat-spinner-32" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
          </span>

        </h1>
      </div><!-- /.container -->
    </div><!-- /.repohead -->

    <div class="container">
      <div class="repository-with-sidebar repo-container new-discussion-timeline js-new-discussion-timeline  ">
        <div class="repository-sidebar clearfix">
            

<div class="sunken-menu vertical-right repo-nav js-repo-nav js-repository-container-pjax js-octicon-loaders">
  <div class="sunken-menu-contents">
    <ul class="sunken-menu-group">
      <li class="tooltipped tooltipped-w" aria-label="Code">
        <a href="/tokkonopapa/octopress-tagcloud" aria-label="Code" class="selected js-selected-navigation-item sunken-menu-item" data-hotkey="g c" data-pjax="true" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /tokkonopapa/octopress-tagcloud">
          <span class="octicon octicon-code"></span> <span class="full-word">Code</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

        <li class="tooltipped tooltipped-w" aria-label="Issues">
          <a href="/tokkonopapa/octopress-tagcloud/issues" aria-label="Issues" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g i" data-selected-links="repo_issues /tokkonopapa/octopress-tagcloud/issues">
            <span class="octicon octicon-issue-opened"></span> <span class="full-word">Issues</span>
            <span class='counter'>2</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>

      <li class="tooltipped tooltipped-w" aria-label="Pull Requests">
        <a href="/tokkonopapa/octopress-tagcloud/pulls" aria-label="Pull Requests" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-hotkey="g p" data-selected-links="repo_pulls /tokkonopapa/octopress-tagcloud/pulls">
            <span class="octicon octicon-git-pull-request"></span> <span class="full-word">Pull Requests</span>
            <span class='counter'>0</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>


        <li class="tooltipped tooltipped-w" aria-label="Wiki">
          <a href="/tokkonopapa/octopress-tagcloud/wiki" aria-label="Wiki" class="js-selected-navigation-item sunken-menu-item" data-hotkey="g w" data-pjax="true" data-selected-links="repo_wiki /tokkonopapa/octopress-tagcloud/wiki">
            <span class="octicon octicon-book"></span> <span class="full-word">Wiki</span>
            <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>        </li>
    </ul>
    <div class="sunken-menu-separator"></div>
    <ul class="sunken-menu-group">

      <li class="tooltipped tooltipped-w" aria-label="Pulse">
        <a href="/tokkonopapa/octopress-tagcloud/pulse" aria-label="Pulse" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="pulse /tokkonopapa/octopress-tagcloud/pulse">
          <span class="octicon octicon-pulse"></span> <span class="full-word">Pulse</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Graphs">
        <a href="/tokkonopapa/octopress-tagcloud/graphs" aria-label="Graphs" class="js-selected-navigation-item sunken-menu-item" data-pjax="true" data-selected-links="repo_graphs repo_contributors /tokkonopapa/octopress-tagcloud/graphs">
          <span class="octicon octicon-graph"></span> <span class="full-word">Graphs</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>

      <li class="tooltipped tooltipped-w" aria-label="Network">
        <a href="/tokkonopapa/octopress-tagcloud/network" aria-label="Network" class="js-selected-navigation-item sunken-menu-item js-disable-pjax" data-selected-links="repo_network /tokkonopapa/octopress-tagcloud/network">
          <span class="octicon octicon-git-branch"></span> <span class="full-word">Network</span>
          <img alt="Octocat-spinner-32" class="mini-loader" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32.gif" width="16" />
</a>      </li>
    </ul>


  </div>
</div>

              <div class="only-with-full-nav">
                

  

<div class="clone-url open"
  data-protocol-type="http"
  data-url="/users/set_protocol?protocol_selector=http&amp;protocol_type=clone">
  <h3><strong>HTTPS</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/tokkonopapa/octopress-tagcloud.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/tokkonopapa/octopress-tagcloud.git" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="ssh"
  data-url="/users/set_protocol?protocol_selector=ssh&amp;protocol_type=clone">
  <h3><strong>SSH</strong> clone URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="git@github.com:tokkonopapa/octopress-tagcloud.git" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="git@github.com:tokkonopapa/octopress-tagcloud.git" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>

  

<div class="clone-url "
  data-protocol-type="subversion"
  data-url="/users/set_protocol?protocol_selector=subversion&amp;protocol_type=clone">
  <h3><strong>Subversion</strong> checkout URL</h3>
  <div class="clone-url-box">
    <input type="text" class="clone js-url-field"
           value="https://github.com/tokkonopapa/octopress-tagcloud" readonly="readonly">
    <span class="url-box-clippy">
    <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="https://github.com/tokkonopapa/octopress-tagcloud" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
    </span>
  </div>
</div>


<p class="clone-options">You can clone with
      <a href="#" class="js-clone-selector" data-protocol="http">HTTPS</a>,
      <a href="#" class="js-clone-selector" data-protocol="ssh">SSH</a>,
      or <a href="#" class="js-clone-selector" data-protocol="subversion">Subversion</a>.
  <span class="help tooltipped tooltipped-n" aria-label="Get help on which URL is right for you.">
    <a href="https://help.github.com/articles/which-remote-url-should-i-use">
    <span class="octicon octicon-question"></span>
    </a>
  </span>
</p>

  <a href="http://mac.github.com" data-url="github-mac://openRepo/https://github.com/tokkonopapa/octopress-tagcloud" class="minibutton sidebar-button js-conduit-rewrite-url" title="Save tokkonopapa/octopress-tagcloud to your computer and use it in GitHub Desktop." aria-label="Save tokkonopapa/octopress-tagcloud to your computer and use it in GitHub Desktop.">
    <span class="octicon octicon-device-desktop"></span>
    Clone in Desktop
  </a>


                <a href="/tokkonopapa/octopress-tagcloud/archive/master.zip"
                   class="minibutton sidebar-button"
                   aria-label="Download tokkonopapa/octopress-tagcloud as a zip file"
                   title="Download tokkonopapa/octopress-tagcloud as a zip file"
                   rel="nofollow">
                  <span class="octicon octicon-cloud-download"></span>
                  Download ZIP
                </a>
              </div>
        </div><!-- /.repository-sidebar -->

        <div id="js-repo-pjax-container" class="repository-content context-loader-container" data-pjax-container>
          

<a href="/tokkonopapa/octopress-tagcloud/blob/1592d931f0c91b1ae79ea3033c25c29fae7b61ef/plugins/tag_cloud.rb" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:dae38cdcc35a50df167bc97ea5b0d340 -->

<p title="This is a placeholder element" class="js-history-link-replace hidden"></p>

<a href="/tokkonopapa/octopress-tagcloud/find/master" data-pjax data-hotkey="t" class="js-show-file-finder" style="display:none">Show File Finder</a>

<div class="file-navigation">
  

<div class="select-menu js-menu-container js-select-menu" >
  <span class="minibutton select-menu-button js-menu-target" data-hotkey="w"
    data-master-branch="master"
    data-ref="master"
    role="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <span class="octicon octicon-git-branch"></span>
    <i>branch:</i>
    <span class="js-select-button">master</span>
  </span>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <span class="select-menu-title">Switch branches/tags</span>
        <span class="octicon octicon-remove-close js-menu-close"></span>
      </div> <!-- /.select-menu-header -->

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" class="js-select-menu-tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" class="js-select-menu-tab">Tags</a>
            </li>
          </ul>
        </div><!-- /.select-menu-tabs -->
      </div><!-- /.select-menu-filters -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <div class="select-menu-item js-navigation-item ">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/tokkonopapa/octopress-tagcloud/blob/issue4/plugins/tag_cloud.rb"
                 data-name="issue4"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="issue4">issue4</a>
            </div> <!-- /.select-menu-item -->
            <div class="select-menu-item js-navigation-item selected">
              <span class="select-menu-item-icon octicon octicon-check"></span>
              <a href="/tokkonopapa/octopress-tagcloud/blob/master/plugins/tag_cloud.rb"
                 data-name="master"
                 data-skip-pjax="true"
                 rel="nofollow"
                 class="js-navigation-open select-menu-item-text js-select-button-text css-truncate-target"
                 title="master">master</a>
            </div> <!-- /.select-menu-item -->
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div> <!-- /.select-menu-list -->

    </div> <!-- /.select-menu-modal -->
  </div> <!-- /.select-menu-modal-holder -->
</div> <!-- /.select-menu -->

  <div class="breadcrumb">
    <span class='repo-root js-repo-root'><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/tokkonopapa/octopress-tagcloud" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">octopress-tagcloud</span></a></span></span><span class="separator"> / </span><span itemscope="" itemtype="http://data-vocabulary.org/Breadcrumb"><a href="/tokkonopapa/octopress-tagcloud/tree/master/plugins" data-branch="master" data-direction="back" data-pjax="true" itemscope="url"><span itemprop="title">plugins</span></a></span><span class="separator"> / </span><strong class="final-path">tag_cloud.rb</strong> <button aria-label="copy to clipboard" class="js-zeroclipboard minibutton zeroclipboard-button" data-clipboard-text="plugins/tag_cloud.rb" data-copied-hint="copied!" type="button"><span class="octicon octicon-clippy"></span></button>
  </div>
</div>


  <div class="commit commit-loader file-history-tease js-deferred-content" data-url="/tokkonopapa/octopress-tagcloud/contributors/master/plugins/tag_cloud.rb">
    Fetching contributors…

    <div class="participation">
      <p class="loader-loading"><img alt="Octocat-spinner-32-eaf2f5" height="16" src="https://github.global.ssl.fastly.net/images/spinners/octocat-spinner-32-EAF2F5.gif" width="16" /></p>
      <p class="loader-error">Cannot retrieve contributors at this time</p>
    </div>
  </div>

<div class="file-box">
  <div class="file">
    <div class="meta clearfix">
      <div class="info file-name">
        <span class="icon"><b class="octicon octicon-file-text"></b></span>
        <span class="mode" title="File Mode">file</span>
        <span class="meta-divider"></span>
          <span>117 lines (105 sloc)</span>
          <span class="meta-divider"></span>
        <span>3.08 kb</span>
      </div>
      <div class="actions">
        <div class="button-group">
            <a class="minibutton tooltipped tooltipped-w js-conduit-openfile-check"
               href="http://mac.github.com"
               data-url="github-mac://openRepo/https://github.com/tokkonopapa/octopress-tagcloud?branch=master&amp;filepath=plugins%2Ftag_cloud.rb"
               aria-label="Open this file in GitHub for Mac"
               data-failed-title="Your version of GitHub for Mac is too old to open this file. Try checking for updates.">
                <span class="octicon octicon-device-desktop"></span> Open
            </a>
                <a class="minibutton tooltipped tooltipped-n js-update-url-with-hash"
                   aria-label="Clicking this button will automatically fork this project so you can edit the file"
                   href="/tokkonopapa/octopress-tagcloud/edit/master/plugins/tag_cloud.rb"
                   data-method="post" rel="nofollow">Edit</a>
          <a href="/tokkonopapa/octopress-tagcloud/raw/master/plugins/tag_cloud.rb" class="button minibutton " id="raw-url">Raw</a>
            <a href="/tokkonopapa/octopress-tagcloud/blame/master/plugins/tag_cloud.rb" class="button minibutton js-update-url-with-hash">Blame</a>
          <a href="/tokkonopapa/octopress-tagcloud/commits/master/plugins/tag_cloud.rb" class="button minibutton " rel="nofollow">History</a>
        </div><!-- /.button-group -->

            <a class="minibutton danger empty-icon tooltipped tooltipped-s"
               href="/tokkonopapa/octopress-tagcloud/delete/master/plugins/tag_cloud.rb"
               aria-label="Fork this project and delete file"
               data-method="post" data-test-id="delete-blob-file" rel="nofollow">

          Delete
        </a>
      </div><!-- /.actions -->
    </div>
        <div class="blob-wrapper data type-ruby js-blob-data">
        <table class="file-code file-diff tab-size-8">
          <tr class="file-code-line">
            <td class="blob-line-nums">
              <span id="L1" rel="#L1">1</span>
<span id="L2" rel="#L2">2</span>
<span id="L3" rel="#L3">3</span>
<span id="L4" rel="#L4">4</span>
<span id="L5" rel="#L5">5</span>
<span id="L6" rel="#L6">6</span>
<span id="L7" rel="#L7">7</span>
<span id="L8" rel="#L8">8</span>
<span id="L9" rel="#L9">9</span>
<span id="L10" rel="#L10">10</span>
<span id="L11" rel="#L11">11</span>
<span id="L12" rel="#L12">12</span>
<span id="L13" rel="#L13">13</span>
<span id="L14" rel="#L14">14</span>
<span id="L15" rel="#L15">15</span>
<span id="L16" rel="#L16">16</span>
<span id="L17" rel="#L17">17</span>
<span id="L18" rel="#L18">18</span>
<span id="L19" rel="#L19">19</span>
<span id="L20" rel="#L20">20</span>
<span id="L21" rel="#L21">21</span>
<span id="L22" rel="#L22">22</span>
<span id="L23" rel="#L23">23</span>
<span id="L24" rel="#L24">24</span>
<span id="L25" rel="#L25">25</span>
<span id="L26" rel="#L26">26</span>
<span id="L27" rel="#L27">27</span>
<span id="L28" rel="#L28">28</span>
<span id="L29" rel="#L29">29</span>
<span id="L30" rel="#L30">30</span>
<span id="L31" rel="#L31">31</span>
<span id="L32" rel="#L32">32</span>
<span id="L33" rel="#L33">33</span>
<span id="L34" rel="#L34">34</span>
<span id="L35" rel="#L35">35</span>
<span id="L36" rel="#L36">36</span>
<span id="L37" rel="#L37">37</span>
<span id="L38" rel="#L38">38</span>
<span id="L39" rel="#L39">39</span>
<span id="L40" rel="#L40">40</span>
<span id="L41" rel="#L41">41</span>
<span id="L42" rel="#L42">42</span>
<span id="L43" rel="#L43">43</span>
<span id="L44" rel="#L44">44</span>
<span id="L45" rel="#L45">45</span>
<span id="L46" rel="#L46">46</span>
<span id="L47" rel="#L47">47</span>
<span id="L48" rel="#L48">48</span>
<span id="L49" rel="#L49">49</span>
<span id="L50" rel="#L50">50</span>
<span id="L51" rel="#L51">51</span>
<span id="L52" rel="#L52">52</span>
<span id="L53" rel="#L53">53</span>
<span id="L54" rel="#L54">54</span>
<span id="L55" rel="#L55">55</span>
<span id="L56" rel="#L56">56</span>
<span id="L57" rel="#L57">57</span>
<span id="L58" rel="#L58">58</span>
<span id="L59" rel="#L59">59</span>
<span id="L60" rel="#L60">60</span>
<span id="L61" rel="#L61">61</span>
<span id="L62" rel="#L62">62</span>
<span id="L63" rel="#L63">63</span>
<span id="L64" rel="#L64">64</span>
<span id="L65" rel="#L65">65</span>
<span id="L66" rel="#L66">66</span>
<span id="L67" rel="#L67">67</span>
<span id="L68" rel="#L68">68</span>
<span id="L69" rel="#L69">69</span>
<span id="L70" rel="#L70">70</span>
<span id="L71" rel="#L71">71</span>
<span id="L72" rel="#L72">72</span>
<span id="L73" rel="#L73">73</span>
<span id="L74" rel="#L74">74</span>
<span id="L75" rel="#L75">75</span>
<span id="L76" rel="#L76">76</span>
<span id="L77" rel="#L77">77</span>
<span id="L78" rel="#L78">78</span>
<span id="L79" rel="#L79">79</span>
<span id="L80" rel="#L80">80</span>
<span id="L81" rel="#L81">81</span>
<span id="L82" rel="#L82">82</span>
<span id="L83" rel="#L83">83</span>
<span id="L84" rel="#L84">84</span>
<span id="L85" rel="#L85">85</span>
<span id="L86" rel="#L86">86</span>
<span id="L87" rel="#L87">87</span>
<span id="L88" rel="#L88">88</span>
<span id="L89" rel="#L89">89</span>
<span id="L90" rel="#L90">90</span>
<span id="L91" rel="#L91">91</span>
<span id="L92" rel="#L92">92</span>
<span id="L93" rel="#L93">93</span>
<span id="L94" rel="#L94">94</span>
<span id="L95" rel="#L95">95</span>
<span id="L96" rel="#L96">96</span>
<span id="L97" rel="#L97">97</span>
<span id="L98" rel="#L98">98</span>
<span id="L99" rel="#L99">99</span>
<span id="L100" rel="#L100">100</span>
<span id="L101" rel="#L101">101</span>
<span id="L102" rel="#L102">102</span>
<span id="L103" rel="#L103">103</span>
<span id="L104" rel="#L104">104</span>
<span id="L105" rel="#L105">105</span>
<span id="L106" rel="#L106">106</span>
<span id="L107" rel="#L107">107</span>
<span id="L108" rel="#L108">108</span>
<span id="L109" rel="#L109">109</span>
<span id="L110" rel="#L110">110</span>
<span id="L111" rel="#L111">111</span>
<span id="L112" rel="#L112">112</span>
<span id="L113" rel="#L113">113</span>
<span id="L114" rel="#L114">114</span>
<span id="L115" rel="#L115">115</span>
<span id="L116" rel="#L116">116</span>

            </td>
            <td class="blob-line-code"><div class="code-body highlight"><pre><div class='line' id='LC1'><span class="c1"># encoding: utf-8</span></div><div class='line' id='LC2'><br/></div><div class='line' id='LC3'><span class="c1"># Tag Cloud for Octopress</span></div><div class='line' id='LC4'><span class="c1"># =======================</span></div><div class='line' id='LC5'><span class="c1"># </span></div><div class='line' id='LC6'><span class="c1"># Description:</span></div><div class='line' id='LC7'><span class="c1"># ------------</span></div><div class='line' id='LC8'><span class="c1"># Easy output tag cloud and category list.</span></div><div class='line' id='LC9'><span class="c1"># </span></div><div class='line' id='LC10'><span class="c1"># Syntax:</span></div><div class='line' id='LC11'><span class="c1"># -------</span></div><div class='line' id='LC12'><span class="c1">#     {% tag_cloud [counter:true] %}</span></div><div class='line' id='LC13'><span class="c1">#     {% category_list [counter:true] %}</span></div><div class='line' id='LC14'><span class="c1"># </span></div><div class='line' id='LC15'><span class="c1"># Example:</span></div><div class='line' id='LC16'><span class="c1"># --------</span></div><div class='line' id='LC17'><span class="c1"># In some template files, you can add the following markups.</span></div><div class='line' id='LC18'><span class="c1"># </span></div><div class='line' id='LC19'><span class="c1"># ### source/_includes/custom/asides/tag_cloud.html ###</span></div><div class='line' id='LC20'><span class="c1"># </span></div><div class='line' id='LC21'><span class="c1">#     &lt;section&gt;</span></div><div class='line' id='LC22'><span class="c1">#       &lt;h1&gt;Tag Cloud&lt;/h1&gt;</span></div><div class='line' id='LC23'><span class="c1">#         &lt;span id=&quot;tag-cloud&quot;&gt;{% tag_cloud %}&lt;/span&gt;</span></div><div class='line' id='LC24'><span class="c1">#     &lt;/section&gt;</span></div><div class='line' id='LC25'><span class="c1"># </span></div><div class='line' id='LC26'><span class="c1"># ### source/_includes/custom/asides/category_list.html ###</span></div><div class='line' id='LC27'><span class="c1"># </span></div><div class='line' id='LC28'><span class="c1">#     &lt;section&gt;</span></div><div class='line' id='LC29'><span class="c1">#       &lt;h1&gt;Categories&lt;/h1&gt;</span></div><div class='line' id='LC30'><span class="c1">#         &lt;ul id=&quot;category-list&quot;&gt;{% category_list counter:true %}&lt;/ul&gt;</span></div><div class='line' id='LC31'><span class="c1">#     &lt;/section&gt;</span></div><div class='line' id='LC32'><span class="c1"># </span></div><div class='line' id='LC33'><span class="c1"># Notes:</span></div><div class='line' id='LC34'><span class="c1"># ------</span></div><div class='line' id='LC35'><span class="c1"># Be sure to insert above template files into `default_asides` array in `_config.yml`.</span></div><div class='line' id='LC36'><span class="c1"># And also you can define styles for &#39;tag-cloud&#39; or &#39;category-list&#39; in a `.scss` file.</span></div><div class='line' id='LC37'><span class="c1"># (ex: `sass/custom/_styles.scss`)</span></div><div class='line' id='LC38'><span class="c1"># </span></div><div class='line' id='LC39'><span class="c1"># Licence:</span></div><div class='line' id='LC40'><span class="c1"># --------</span></div><div class='line' id='LC41'><span class="c1"># Distributed under the [MIT License][MIT].</span></div><div class='line' id='LC42'><span class="c1"># </span></div><div class='line' id='LC43'><span class="c1"># [MIT]: http://www.opensource.org/licenses/mit-license.php</span></div><div class='line' id='LC44'><span class="c1"># </span></div><div class='line' id='LC45'><span class="nb">require</span> <span class="s1">&#39;stringex&#39;</span></div><div class='line' id='LC46'><br/></div><div class='line' id='LC47'><span class="k">module</span> <span class="nn">Jekyll</span></div><div class='line' id='LC48'><br/></div><div class='line' id='LC49'>&nbsp;&nbsp;<span class="k">class</span> <span class="nc">TagCloud</span> <span class="o">&lt;</span> <span class="no">Liquid</span><span class="o">::</span><span class="no">Tag</span></div><div class='line' id='LC50'><br/></div><div class='line' id='LC51'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">initialize</span><span class="p">(</span><span class="n">tag_name</span><span class="p">,</span> <span class="n">markup</span><span class="p">,</span> <span class="n">tokens</span><span class="p">)</span></div><div class='line' id='LC52'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@opts</span> <span class="o">=</span> <span class="p">{}</span></div><div class='line' id='LC53'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="n">markup</span><span class="o">.</span><span class="n">strip</span> <span class="o">=~</span> <span class="sr">/\s*counter:(\w+)/i</span></div><div class='line' id='LC54'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@opts</span><span class="o">[</span><span class="s1">&#39;counter&#39;</span><span class="o">]</span> <span class="o">=</span> <span class="p">(</span><span class="vg">$1</span> <span class="o">==</span> <span class="s1">&#39;true&#39;</span><span class="p">)</span></div><div class='line' id='LC55'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">markup</span> <span class="o">=</span> <span class="n">markup</span><span class="o">.</span><span class="n">strip</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="sr">/counter:\w+/i</span><span class="p">,</span><span class="s1">&#39;&#39;</span><span class="p">)</span></div><div class='line' id='LC56'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC57'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">super</span></div><div class='line' id='LC58'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC59'><br/></div><div class='line' id='LC60'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">render</span><span class="p">(</span><span class="n">context</span><span class="p">)</span></div><div class='line' id='LC61'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">lists</span> <span class="o">=</span> <span class="p">{}</span></div><div class='line' id='LC62'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">max</span><span class="p">,</span> <span class="n">min</span> <span class="o">=</span> <span class="mi">1</span><span class="p">,</span> <span class="mi">1</span></div><div class='line' id='LC63'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">config</span> <span class="o">=</span> <span class="n">context</span><span class="o">.</span><span class="n">registers</span><span class="o">[</span><span class="ss">:site</span><span class="o">].</span><span class="n">config</span></div><div class='line' id='LC64'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">category_dir</span> <span class="o">=</span> <span class="n">config</span><span class="o">[</span><span class="s1">&#39;root&#39;</span><span class="o">]</span> <span class="o">+</span> <span class="n">config</span><span class="o">[</span><span class="s1">&#39;category_dir&#39;</span><span class="o">]</span> <span class="o">+</span> <span class="s1">&#39;/&#39;</span></div><div class='line' id='LC65'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">categories</span> <span class="o">=</span> <span class="n">context</span><span class="o">.</span><span class="n">registers</span><span class="o">[</span><span class="ss">:site</span><span class="o">].</span><span class="n">categories</span></div><div class='line' id='LC66'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">categories</span><span class="o">.</span><span class="n">keys</span><span class="o">.</span><span class="n">sort_by</span><span class="p">{</span> <span class="o">|</span><span class="n">str</span><span class="o">|</span> <span class="n">str</span><span class="o">.</span><span class="n">downcase</span> <span class="p">}</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span><span class="n">category</span><span class="o">|</span></div><div class='line' id='LC67'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">count</span> <span class="o">=</span> <span class="n">categories</span><span class="o">[</span><span class="n">category</span><span class="o">].</span><span class="n">count</span></div><div class='line' id='LC68'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">lists</span><span class="o">[</span><span class="n">category</span><span class="o">]</span> <span class="o">=</span> <span class="n">count</span></div><div class='line' id='LC69'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">max</span> <span class="o">=</span> <span class="n">count</span> <span class="k">if</span> <span class="n">count</span> <span class="o">&gt;</span> <span class="n">max</span></div><div class='line' id='LC70'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC71'><br/></div><div class='line' id='LC72'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">=</span> <span class="s1">&#39;&#39;</span></div><div class='line' id='LC73'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">lists</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span> <span class="n">category</span><span class="p">,</span> <span class="n">counter</span> <span class="o">|</span></div><div class='line' id='LC74'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">url</span> <span class="o">=</span> <span class="n">category_dir</span> <span class="o">+</span> <span class="n">category</span><span class="o">.</span><span class="n">to_url</span></div><div class='line' id='LC75'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">style</span> <span class="o">=</span> <span class="s2">&quot;font-size: </span><span class="si">#{</span><span class="mi">100</span> <span class="o">+</span> <span class="p">(</span><span class="mi">60</span> <span class="o">*</span> <span class="nb">Float</span><span class="p">(</span><span class="n">counter</span><span class="p">)</span><span class="o">/</span><span class="n">max</span><span class="p">)</span><span class="si">}</span><span class="s2">%&quot;</span></div><div class='line' id='LC76'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot;&lt;a href=&#39;</span><span class="si">#{</span><span class="n">url</span><span class="si">}</span><span class="s2">&#39; style=&#39;</span><span class="si">#{</span><span class="n">style</span><span class="si">}</span><span class="s2">&#39;&gt;</span><span class="si">#{</span><span class="n">category</span><span class="si">}</span><span class="s2">&quot;</span></div><div class='line' id='LC77'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="vi">@opts</span><span class="o">[</span><span class="s1">&#39;counter&#39;</span><span class="o">]</span></div><div class='line' id='LC78'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot;(</span><span class="si">#{</span><span class="n">categories</span><span class="o">[</span><span class="n">category</span><span class="o">].</span><span class="n">count</span><span class="si">}</span><span class="s2">)&quot;</span></div><div class='line' id='LC79'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC80'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot;&lt;/a&gt; &quot;</span></div><div class='line' id='LC81'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC82'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span></div><div class='line' id='LC83'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC84'>&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC85'><br/></div><div class='line' id='LC86'>&nbsp;&nbsp;<span class="k">class</span> <span class="nc">CategoryList</span> <span class="o">&lt;</span> <span class="no">Liquid</span><span class="o">::</span><span class="no">Tag</span></div><div class='line' id='LC87'><br/></div><div class='line' id='LC88'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">initialize</span><span class="p">(</span><span class="n">tag_name</span><span class="p">,</span> <span class="n">markup</span><span class="p">,</span> <span class="n">tokens</span><span class="p">)</span></div><div class='line' id='LC89'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@opts</span> <span class="o">=</span> <span class="p">{}</span></div><div class='line' id='LC90'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="n">markup</span><span class="o">.</span><span class="n">strip</span> <span class="o">=~</span> <span class="sr">/\s*counter:(\w+)/i</span></div><div class='line' id='LC91'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="vi">@opts</span><span class="o">[</span><span class="s1">&#39;counter&#39;</span><span class="o">]</span> <span class="o">=</span> <span class="p">(</span><span class="vg">$1</span> <span class="o">==</span> <span class="s1">&#39;true&#39;</span><span class="p">)</span></div><div class='line' id='LC92'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">markup</span> <span class="o">=</span> <span class="n">markup</span><span class="o">.</span><span class="n">strip</span><span class="o">.</span><span class="n">sub</span><span class="p">(</span><span class="sr">/counter:\w+/i</span><span class="p">,</span><span class="s1">&#39;&#39;</span><span class="p">)</span></div><div class='line' id='LC93'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC94'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">super</span></div><div class='line' id='LC95'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC96'><br/></div><div class='line' id='LC97'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">def</span> <span class="nf">render</span><span class="p">(</span><span class="n">context</span><span class="p">)</span></div><div class='line' id='LC98'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">=</span> <span class="s2">&quot;&quot;</span></div><div class='line' id='LC99'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">config</span> <span class="o">=</span> <span class="n">context</span><span class="o">.</span><span class="n">registers</span><span class="o">[</span><span class="ss">:site</span><span class="o">].</span><span class="n">config</span></div><div class='line' id='LC100'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">category_dir</span> <span class="o">=</span> <span class="n">config</span><span class="o">[</span><span class="s1">&#39;category_dir&#39;</span><span class="o">]</span></div><div class='line' id='LC101'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">categories</span> <span class="o">=</span> <span class="n">context</span><span class="o">.</span><span class="n">registers</span><span class="o">[</span><span class="ss">:site</span><span class="o">].</span><span class="n">categories</span></div><div class='line' id='LC102'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">categories</span><span class="o">.</span><span class="n">keys</span><span class="o">.</span><span class="n">sort_by</span><span class="p">{</span> <span class="o">|</span><span class="n">str</span><span class="o">|</span> <span class="n">str</span><span class="o">.</span><span class="n">downcase</span> <span class="p">}</span><span class="o">.</span><span class="n">each</span> <span class="k">do</span> <span class="o">|</span><span class="n">category</span><span class="o">|</span></div><div class='line' id='LC103'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot;&lt;li&gt;&lt;a href=&#39;/</span><span class="si">#{</span><span class="n">category_dir</span><span class="si">}</span><span class="s2">/</span><span class="si">#{</span><span class="n">category</span><span class="o">.</span><span class="n">to_url</span><span class="si">}</span><span class="s2">/&#39;&gt;</span><span class="si">#{</span><span class="n">category</span><span class="si">}</span><span class="s2">&quot;</span></div><div class='line' id='LC104'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">if</span> <span class="vi">@opts</span><span class="o">[</span><span class="s1">&#39;counter&#39;</span><span class="o">]</span></div><div class='line' id='LC105'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot; (</span><span class="si">#{</span><span class="n">categories</span><span class="o">[</span><span class="n">category</span><span class="o">].</span><span class="n">count</span><span class="si">}</span><span class="s2">)&quot;</span></div><div class='line' id='LC106'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC107'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span> <span class="o">&lt;&lt;</span> <span class="s2">&quot;&lt;/a&gt;&lt;/li&gt;&quot;</span></div><div class='line' id='LC108'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC109'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="n">html</span></div><div class='line' id='LC110'>&nbsp;&nbsp;&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC111'>&nbsp;&nbsp;<span class="k">end</span></div><div class='line' id='LC112'><br/></div><div class='line' id='LC113'><span class="k">end</span></div><div class='line' id='LC114'><br/></div><div class='line' id='LC115'><span class="no">Liquid</span><span class="o">::</span><span class="no">Template</span><span class="o">.</span><span class="n">register_tag</span><span class="p">(</span><span class="s1">&#39;tag_cloud&#39;</span><span class="p">,</span> <span class="no">Jekyll</span><span class="o">::</span><span class="no">TagCloud</span><span class="p">)</span></div><div class='line' id='LC116'><span class="no">Liquid</span><span class="o">::</span><span class="no">Template</span><span class="o">.</span><span class="n">register_tag</span><span class="p">(</span><span class="s1">&#39;category_list&#39;</span><span class="p">,</span> <span class="no">Jekyll</span><span class="o">::</span><span class="no">CategoryList</span><span class="p">)</span></div></pre></div></td>
          </tr>
        </table>
  </div>

  </div>
</div>

<a href="#jump-to-line" rel="facebox[.linejump]" data-hotkey="l" class="js-jump-to-line" style="display:none">Jump to Line</a>
<div id="jump-to-line" style="display:none">
  <form accept-charset="UTF-8" class="js-jump-to-line-form">
    <input class="linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" autofocus>
    <button type="submit" class="button">Go</button>
  </form>
</div>

        </div>

      </div><!-- /.repo-container -->
      <div class="modal-backdrop"></div>
    </div><!-- /.container -->
  </div><!-- /.site -->


    </div><!-- /.wrapper -->

      <div class="container">
  <div class="site-footer">
    <ul class="site-footer-links right">
      <li><a href="https://status.github.com/">Status</a></li>
      <li><a href="http://developer.github.com">API</a></li>
      <li><a href="http://training.github.com">Training</a></li>
      <li><a href="http://shop.github.com">Shop</a></li>
      <li><a href="/blog">Blog</a></li>
      <li><a href="/about">About</a></li>

    </ul>

    <a href="/">
      <span class="mega-octicon octicon-mark-github" title="GitHub"></span>
    </a>

    <ul class="site-footer-links">
      <li>&copy; 2014 <span title="0.05551s from github-fe128-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="/site/terms">Terms</a></li>
        <li><a href="/site/privacy">Privacy</a></li>
        <li><a href="/security">Security</a></li>
        <li><a href="/contact">Contact</a></li>
    </ul>
  </div><!-- /.site-footer -->
</div><!-- /.container -->


    <div class="fullscreen-overlay js-fullscreen-overlay" id="fullscreen_overlay">
  <div class="fullscreen-container js-fullscreen-container">
    <div class="textarea-wrap">
      <textarea name="fullscreen-contents" id="fullscreen-contents" class="fullscreen-contents js-fullscreen-contents" placeholder="" data-suggester="fullscreen_suggester"></textarea>
    </div>
  </div>
  <div class="fullscreen-sidebar">
    <a href="#" class="exit-fullscreen js-exit-fullscreen tooltipped tooltipped-w" aria-label="Exit Zen Mode">
      <span class="mega-octicon octicon-screen-normal"></span>
    </a>
    <a href="#" class="theme-switcher js-theme-switcher tooltipped tooltipped-w"
      aria-label="Switch themes">
      <span class="octicon octicon-color-mode"></span>
    </a>
  </div>
</div>



    <div id="ajax-error-message" class="flash flash-error">
      <span class="octicon octicon-alert"></span>
      <a href="#" class="octicon octicon-remove-close close js-ajax-error-dismiss"></a>
      Something went wrong with that request. Please try again.
    </div>

  </body>
</html>

