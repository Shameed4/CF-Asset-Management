<cfset assetModel = new model.Asset()>
<cfparam name="url.id" default="0">
<cfset assetModel.delete(url.id)>
<cflocation url="list.cfm" addtoken="false">