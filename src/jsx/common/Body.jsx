define(['react'], function(React) {
    
    var Body = React.createClass({
        render: function() {
            return (
                <div className="col-xs-12 col-sm-9">
                    {this.props.children}
                </div>
            );
        }
    });
    
    return Body;
});