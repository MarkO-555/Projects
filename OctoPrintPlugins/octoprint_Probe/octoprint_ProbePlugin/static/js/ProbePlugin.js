var Probebusy = false;
var ProbeAverage = 0;
var ProbeCount = 0;
var ProbeNumber = 5;

$(function() {
	
    function HelloWorldViewModel(parameters) {
        var self = this;
		
    }
	
	function processing(ProbeNumber){
		if(ProbeBusy){
			alert("Busy Processing!!!");
			return;
		}

		ProbeAverage = 0;
		ProbeNumber = this.ProbeNumber;
		Probebusy = true;
		
		for(var i=0; i<ProbeNumber; i++){
			OctoPrint.control.sendGcode("G30").done(function (response) {
				console.log(response);

				ProbeAverage += parseFloat(responseNumber.substring(responseNumber.indexOf("Z: ")));
				ProbeCount += 1;

				if (ProbeCount >= ProbeNumber) {
					ProbeAverage /= number;

					document.getElementById("Proberesult").text = ProbeAverage;
					Probebusy = false;
				}
				else
					document.getElementById("Proberesult").text = "Waiting for result";
			});
		}
		
	}

    // This is how our plugin registers itself with the application, by adding some configuration
    // information to the global variable OCTOPRINT_VIEWMODELS
    OCTOPRINT_VIEWMODELS.push([
        // This is the constructor to call for instantiating the plugin
        HelloWorldViewModel,

        // This is a list of dependencies to inject into the plugin, the order which you request
        // here is the order in which the dependencies will be injected into your view model upon
        // instantiation via the parameters argument
        ["settingsViewModel"],

        // Finally, this is the list of selectors for all elements we want this view model to be bound to.
        ["#tab_plugin_helloworld"]
    ]);

});