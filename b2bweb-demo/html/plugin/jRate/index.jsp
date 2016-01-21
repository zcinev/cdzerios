<%@ page import="com.bc.localhost.*"%>
<%
String path = request.getContextPath();
String basePath = BccHost.getHost()+path+"/";
%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>JqueryÐÇ¼¶ÆÀ·Ö²å¼þ - Jquery-school</title>
    <script src="<%=basePath%>html/js/jquery.min.js"></script>
    <link href="jquery/style.css" rel="stylesheet" />
    <link href="jquery/jRating.jquery.css" rel="stylesheet" />
</head>

<body>

    <p><a href="#">Back to MyjQueryPlugins</a>
    </p>

    <!-- EXEMPLE 1 : BASIC -->
    <div class="exemple">
        <em>Exemple 1 (
            <strong>Basic exemple without options</strong>) :</em>
        <div class="basic" id="12_1"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.basic&quot;).jRating();
  });
&lt;/script&gt;</pre>
    </div>

    <!-- EXEMPLE 2 -->
    <div class="exemple">
        <em>Exemple 2 (type :
            <strong>small</strong>- average
            <strong>10</strong>- id
            <strong>2</strong>-
            <strong>40</strong>stars) :</em>
        <div class="exemple2" id="10_2"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.exemple2&quot;).jRating({
	  type:'small', // type of the rate.. can be set to 'small' or 'big'
	  length : 40, // nb of stars
	  decimalLength : 1 // number of decimal in the rate
	});
  });
&lt;/script&gt;
</pre>
    </div>

    <!-- EXEMPLE 3 -->
    <div class="exemple">
        <em>Exemple 3 (step :
            <strong>true</strong>- average
            <strong>18</strong>- id
            <strong>3</strong>-
            <strong>15</strong>stars) :</em>
        <div class="exemple3" id="18_3"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.exemple3&quot;).jRating({
	  step:true,
	  length : 20, // nb of stars
	  decimalLength:0 // number of decimal in the rate
	});
  });
&lt;/script&gt;
</pre>
    </div>

    <!-- EXEMPLE 4 -->
    <div class="exemple">
        <em>Exemple 4 (
            <strong>Rate is disabled</strong>) :</em>
        <div class="exemple4" id="10_4"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.exemple4&quot;).jRating({
	  isDisabled : true
	});
  });
&lt;/script&gt;
</pre>
    </div>

    <!-- EXEMPLE 5 -->
    <div class="exemple">
        <em>Exemple 5 (
            <strong>With onSuccess &amp; onError methods</strong>) :</em>
        <div class="exemple5" id="10_5"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.exemple5&quot;).jRating({
	  length:10,
	  decimalLength:1,
	  onSuccess : function(){
		alert('Success : your rate has been saved :)');
	  },
	  onError : function(){
		alert('Error : please retry');
	  }
	});
  });
&lt;/script&gt;
</pre>
    </div>

    <!-- EXEMPLE 5 -->
    <div class="exemple">
        <em>Exemple 6 (
            <strong>Disabled rate info</strong>) :</em>
        <div class="exemple6" id="10_5"></div>
    </div>
    <div class="notice">
        <pre>
&lt;!-- JS to add --&gt;
&lt;script type=&quot;text/javascript&quot;&gt;
  $(document).ready(function(){
	$(&quot;.exemple6&quot;).jRating({
	  onSuccess : function(){
		jSuccess('Success : your rate has been saved :)',{
		  HorizontalPosition:'center',
		  VerticalPosition:'top'
		});
	  },
	  onError : function(){
		jError('Error : please retry');
	  }
	});
  });
&lt;/script&gt;
</pre>
    </div>



    <div class="datasSent">
        Datas sent to the server :
        <p></p>
    </div>
    <div class="serverResponse">
        Server response :
        <p></p>
    </div>

    <script type="text/javascript" src="jquery/jRating.jquery.js"></script>
    <script type="text/javascript" src="jquery/jRate.js"></script>
</body>

</html>