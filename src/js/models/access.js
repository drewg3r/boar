const connection = require("../connection");
const Sequelize = require("sequelize");
const Project = require("./project");
const User = require("./user");
const Role = require("./role");


const Model = Sequelize.Model;
class Access extends Model {}
Access.init({
    // attributes
    ProjectId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
            model: Project,
            key: "ProjectId"
        }
    },
    UserId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
            model: User,
            key: "UserId"
        }
    },
    RoleId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
            model: Role,
            key: "RoleId"
        }
    }
}, {
    sequelize: connection,
    modelName: "Access",
    tableName: "Access",
    freezeTableName: true
    // options
});

/*
const Access = connection.define('access', {
    'ProjectId': { type: Sequelize.INTEGER, allowNull: false },
    'UserId':      { type: Sequelize.INTEGER, allowNull: false },
    'RoleId':      { type: Sequelize.INTEGER, allowNull: false }
});
*/

module.exports = Access;