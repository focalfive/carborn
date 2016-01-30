define(['react'], function(React) {
    
    var SidebarToggleButton = React.createClass({
        render: function() {
            return (
                <p className="pull-right visible-xs">
                    <button type="button" className="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
                </p>
            );
        }
    });
    
    return SidebarToggleButton;
});