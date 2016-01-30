define(['react'], function(React) {
    
    var ModuleContainer = React.createClass({
        render: function() {
            return (
                <div className="row">
                    {this.props.children}
                </div>
            );
        }
    });
    
    return ModuleContainer;
});