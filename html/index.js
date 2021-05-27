//CHANGE THIS TO YOUR RESOURCE NAME OR IT WILL NOT WORK
const resourcename = 'xMiranda'

//Display Function to Hide/Show Display
$(function() {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }
    display(false)

    //Add a Event Listener for Player Input
    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })

    //If ESCAPE Key is pressed Exit the NUI
    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post(`http://${resourcename}/exit`, JSON.stringify({}));
            return
        }
    };
})