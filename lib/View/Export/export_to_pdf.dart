import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:webcontent_converter/webcontent_converter.dart';
import 'package:path/path.dart' as p;

loadDataToReport({required data, required heading, required date, required type, required balance}) async {
  try {
    var htmlData = await returnResponseToHtml(data: data, heading: heading, date: date, type: type,balance: balance);
    if (htmlData[0] == 200) {
      var uriData = await webUriToPdf(htmlData[1],heading,balance);
      if (uriData[0] == 200) {
        late io.File _file = uriData[1];
        Uint8List image_byte = await _file.readAsBytes();
      } else {}
    }
  } catch (e) {}
}
webUriToPdf(content,path,balance) async {
  try {
    io.File _file;
    var s = DateTime.now().microsecondsSinceEpoch;
    var timeS = "$s";
    var pathPdf = "Zinco$path";
    var path_name = "$pathPdf$timeS.pdf";
    var directory = await getApplicationDocumentsDirectory();
    var pathDetails = p.join(directory.path, path_name);
    await WebcontentConverter.contentToPDF(
      duration: 0.00,
      content: content,
      savedPath: pathDetails,
      format: PaperFormat.a4,
    );

    if (pathDetails.isNotEmpty) {
      _file = io.File(pathDetails);
      return [200, _file, pathDetails];
    } else {
      return [400, "", ""];
    }
  } catch (e) {
    print(e.toString());
  }
}

returnResponseToHtml({required data, required heading, required date, required type, required balance}) async {
  try {
    var statusCode = 200;

    var content;
    content = Template.getTemplateContent(data: data, heading: heading, date: date,type: type,balnce:balance );

    if (statusCode == 200) {
      return [statusCode, content];
    } else {
      return [statusCode, ""];
    }
  } catch (e) {
    return [400, ""];
  }
}

class Template {
  static String getTemplateContent({required data, required heading, required date,required type,required balnce}) {
    var printItems = """   """;
    if(type ==1){

      printItems += """
            <thead  class="table-heading border table-border">
          <tr >
            <td style='background-color:rgb(54, 52, 168)' class="w-9">
              <bdo style="color: white;">Sl No</bdo>
            </td>
             <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Date</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">Particulars</bdo>
            </td>




            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Amount</bdo>
            </td>


            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Notes</bdo>
            </td>


          </tr>
        </thead>
    """;


      for (var i = 3; i < data.length; i++) {
        var sl = "";
        if (i != 2) {
          sl = (i - 2).toString();
        }

        printItems += """   
             <tr class='border table-border'>
            <td  style="text-align:center;">$sl</td>
             <td class="center">   ${data[i][0]}</td>

            <td>
              <div class="product-details">
              <span>   ${data[i][1]}</span>
              </div>
            </td>

            <td class="right">${data[i][2]}</td>

            <td class="right">${data[i][3]}</td>

          </tr>""";
      }

    }
    else if (type ==2){
      printItems += """
            <thead  class="table-heading border table-border">
          <tr >
            <td style='background-color:rgb(54, 52, 168)' class="w-9">
              <bdo style="color: white;">Sl No</bdo>
            </td>
             <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Date</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">From account</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">To Account</bdo>
            </td>


            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Amount</bdo>
            </td>



          </tr>
        </thead>
    """;


      for (var i = 3; i < data.length; i++) {
        var sl = "";
        if (i != 2) {
          sl = (i - 2).toString();
        }

        printItems += """   
             <tr class='border table-border'>
            <td  style="text-align:center;">$sl</td>
             <td class="center">   ${data[i][0]}</td>

            <td>
              <div class="product-details">
              <span>   ${data[i][1]}</span>
              </div>
            </td>

            <td>
              <div class="product-details">
              <span>   ${data[i][2]}</span>
              </div>
            </td>

            <td class="right">${data[i][3]}</td>

          </tr>""";
      }



    }
    else if(type ==3){
      printItems += """
            <thead  class="table-heading border table-border">
          <tr >
            <td style='background-color:rgb(54, 52, 168)' class="w-9">
              <bdo style="color: white;">Sl No</bdo>
            </td>
             <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Date</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">From account</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">To Account</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">From Amount</bdo>
            </td>


            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;"> To Amount</bdo>
            </td>
  <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Amount</bdo>
            </td>

          </tr>
        </thead>
    """;

      for (var i = 3; i < data.length; i++) {
        var sl = "";
        if (i != 2) {
          sl = (i - 2).toString();
        }

        printItems += """   
             <tr class='border table-border'>
            <td  style="text-align:center;">$sl</td>
             <td class="center">   ${data[i][0]}</td>

            <td>
              <div class="product-details">
              <span>   ${data[i][1]}</span>
              </div>
            </td>

            <td>
              <div class="product-details">
              <span>   ${data[i][2]}</span>
              </div>
            </td>

            <td class="right">${data[i][3]}</td>
            <td class="right">${data[i][4]}</td>
             <td class="right">${data[i][5]}</td>
          </tr>""";
      }

    }
    else if (type ==4){


        printItems += """
            <thead  class="table-heading border table-border">
          <tr >
            <td style='background-color:rgb(54, 52, 168)' class="w-9">
              <bdo style="color: white;">Sl No</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">Particulars</bdo>
            </td>




            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Amount</bdo>
            </td>


          </tr>
        </thead>
    """;


        for (var i = 3; i < data.length; i++) {
          var sl = "";
          if (i != 2) {
            sl = (i - 2).toString();
          }

          printItems += """   
             <tr class='border table-border'>
            <td  style="text-align:center;">$sl</td>

            <td>
              <div class="product-details">
              <span>   ${data[i][1]}</span>
              </div>
            </td>

            <td class="right">${data[i][2]}</td>

          </tr>""";
        }





    }

    else{

      printItems += """
            <thead  class="table-heading border table-border">
          <tr >
            <td style='background-color:rgb(54, 52, 168)' class="w-9">
              <bdo style="color: white;">Sl No</bdo>
            </td>

            <td  style='background-color:rgb(54, 52, 168)' class="product-name">
              <bdo  style="text-align:center;color: white;">Due Date</bdo>
            </td>




            <td  style='background-color:rgb(54, 52, 168)' class="right w-9">
              <bdo style="color: white;">Amount</bdo>
            </td>


          </tr>
        </thead>
    """;


      for (var i = 3; i < data.length; i++) {
        var sl = "";
        if (i != 2) {
          sl = (i - 2).toString();
        }

        printItems += """   
             <tr class='border table-border'>
            <td  style="text-align:center;">$sl</td>

            <td>
              <div class="product-details">
              <span>   ${data[i][1]}</span>
              </div>
            </td>

            <td class="right">${data[i][2]}</td>

          </tr>""";
      }


    }
    // for (var i = 3; i < data.length; i++) {
    //   var sl = "";
    //   if (i != 2) {
    //     sl = (i - 2).toString();
    //   }
    //
    //   printItems += """
    //          <tr class='border table-border'>
    //         <td  style="text-align:center;">$sl</td>
    //          <td class="center">   ${data[i][0]}</td>
    //
    //         <td>
    //           <div class="product-details">
    //           <span>   ${data[i][1]}</span>
    //           </div>
    //         </td>
    //
    //         <td class="right">${data[i][2]}</td>
    //
    //       </tr>""";
    // }
    //



    printItems += """
         </tbody>
      </table>""";

    var pdfPrint = """
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <!-- <link rel="stylesheet" href="/static/css/print.css" /> -->
    <title></title>

    <link rel="preconnect" href="https://fonts.googleapis.com/" />
    <link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin="" />
    <link href="./print_template_three_files/css2" rel="stylesheet" />
    <link <="" head="" />
    <style>
      * {
        font-family: "Poppins";
      }
      html {
        position: relative;
      }
      body {
        font-family: "Poppins";
        background: #fff;
        margin: 0;
        width:750px;
        height: auto;
        border: 1px solid #000; 
        margin: 10px auto;

      }
      .header {
        padding: 0 0.2in 0 0.2in;
        height: 0.5in;
      }
      .body {
        /*padding: 0 0.2in 0 0.2in; */

      }
      .footer {
        padding: 0 0.2in 0 0.2in;
        height: 0.5in;
      }
      .empty {
        display: table-cell;
        content: " ";
        width: 100%;
      }

      @page {
        size: A4 portrait;
        margin: 0;
      }
      table {
        width: 100%;
      }
      .organisation-name {
        font-size: 23pt;
      }
      .image-container {
        width: 115px;
        height: 115px;
        object-fit:contain;
        vertical-align: top;
      }
      .image-container img {
       width: 115px;
        height: 115px;
        object-fit:contain;
      }
      .image-group {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
      }
      .organisation-info {
        display: flex;
        flex-direction: column;
      }
      .organisation-info span {
        margin-bottom: 3px;
      }
      .organisation-other-info {
        font-size: 10pt;
      }
      .address {
        display: block;
      }


      td.image-container {
        vertical-align: top;
        width: 150px;
        height: 150px;
        object-fit: contain;
      }
      .organisation-name {
        text-transform: capitalize;
        font-size: 23pt;
      }



      .invoice-details {
        text-align: right;
        vertical-align: baseline;
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
      }
      .invoice-info {
        display: flex;
        flex-direction: row;
      }
      .invoice-info span {
        font-size: 10pt;
      }
      .invoice-name-container {
        margin-bottom: 10px;
        font-weight: bold;

      }
      .organization-info {
        display: flex;
        justify-content: flex-end;
      }
      .organization-info span {
        font-size: 10pt;
        margin-bottom: 5px;
      }

      .table-heading {
        /* border-bottom: 1px solid #466daf; */
      }
      .table-heading bdo {
        display: block;
        font-weight: bold;
      }
      .table-heading bdo.arabic {
        display: block;
        font-weight: normal;
        font-size: 12pt;
      }
      .table-heading tr td {
        color: #000;
        background: #fff;
        font-size: 10pt;
        vertical-align: baseline;
      }



      .item-table {
        border-collapse: collapse;
      }
      .item-table thead tr td {
        padding: 5px 10px 5px 10px;
        white-space: nowrap;
      }

      .product-name {
        font-family: "Poppins";
      }
      .payment-details .heading {
        font-weight: bold;
        text-transform: capitalize;
        margin-bottom: 10px;
      }
      .payment-details .heading {
        font-size: 10pt;
      }
      .bottom-group {
        border-top: 1px solid #000;
        border-bottom: 1px solid #000;
        display: flex;
      }
      .bottom-group tr td {
        padding-bottom: 10px;
        font-size: 10pt;
      }

      .payment-details {
        padding-top: 10px;
        width: 35%;
      }
      .note-details {
        padding-top: 10px;
        width: 100%;
        border-bottom: 1px solid;
      }
      .note-details tr td {
        padding-bottom: 10px;
        font-size: 10pt;
      }
      .note-details .heading {
        font-weight: bold;
        text-transform: capitalize;
        margin-bottom: 10px;
      }
      .note-details .heading {
        font-size: 10pt;
      }
      .amount-group {
        padding-top: 10px;
        padding-right: 10px;
        width: 50%;
        display: flex;
        align-items: flex-end;

        padding-left: 10px;

      }
      .grand-total {
        font-weight: bold;
      }

      .right {
        text-align: right;
      }


      .center {
        text-align: center;
      }


      .amount-in-words {
        text-transform: capitalize;
        display: flex;
        justify-content: flex-end;
        border-right: 1px solid;
      }
      .amount-in-words table {
        width: 100%;
      }
      .amount-in-words table tr {
        display: block;
      }
      .amount-in-words table tr td {
        font-size: 10pt;
        font-weight: bold;
      }
      .amount-in-words table tr td.heading {
        color: #000;
        padding: 15px 0 5px;
        font-size: 12pt;
        font-weight: bold;
      }



      .invoice-details-bottom-container {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
      }
      .invoice-details-bottom-container.padding {
        padding-right: 15px;
      }

      .company-bottom-labels {
        display: grid;
        grid-template-columns: 1.5fr 1fr;
        grid-column-gap: 85px;
      }
      .company-bottom-labels.customer {
        border-top: 1px solid;
        border-bottom: 1px solid;
      }
      .company-bottom-labels.customer .invoice-details-bottom-container {
        padding-left: 15px;
      }
      .company-bottom-labels.customer td:first-child {
        border-right: 1px solid;
      }
      .qr-container {
        font-family: "Poppins";
        display: flex;
        flex-direction: column;
        justify-content: flex-end;
      }
      .top-table {
      }

      .border {
        border-bottom: 1px solid;
      }

      p {
        margin: 0;
      }
      .top-header {
        justify-content: flex-start;
      }
      .table-border td {
        border-right: 1px solid;
      }
      .table-border td:last-child {
        border: 0;
      }
      .receiver {
        border-right: 1px solid;
      }

      #wrapper {
        position: fixed;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
        border: 1px solid black;
      }
      bdo {
        unicode-bidi: normal;
      }
      .w-9 {
        width: 15%;
      }
      .border{
        border-bottom:1px solid;
      }
      td{
      padding: 1px  !important;
      }
      thead td{
        text-align:center !important;
      }
    </style>
  </head>
  <body>



    <div class="body">
      <table>
        <tbody>
          <tr>
            <td style="text-align:center;">
            <h3 style='color:rgb(54, 52, 168);'>$heading</h3>
            <h3 style='color:rgb(54, 52, 168);'>$balnce</h3>
            </td>
          </tr>
          <tr>
            <td>
            <p>$date</p>
            </td>
          </tr>
        </tbody>
      </table>
      <table class="top-table no-border">

      </table>

      <table class="item-table">
        <tbody class="table-border">
           $printItems
        </tbody>
      </table>

    </div>
   <!-- <div class="footer"></div>   -->
  </body>
</html>
   """;

    return pdfPrint;
  }
}
