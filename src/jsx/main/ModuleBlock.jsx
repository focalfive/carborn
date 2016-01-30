define(['react'], function(React) {
    
    var ModuleBlock = React.createClass({
        render: function() {
            return (
                <div className="col-xs-6 col-lg-4">
                    <h2>{this.props.title}</h2>
                    <p>{this.props.summary}</p>
                    <p><a className="btn btn-default" href={this.props.link} role="button">View details &raquo;</a></p>
                </div>
            );
        }
    });
    
    return ModuleBlock;
});