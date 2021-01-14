<!DOCTYPE html>

<!-- The JSP file is mostly HTML but with the ability to add Java in specific tags -->
<html>

<head>
	<title>Demo page</title>
</head>

<body>
	
	<!-- Any Java will be evaluated server-side before the page is sent to the client.  The client won't see any Java code. -->
	<!-- This means that it can used for sensitive information such as password verification and database modification. -->
	
	
	
	<h1>HTML</h1>
	
	<p>You can write normal HTML like this</p>
	
	
	
	<h1>Java</h1>
	
	<!-- The tags below allow Java to be inserted: -->
	<% String demo_string = "This is a Java variable."; %>
	
	<!-- Adding an equals to the opening tag will take whatever exists in the Java tag, and print it to the HTML: -->
	<%= demo_string %>
	
	<p>This:</p>
	<p>demo</p>
	
	<p>Is the same as this:</p>
	<%= "<p>demo</p>" %>
	
	
	
	<h1>Mixing Java and HTML</h1>
	
	<!-- You can put HTML blocks within Java if-statements to conditionally add HTML: -->
	<% if( 5 < 8 ) { %>
		<p>Five is less than eight.</p>
	<% } else { %>
		<p>Five is not less than eight.</p>
	<% } %>
	
	<!-- Similar to HTML blocks in if-statements, we can also put them in for-loops: -->
	<% for( int i=0; i<6; i++ ) { %>
		<p>This will be printed 6 times</p>
	<% } %>
	
	<!-- We can also inline Java tags to access the value of i: -->
	<% for( int i=0; i<6; i++ ) { %>
		<p>This is iteration: <%= i %></p>
	<% } %>
	
</body>

</html>