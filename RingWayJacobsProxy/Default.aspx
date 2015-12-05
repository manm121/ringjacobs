<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="RingWayJacobsProxy._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
    </asp:ScriptManager>
    <h2>
        Welcome to ASP.NET!
    </h2>
    <p>
        To learn more about ASP.NET visit <a href="http://www.asp.net" title="ASP.NET Website">
            www.asp.net</a>.
    </p>
    <!-- 
    function showTransportOnMap(){

    var destinationProjection = new Proj4js.Proj('EPSG:27700');
	clearTransportFromMap();
    
	$("#wait").css("display", "block");

	var settings = {
			 contentType: "application/json;charset=utf-8",
			 dataType: "json",
             type: 'GET',
			 url: "/ringwayjacobproxy/Default.aspx/GetTrackingData",
	};

	makeAjaxRequest(settings, function(data){
	
		var dataSet = {
			'trackingData':data.d,
			'vehicleData':null
		};

	    //change the url
		settings.url = '/ringwayjacobproxy/Default.aspx/GetVehicleData';
		makeAjaxRequest(settings, function(vd){
		
			dataSet.vehicleData = vd.d;

			$.each($.parseJSON(data.trackingData), function(idx, obj) {

				if(obj.latitude && obj.assetGroupName){
					if(obj.assetGroupName == "Bucks Winter Maintenance") {
						var lat = obj.latitude;
						var long = obj.longitude;
						var point = new Proj4js.Point(long, lat); 
					
						//Do your conversion
						Proj4js.transform(Proj4js.WGS84, destinationProjection, point);
						var point = new OpenLayers.Geometry.Point(point.x, point.y);
						var pointFeature = new OpenLayers.Feature.Vector(point);
						
						//Setting the label text
						pointFeature.attributes = {label: obj.assetRegistration};
						markerVectorLayer.addFeatures([pointFeature]);
					}
				}
				$("#wait").css("display", "none");    
			});
		}, _serviceFailed);
    }, _serviceFailed);

    Proj4js.reportError = function(msg) {alert(msg);}
}
-->
</asp:Content>
<script>
    function _serviceFailed(xhr, error) {
        $("#wait").css("display", "none");
    };

    function trackingDataCallback(data) {

        makeAjaxRequest({ url: '/ringwayjacobproxy/Default.aspx/GetVehicleData' }, vehicleDataCallback);

        $.each($.parseJSON(data.trackingData), function (idx, obj) {

            if (obj.latitude && obj.assetGroupName) {
                if (obj.assetGroupName == "Bucks Winter Maintenance") {
                    var lat = obj.latitude;
                    var long = obj.longitude;
                    var point = new Proj4js.Point(long, lat);

                    //Do your conversion
                    Proj4js.transform(Proj4js.WGS84, destinationProjection, point);
                    var point = new OpenLayers.Geometry.Point(point.x, point.y);
                    var pointFeature = new OpenLayers.Feature.Vector(point);

                    //Setting the label text
                    pointFeature.attributes = { label: obj.assetRegistration };
                    markerVectorLayer.addFeatures([pointFeature]);
                }
            }
            $("#wait").css("display", "none");
        });


    };

    function vehicleDataCallback(data) {

    };

    function makeAjaxRequest(options, _success, _failure) {

        var settings = {
            url: '',
            dataTye: 'json',
            type: 'GET',
            contentType: 'application/json;charset=utf-8'
        };

        //extend options
        settings = $.extend(settings, options);

        $.ajax(settings)
	 .done(function (data) {

	     if (typeof _success == 'function')
	         _success(data);
	 })
	 .fail(function (xhr, error) {

	     if (typeof _failure == 'function')
	         _failure(xhr, error);
	 });
    };


    function showTransportOnMap() {

        var destinationProjection = new Proj4js.Proj('EPSG:27700');
        clearTransportFromMap();
        $("#wait").css("display", "block");

        makeAjaxRequest({ url: '/ringwayjacobproxy/Default.aspx/GetTrackingData' }
		, trackingDataCallback
		, _serviceFailed);

        Proj4js.reportError = function (msg) { alert(msg); }
    };
</script>
