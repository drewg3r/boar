const connection = require("../connection");
const Sequelize = require("sequelize");


const Model = Sequelize.Model;
class Project extends Model {}
Project.init({
    // attributes
    ProjectId: {
        type: Sequelize.INTEGER,
        allowNull: false,
        primaryKey: true
    }
}, {
    sequelize: connection,
    modelName: "Project",
    tableName: "Project",
    freezeTableName: true
    // options
});

module.exports = Project;