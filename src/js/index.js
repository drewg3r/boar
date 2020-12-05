const models = require('./models/index');

const userMapper = (user) => {
    console.log(user.UserId + ' | ' + user.username + ' | ' + user.email + ' | ');
};

const projectMapper = (project) => {
    console.log('#' + project.ProjectId + ' | ');
};


(async () => {
    console.log('--------');
    console.log('Users list');
    console.log('--------');
    const usersList = await models.User.findAll();
    usersList.map(userMapper);

    console.log('--------');
    console.log('Projects list');
    console.log('--------');
    const ProjectsList = await models.Project.findAll();
    usersList.map(projectMapper);


    console.log('\n\n--------');
    console.log('Project - User');
    console.log('--------');
    const projects = await models.Project.findAll({
        include: [{
            model: models.User,
            through: {
                attributes: ['ProjectId']
            }
        }]
    });
    projects.map(project => {
        console.log('#' + project.ProjectId + ' | ' );
    })
})();