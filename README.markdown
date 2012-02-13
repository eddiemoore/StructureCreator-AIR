This AIR application is driven by either an xml schema or a zip file with template files, which can be customized to fit specific project requirements. 
It automatically creates all files and folders that are in your schema file.

Using this AIR app can effectively streamline new project creation work flow. It only takes a few clicks to achieve which usually can take hours to recreate, duplicate or customize from previous projects.


Are you using StructureCreator?
--------------------------------
If you are using StructureCreator please email me [eddie.moore@gmail.com](mailto://eddie.moore@gmail.com) and let me know what you think about StructureCreator. Was it useful? What could be improved?


Schema
------
There are 2 different ways you can use to create your schema. The first is by having a zip file with all your template files and folders inside. The second method is by using an xml based schema (see below).

### SchemaCreator
Creating a xml schema file is as easy as a couple of clicks with [SchemaCreator](http://github.com/nichmekof/SchemaCreator).
The handy little AIR app will help you create your own schema file from a folder of template files in no time at all. This will eventually be integrated into StructureCreator.

### Example XML Schema
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

### Alternative method to create a text based file
	<file name='example.txt'><![CDATA[This is the text that will be inside the file]]></file>


Templates
---------
If you are creating your own templates there are some variables that can be replaced with values when a new project is created. 

Variables are fully customisable. Using the custom variables section of StructureCreator just add as many variables as you need. 
Just name your variable and give it a value. Variable names can be anything with alphanumeric characters but without spaces.
They are in the form of **%VARIABLENAME%**

You can use template variables in any text based file, including *.docx, *.pptx and *.xlsx files. 
With StructureCreator you also get the flexability of being able to customise your file names and folders using template variables.
### For example:
	<folder name='%CUSTOMFOLDERNAME%'></folder>

Example Template for index.html
-------------------------------
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<meta charset="utf-8">
		<title>%PROJECTNAME% - Created with StructureCreator</title>
	</head>
	<body>
		<div id="container">
			<h1>%PROJECTNAME%</h1>
		</div>
	</body>
	</html>