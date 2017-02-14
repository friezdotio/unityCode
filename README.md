# unityCode

unityCode is a ColdFusion/Lucee Application that talks to Big Blue Button. It allows users to create Presentations and other users watch those presentation.

## Requirements

* ColdFusion or Lucee (Only tested on Lucee 4.5 and 5.x)
* BigBlueButton Server
* mySQL or MSSQL (Only tested on mySQL)

## Installation

* Clone to Lucee/CF Server
* Edit App.cfc with your datasource, site URL, and timezone.
* Load ORM tables via /?reload=true
* Initiate Demo Data (baseService/populateInital()) Also look at controllers/main.cfc
* Edit demo server in your database with it's path and api info

## Notes

I took out a lot of copyrighted images but never replaced them, so you may need to replace those images. The template is a ThemeForest template. Lastly, this application is not finished. I have not intentions of finishing it either. If you are using BBB this is application has some great services you can use.