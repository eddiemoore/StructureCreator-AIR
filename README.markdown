This AIR application is driven by either an xml schema or a zip file with template files, which can be customized to fit specific project requirements. 
It automatically creates sll files and folders that are in your schema file.

Using this AIR app can effectively streamline new project creation work flow. It only takes a few clicks to achieve which usually takes hours to recreate, duplicate or 
customize from previous projects.


Are you using Structure Creator?
--------------------------------
If you are using Structure Creator please email me [eddie.moore@gmail.com](mailto://eddie.moore@gmail.com) and let me know 
what you think about Structure Creator. Was it useful? What could be improved?

Schema
------

### SchemaCreator
Creating a schema file is as easy as a couple of clicks with [SchemaCreator](http://github.com/nichmekof/SchemaCreator).
The handy little AIR app will help you create your own schema file from a folder of template files in no time at all.

### Example Schema
	<folder name='%BASE%'>
		<folder name='css'>
			<file name='style.css'><![CDATA[body { background:#FFF; color:#000; font:12px/16px Arial, san-serif; }]]></file>
		</folder>
		<folder name='images' />
		<folder name='js'>
			<file name='scripts.js' url='http://code.jquery.com/jquery-1.4.4.min.js' />
		</folder>
		<folder name='xml' />
		<file name='index.html' url="http://example.com/templates/index.html" />
	</folder>



### Create a folder
	<folder name='XXXXX'></folder>

This will create a folder with the name XXXXX

### Create a file
	<file name='XXXX.XXX' url='http://linktotemplate' />

This will create a file called XXXX.XXX (e.g index.html) based on a template file linked in the url attribute. 
Replace http://linktotemplate with the link to your template file. More information on templates are located below.


Templates
---------
If you are creating your own templates there are some variables that can be replaced with values when a new project is created. 
The following, lists current available variables.

+ **%PROJECTNAME%** - Name of Project

Example Template for index.html
-------------------------------
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
	<head>
		<title>%PROJECTNAME% - Created with Structure Creator</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" href="css/style.css" />
	</head>
	<body>
		<div id="container">
			<h1>%PROJECTNAME%</h1>
		</div>
		<script type="text/javascript" src="js/jquery-1.4.4.min.js"></script>
	</body>
	</html>
