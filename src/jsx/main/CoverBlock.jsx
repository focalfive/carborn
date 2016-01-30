define(['react'], function(React) {
    
    var CoverBlock = React.createClass({
        render: function() {
            return (
                <div className="jumbotron">
                    <h1>{this.props.title}</h1>
                    <p>{this.props.summary}</p>
                </div>
            );
        }
    });
    
    return CoverBlock;
});