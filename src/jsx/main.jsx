/**
 * Configuration for require js
 */
requirejs.config({
    baseUrl: '/js',
    paths: {
        'jquery': '/libs/jquery.min',
        'jquery-easing': '/libs/jquery.easing.min',
        'bootstrap': '/libs/bootstrap.min',
        'react': '/libs/react.min',
        'react-dom': '/libs/react-dom.min'
    },
    shim: {
        'jquery-easing': {
            deps: ['jquery']
        },
        'bootstrap': {
            deps: ['jquery']
        },
        'react': {
            deps: ['jquery']
        },
        'offcanvas': {
            deps: ['bootstrap']
        }
    }
});

/**
 * Start application block
 */
require([
    'bootstrap',
    'react',
    'react-dom',
    'App'
], function(bootstrap, React, ReactDOM, App) {

    // Render in main element
    ReactDOM.render(
        <App />,
        document.getElementById('main')
    );
});

/**/
