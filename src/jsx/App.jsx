/**
 * Start application block
 */
define([
    'react',
    'common/Navigation',
    'common/Container',
    'common/Body',
    'common/Sidebar',
    'common/SidebarToggleButton',
    'main/CoverBlock',
    'main/ModuleContainer',
    'main/ModuleBlock'
], function(
    React,
    Navigation,
    Container,
    Body,
    Sidebar,
    SidebarToggleButton,
    CoverBlock,
    ModuleContainer,
    ModuleBlock) {
    
    var App = React.createClass({
        getInitialState: function() {
            return {
                title: 'Project 메인'
            }
        },
        componentDidMount: function() {
            $(document).ready(function() {
                $('[data-toggle="offcanvas"]').click(function() {
                    $('.row-offcanvas').toggleClass('active')
                });
            });
        },
        render: function() {
            return (
                <div>
                    <Navigation />
                    <Container>
                        <Body>
                            <SidebarToggleButton />
                            <CoverBlock title="Hello, world!" summary="This is an example to show the potential of an offcanvas layout pattern in Bootstrap. Try some responsive-range viewport sizes to see it in action." />
                            <ModuleContainer>
                                <ModuleBlock title="Heading" summary="Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui." link="#" />
                                <ModuleBlock title="Heading" summary="Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui." link="#" />
                                <ModuleBlock title="Heading" summary="Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui." link="#" />
                                <ModuleBlock title="Heading" summary="Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui." link="#" />
                                <ModuleBlock title="Heading" summary="Donec id elit non mi porta gravida at eget metus. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus. Etiam porta sem malesuada magna mollis euismod. Donec sed odio dui." link="#" />
                            </ModuleContainer>
                        </Body>
                        <Sidebar />
                    </Container>
                </div>
            );
        }
    });
    
    return App;
});

/**/
