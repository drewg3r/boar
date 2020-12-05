const connection = require('../connection');
const Sequelize = require('sequelize');
const User = require("./user");
const Project = require("./project");
const Role = require("./role");
const Access = require("./access");

Project.belongsToMany(User, {
    through: 'Access',
    timestamps: false,
    foreignKey: 'ProjectId'
});


User.belongsToMany(Project, {
    through: 'Access',
    timestamps: false,
    foreignKey: 'UserId'
});

Role.belongsToMany(User, {
    through: 'Access',
    timestamps: false,
    foreignKey: 'RoleId'
});

module.exports = {
    User,
    Project,
    Role,
    Access
};