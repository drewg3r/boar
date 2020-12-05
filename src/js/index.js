const models = require('./models/index');

const userMapper = (user) => {
    console.log(user.UserId + ' | ' + user.username + ' | ' + user.email + ' | ' + user.avatar + ' | ');
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
    ProjectsList.map(projectMapper);

})();