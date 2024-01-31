<div align="center" width="100%">
    <h1>nmap-bootstrap-xsl</h1>
    <p>An Nmap XSL implementation with Bootstrap.<br>Allows Nmap XML port scan results to be converted into beautiful HTML reports.</p><p>
</div>

## 🔥 Features

- Bootstrap Datatable filters and search bars
- Export functionality like Copy, CSV, Excel and PDF
- Automatic classification of web network services to a separate audit space with clickable HTTP/HTTPS URLs
- Nmap CLI flag explanation via https://explainshell.com
- Dynamic keyword highlighting via JS (e.g. keywords like password, login, insecure)
- Quick glance at HTTP titles and SSL certificate information (CN, Expiry etc.)
- Hostname and IP address listing of scan targets
- Indication for encrypted network services (plaintext vs. SSL/STARTTLS)
    
## ✨ Requirements
- xsltproc — command line xslt processor

````
sudo apt install xsltproc
````

## 🎓 Usage

### Converting Nmap XML

You can convert an already existing Nmap XML file into a nicely formatted HTML report by executing the following commands:

````
# download the nmap bootstrap xsl
wget https://raw.githubusercontent.com/clem9669/nmap-bootstrap-xsl/main/nmap-bootstrap.xsl

# convert your nmap xml file into html
xsltproc -o report.html nmap-bootstrap.xsl <nmap.xml>
````

The resulting Nmap HTML report `report.html` can be directly opened with any web browser of your choice. 

### Applying XSL in advance

If you have not yet started your Nmap port scan, you can also apply the bootstrap XSL in your Nmap CLI command as follows:

````
nmap -sS -Pn --stylesheet https://raw.githubusercontent.com/clem9669/nmap-bootstrap-xsl/main/nmap-bootstrap.xsl scanme.nmap.org
````

The resulting Nmap XML file can be directly opened with a supported web browser. The bootstrap XSL will already be applied.

> **Note**:
> Nonetheless, it is recommended to convert the XML file into an HTML report. This ensures that the final Nmap bootstrap report is supported by all web browsers and that clients, to which you'll hopefully send your port scanning results, can easily categorize and open the file with the default OS application - a web browser.

## 💎 Acknowledgment & Credits

Many thanks to the following individuals:

- ❤ [honze-net](https://github.com/honze-net) for [nmap-bootstrap-xsl](https://github.com/honze-net/nmap-bootstrap-xsl)
- ❤ [Haxxnet](https://github.com/Haxxnet) for [nmap-bootstrap-xsl](https://github.com/Haxxnet/nmap-bootstrap-xsl)
