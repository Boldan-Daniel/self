var Day = React.createClass({
    propTypes: {
        date: React.PropTypes.instanceOf(Date),
        eventsUrl: React.PropTypes.string
    },

    getInitialState: function(){
        return { activity: null };
    },

    loadEventsFromServer: function(date) {
        $.ajax({
            url: this.props.eventsUrl,
            data: {date: date},
            method: 'GET',
            dataType: 'json',
            cache: false,
            success: function(data) {
                this.setState({activity: data});
            }.bind(this),
            error: function(xhr, status, err) {
                console.error(status, err.toString());
            }.bind(this)
        });

    },

    formatDate: function(date) {
        return (date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate())
    },

    componentWillMount: function() {
        this.loadEventsFromServer(this.formatDate(this.props.date));
    },

    componentWillReceiveProps: function(nextProps) {
        this.replaceState(this.getInitialState());
        this.loadEventsFromServer(this.formatDate(nextProps.date));
    },

    componentDidUpdate: function() {
        $('.event-modal').leanModal();
    },

    render: function() {
        if (this.state.activity) {
            var projects = this.state.activity.projects,
                hasWorkedThatDay = _.any(projects, function (project) { return project.length > 0 }),
                content;

            if (hasWorkedThatDay) {
                content = _.compact(_.map(projects, function(project, projectName) {
                    if (project.length > 0) {
                        return <Project key={projectName} projectName={projectName} project={project} />
                    }
                }));
            } else {
                content = <p className="flow-text center bold">Taking it easy today!</p>
            }

            return <div className="card z-depth-4">
                <div className="card-content">
                    <div className="row">
                        {content}
                    </div>
                    <a className="absolute-btn-large event-modal btn-floating btn-large waves-effect waves-light blue" href="#new-event-form-container">
                        <i className="material-icons">add</i>
                    </a>
                </div>
            </div>
        }
        else {
            return <Loading/>;
        }
    }
});
