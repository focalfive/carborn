define([
    'react',
    'common/footer'
], function(React, Footer) {
    
    var Container = React.createClass({
        render: function() {
            return (
                <div className="container">
                    <div className="row row-offcanvas row-offcanvas-right">
                        {this.props.children}
                    </div>
                    <hr />
                    <Footer />
                </div>
            );
        }
    });
    
    return Container;
});