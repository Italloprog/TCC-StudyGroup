"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.userRoutes = void 0;
const userController_1 = require("../controllers/userController");
const commonRoutes_1 = require("./commonRoutes");
class userRoutes extends commonRoutes_1.CommonRoutes {
    constructor(app) {
        super('Rotas de Usuários', app, '/usuarios');
    }
    configureRoutes() {
        const controller = new userController_1.userController();
        this.app.route(`${this.rota}/pesquisar`)
            .get((req, res) => controller.pesquisarUsuario(req, res));
        this.app.route(`${this.rota}/:id_Usuario`)
            .put((req, res) => controller.editarUsuario(req, res));
        return this.app;
    }
}
exports.userRoutes = userRoutes;
//# sourceMappingURL=userRoutes.js.map