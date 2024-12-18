<?xml version="1.0" encoding="utf-8"?>
<!--
Nmap Bootstrap XSL
Andreas Hontzia (@honze_net) & LRVT (@l4rm4nd) & Haxxnet & clem9669
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" doctype-system="about:legacy-compat"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <meta name="referrer" content="no-referrer"/>
        <link rel="stylesheet" href="css/bootstrap.min.css"/>
        <link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
        <link rel="stylesheet" href="css/buttons.dataTables.min.css"/>

        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dataTables.min.js"></script>
        <script src="js/jszip.min.js"></script>
        <script src="js/pdfmake.min.js"></script>
        <script src="js/vfs_fonts.js"></script>
        <script src="js/dataTables.buttons.min.js"></script>
        <script src="js/buttons.html5.min.js"></script>
        <script src="js/buttons.colVis.min.js"></script>
        <script src="js/buttons.bootstrap.min.js"></script>
        <script src="js/dataTables.bootstrap.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/ip-address.js"></script>
        <style>
          .target:before {
            content: "";
            display: block;
            height: 50px;
            margin: -20px 0 0;
          }
          @media only screen and (min-width:1900px) {
            .container {
              width: 1800px;
              }
          }
          .footer {
            margin-top:60px;
            padding-top:45px;
            width: 100%;
            height: 180px;
            background-color: #f5f5f5;
          }
          .clickable {
            cursor: pointer;
          }
          .panel-heading > h3:before {
            font-family: 'Glyphicons Halflings';
            content: "\e114"; /* glyphicon-chevron-down */
            padding-right: 1em;
          }
          .panel-heading.collapsed > h3:before {
            content: "\e080"; /* glyphicon-chevron-right */
          }
        </style>
        <title>Nmap Results</title>
      </head>
      <body>
        <script>
          function highlight(){
              \$("#table-services").dataTable().fnDestroy()
              let keywords = document.getElementById('keyword-input').value.split(',');
              let content = document.getElementById('table-services').innerHTML;
              document.getElementById('table-services').innerHTML = transformContent(content, keywords)
              \$('#table-services').DataTable( {
              "lengthMenu": [ [10, 25, 50, 100, -1], [10, 25, 50, 100, "All"] ],
              "order": [[ 0, 'desc' ]],
              "columnDefs": [
                { "targets": [0], "orderable": true },
              ],
              dom:'lBfrtip',
              stateSave: true,
              buttons: [
                  {
                      extend: 'copyHtml5',
                      exportOptions: { orthogonal: 'export' }
                  },
                  {
                      extend: 'csvHtml5',
                      exportOptions: { orthogonal: 'export' }
                  },
                  {
                      extend: 'excelHtml5',
                      exportOptions: { orthogonal: 'export' },
                      autoFilter: true,
                      title: '',
                  },
                  {
                      extend: 'pdfHtml5',
                      exportOptions: { orthogonal: 'export' },
                      orientation: 'landscape',
                      pageSize: 'LEGAL',
                      download: 'open',
                      exportOptions: {
                      columns: [ 0,1,2,3,4,5,6,7,8 ]
                }
                  }
              ],
            });
          }

          function transformContent(content, keywords){
            let temp = content

            keywords.forEach(keyword => {
              temp = temp.replace(new RegExp(keyword, 'ig'), wrapKeywordWithHTML(keyword, keyword))
            })

            return temp
          }

          function wrapKeywordWithHTML(keyword, url){
            return `<span style="color: red;">${keyword}</span>`
          }
        </script>
        <nav class="navbar navbar-default navbar-fixed-top">
          <div class="container-fluid">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="#"><span class="glyphicon glyphicon-home"></span></a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
              <ul class="nav navbar-nav">
                <li><a href="#scannedhosts">Scanned Hosts</a></li>
                <li><a href="#openservices">Open Services</a></li>
                <li><a href="#webservices">Web Services</a></li>
                <li><a href="#onlinehosts">Online Hosts</a></li>
                <li><a href="#" style="pointer-events: none; cursor: default;">|</a></li>
              </ul>
            </div>
          </div>
        </nav>
        <div class="container" style="width: 94%">
          <div class="jumbotron" style="margin-top: 80px; padding-top: 5px; padding-bottom: 30px; padding-left: 30px; padding-right: 30px">
            <h2>Nmap Port Scanning Results</h2>
            <h2><small>Nmap Version <xsl:value-of select="/nmaprun/@version"/>
            <br/><xsl:value-of select="/nmaprun/@startstr"/> – <xsl:value-of select="/nmaprun/runstats/finished/@timestr"/></small></h2>
            <pre style="white-space:pre-wrap; word-wrap:break-word;"><a target="_blank"><xsl:attribute name="href">https://explainshell.com/explain?cmd=<xsl:value-of select="/nmaprun/@args"/></xsl:attribute><xsl:value-of select="/nmaprun/@args"/></a></pre>
            <p class="lead">
              <xsl:value-of select="/nmaprun/runstats/hosts/@total"/> hosts scanned.
              <xsl:value-of select="/nmaprun/runstats/hosts/@up"/> hosts up.
              <xsl:value-of select="/nmaprun/runstats/hosts/@down"/> hosts down.
            </p>
            <div class="progress">
              <div class="progress-bar progress-bar-success" style="width: 0%">
                <xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@up div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute>
                <xsl:value-of select="/nmaprun/runstats/hosts/@up"/>
                <span class="sr-only"></span>
              </div>
              <div class="progress-bar progress-bar-danger" style="width: 0%">
                <xsl:attribute name="style">width:<xsl:value-of select="/nmaprun/runstats/hosts/@down div /nmaprun/runstats/hosts/@total * 100"/>%;</xsl:attribute>
                <xsl:value-of select="/nmaprun/runstats/hosts/@down"/>
                <span class="sr-only"></span>
              </div>
              </div>
              <div id="form-wrapper">
                <div>
                    <textarea style="width: 100%;" title="Insert comma separated keywords to be highlighted" rows = "1" name = "keywords" placeholder="sha1,password,..." id="keyword-input">sha1,login,password,md5</textarea>
                </div>
                <div style="margin-top: 2px">
                    <button title="Keyword highlighing in 'Open Services'" id="highlight-button" onclick="highlight()">Highlight Keywords</button>
                    <button title="Reset keyword highlighing" id="reset-highlight-button" onclick="document.location.reload(true);">Reset</button>
                </div>
            </div>
          </div>
          <h2 id="scannedhosts" class="target">Scanned Hosts<xsl:if test="/nmaprun/runstats/hosts/@down > 1024"><small> (offline hosts are hidden)</small></xsl:if></h2>
          <div class="table-responsive">
            <table id="table-overview" class="table table-striped dataTable" role="grid">
              <thead>
                <tr>
                  <th>State</th>
                  <th>Address</th>
                  <th>Hostname</th>
                  <th>TCP (open)</th>
                  <th>UDP (open)</th>
                </tr>
              </thead>
              <tbody>
                <xsl:choose>
                  <xsl:when test="/nmaprun/runstats/hosts/@down > 1024">
                    <xsl:for-each select="/nmaprun/host[status/@state='up']">
                      <tr>
                        <td><span class="label label-danger"><xsl:if test="status/@state='up'"><xsl:attribute name="class">label label-success</xsl:attribute></xsl:if><xsl:value-of select="status/@state"/></span></td>
                        <td><a><xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute><xsl:value-of select="address/@addr"/></a></td>
                        <td><xsl:value-of select="hostnames/hostname/@name"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/></td>
                      </tr>
                    </xsl:for-each>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:for-each select="/nmaprun/host">
                      <tr>
                        <td><span class="label label-danger"><xsl:if test="status/@state='up'"><xsl:attribute name="class">label label-success</xsl:attribute></xsl:if><xsl:value-of select="status/@state"/></span></td>
                        <td><a><xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(address/@addr, '.', '-')"/></xsl:attribute><xsl:value-of select="address/@addr"/></a></td>
                        <td><xsl:value-of select="hostnames/hostname/@name"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='tcp'])"/></td>
                        <td><xsl:value-of select="count(ports/port[state/@state='open' and @protocol='udp'])"/></td>
                      </tr>
                    </xsl:for-each>
                  </xsl:otherwise>
                </xsl:choose>
              </tbody>
            </table>
          </div>
          <h2 id="openservices" class="target">Open Services</h2>
          <div class="table-responsive">
            <table id="table-services" class="table table-striped dataTable" role="grid">
              <thead >
                <tr>
                  <th>Hostname</th>
                  <th>Address</th>
                  <th>Port</th>
                  <th>Protocol</th>
                  <th>Service</th>
                  <th>Product</th>
                  <th>Version</th>
                  <th>Extra</th>
                  <th>SSL Certificate</th>
                  <th title="Title of HTTP services">Title</th>
                  <th>CPE</th>
                </tr>
              </thead>
              <tbody>
                <xsl:for-each select="/nmaprun/host">
                  <xsl:for-each select="ports/port[state/@state='open']">
                    <tr>
                      <td>
                      <xsl:if test="count(../../hostnames/hostname) = 0">N/A</xsl:if>
                      <xsl:if test="count(../../hostnames/hostname) > 0"><xsl:value-of select="../../hostnames/hostname/@name"/></xsl:if></td>
                      <td><a>
                      <xsl:attribute name="href">#onlinehosts-<xsl:value-of select="translate(../../address/@addr, '.', '-')"/></xsl:attribute><xsl:value-of select="../../address/@addr"/></a></td>

                      <td><a>
                      <xsl:attribute name="href">#port-<xsl:value-of select="translate(../../address/@addr, '.
